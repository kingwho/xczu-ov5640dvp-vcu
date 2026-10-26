`timescale 1ns / 1ps
//============================================================================
// ov5640_dma_top.v
// OV5640 DVP (RGB565) -> RGB888 -> AXI4-Full 写 DDR 采集 IP 顶层
//
// 结构:
//   ov5640_capture_data (pclk 域, RGB565->RGB888)
//     -> 24bit 像素异步 FIFO (cam_pclk -> aclk)
//     -> 写引擎: 像素按字节流装配成 AXI 数据拍, INCR 突发写入 DDR
//   AXI4-Lite 从机: 分辨率/帧大小/缓存数/缓存地址配置, 启停, 帧完成中断
//
// 寄存器映射与 driver/ov5640_dma.h 严格一致:
//   0x00 CTRL  bit0 采集使能  bit1 中断使能  bit2 软复位(自清零)
//   0x04 STATUS bit0 忙 [3:1] 正在写的缓存号 [6:4] 最近写完的缓存号
//   0x08 IRQ_STATUS bit0 帧完成, W1C
//   0x0C WIDTH / 0x10 HEIGHT / 0x14 FRAME_SIZE / 0x18 BUF_NUM(1~3)
//   0x1C~0x30 BUFx_LO / BUFx_HI (3 块缓存 DDR 地址)
//
// 注意:
//   - FRAME_SIZE 必须等于 WIDTH*HEIGHT*3, 且与传感器实际输出一致
//   - aclk 频率建议 >= PCLK (像素以 PCLK/2 速率到达, 引擎每 2 个 aclk 消费 1 像素)
//============================================================================
module ov5640_dma_top #(
    parameter integer C_AXI_ADDR_WIDTH  = 32,    // 32/64
    parameter integer C_AXI_DATA_WIDTH  = 64,    // 32/64/128
    parameter integer C_BURST_BEATS     = 16,    // 每次突发 beat 数, <=16 兼容 AXI3
    parameter integer C_FIFO_ADDR_WIDTH = 10     // 像素 FIFO 深度 2^10
)(
    input  wire                          aclk,
    input  wire                          aresetn,

    // ---------------- AXI4-Lite 从机 ----------------
    input  wire [11:0]                   s_axil_awaddr,
    input  wire [2:0]                    s_axil_awprot,
    input  wire                          s_axil_awvalid,
    output reg                           s_axil_awready,
    input  wire [31:0]                   s_axil_wdata,
    input  wire [3:0]                    s_axil_wstrb,
    input  wire                          s_axil_wvalid,
    output reg                           s_axil_wready,
    output reg  [1:0]                    s_axil_bresp,
    output reg                           s_axil_bvalid,
    input  wire                          s_axil_bready,
    input  wire [11:0]                   s_axil_araddr,
    input  wire [2:0]                    s_axil_arprot,
    input  wire                          s_axil_arvalid,
    output reg                           s_axil_arready,
    output reg  [31:0]                   s_axil_rdata,
    output reg  [1:0]                    s_axil_rresp,
    output reg                           s_axil_rvalid,
    input  wire                          s_axil_rready,

    // ---------------- AXI4-Full 主机 (仅写通道) ----------------
    output reg  [C_AXI_ADDR_WIDTH-1:0]   m_axi_awaddr,
    output reg  [7:0]                    m_axi_awlen,
    output wire [2:0]                    m_axi_awsize,
    output wire [1:0]                    m_axi_awburst,
    output reg                           m_axi_awvalid,
    input  wire                          m_axi_awready,
    output wire [C_AXI_DATA_WIDTH-1:0]   m_axi_wdata,
    output wire [C_AXI_DATA_WIDTH/8-1:0] m_axi_wstrb,
    output wire                          m_axi_wlast,
    output wire                          m_axi_wvalid,
    input  wire                          m_axi_wready,
    input  wire [1:0]                    m_axi_bresp,
    input  wire                          m_axi_bvalid,
    output wire                          m_axi_bready,

    output wire                          irq,

    // ---------------- 摄像头 DVP 接口 ----------------
    input  wire                          cam_pclk,
    input  wire                          cam_vsync,
    input  wire                          cam_href,
    input  wire [7:0]                    cam_data,
    output wire                          cam_rst_n,
    output wire                          cam_pwdn
);

    localparam integer BPB = C_AXI_DATA_WIDTH / 8;   // bytes per beat
    localparam [5:0]  BPB6 = BPB;
    localparam [31:0] BURST_MAX = C_BURST_BEATS;

    function integer clog2;
        input integer value;
        integer v;
        begin
            v = value - 1;
            for (clog2 = 0; v > 0; clog2 = clog2 + 1) v = v >> 1;
        end
    endfunction

    wire [31:0] awsize_c = clog2(BPB);
    assign m_axi_awsize  = awsize_c[2:0];
    assign m_axi_awburst = 2'b01;                    // INCR
    assign m_axi_bready  = 1'b1;

    // =====================================================================
    // 采集模块 (pclk 域)
    // =====================================================================
    wire        cap_clk, cap_ce, cap_vsync, cap_active;
    wire [23:0] cap_data;

    ov5640_capture_data u_capture (
        .rst_n             (aresetn),
        .cam_pclk          (cam_pclk),
        .cam_vsync         (cam_vsync),
        .cam_href          (cam_href),
        .cam_data          (cam_data),
        .cam_rst_n         (cam_rst_n),
        .cam_pwdn          (cam_pwdn),
        .cmos_frame_clk    (cap_clk),
        .cmos_frame_ce     (cap_ce),
        .cmos_frame_vsync  (cap_vsync),
        .cmos_active_video (cap_active),
        .cmos_frame_data   (cap_data)
    );

    // pclk 域复位同步 (异步复位, 同步释放)
    (* ASYNC_REG = "TRUE" *) reg [1:0] rstn_pclk_r;
    always @(posedge cam_pclk or negedge aresetn) begin
        if (!aresetn) rstn_pclk_r <= 2'b00;
        else          rstn_pclk_r <= {rstn_pclk_r[0], 1'b1};
    end
    wire rstn_pclk = rstn_pclk_r[1];

    // =====================================================================
    // 像素异步 FIFO (cam_pclk -> aclk)
    // =====================================================================
    wire        fifo_empty, fifo_full;
    wire [23:0] fifo_dout;
    wire        wr_flush, rd_flush;

    ov5640_async_fifo #(
        .DW (24),
        .AW (C_FIFO_ADDR_WIDTH)
    ) u_pix_fifo (
        .wr_clk   (cam_pclk),
        .wr_rstn  (rstn_pclk),
        .wr_flush (wr_flush),
        .wr_en    (cap_ce && cap_active),
        .din      (cap_data),
        .full     (fifo_full),
        .rd_clk   (aclk),
        .rd_rstn  (aresetn),
        .rd_flush (rd_flush),
        .rd_en    (load_pix),
        .dout     (fifo_dout),
        .empty    (fifo_empty)
    );

    // =====================================================================
    // 配置寄存器 (AXI-Lite 写)
    // =====================================================================
    reg          run_q, irq_en_q, srst_q, irq_sts_q;
    reg [31:0]   width_q, height_q, frame_size_q;
    reg [2:0]    buf_num_q;
    reg [31:0]   buf_lo_q [0:2];
    reg [31:0]   buf_hi_q [0:2];

    wire         axil_wren;

    always @(posedge aclk) begin
        if (!aresetn) begin
            run_q        <= 1'b0;
            irq_en_q     <= 1'b0;
            srst_q       <= 1'b0;
            irq_sts_q    <= 1'b0;
            width_q      <= 32'd0;
            height_q     <= 32'd0;
            frame_size_q <= 32'd0;
            buf_num_q    <= 3'd1;
            buf_lo_q[0]  <= 32'd0;  buf_hi_q[0] <= 32'd0;
            buf_lo_q[1]  <= 32'd0;  buf_hi_q[1] <= 32'd0;
            buf_lo_q[2]  <= 32'd0;  buf_hi_q[2] <= 32'd0;
        end else begin
            srst_q <= 1'b0;
            if (axil_wren) begin
                case (s_axil_awaddr[7:2])
                    5'd0: begin
                        run_q    <= s_axil_wdata[0];
                        irq_en_q <= s_axil_wdata[1];
                        if (s_axil_wdata[2]) srst_q <= 1'b1;
                    end
                    5'd2:  irq_sts_q <= irq_sts_q & ~s_axil_wdata[0];  // W1C
                    5'd3:  if (!busy_q) width_q      <= s_axil_wdata;
                    5'd4:  if (!busy_q) height_q     <= s_axil_wdata;
                    5'd5:  if (!busy_q) frame_size_q <= s_axil_wdata;
                    5'd6:  if (!busy_q) buf_num_q    <= (s_axil_wdata[2:0] == 3'd0) ? 3'd1
                                                                       : s_axil_wdata[2:0];
                    5'd7:  buf_lo_q[0] <= s_axil_wdata;
                    5'd8:  buf_hi_q[0] <= s_axil_wdata;
                    5'd9:  buf_lo_q[1] <= s_axil_wdata;
                    5'd10: buf_hi_q[1] <= s_axil_wdata;
                    5'd11: buf_lo_q[2] <= s_axil_wdata;
                    5'd12: buf_hi_q[2] <= s_axil_wdata;
                    default: ;
                endcase
            end
            if (frame_done_ev)
                irq_sts_q <= 1'b1;
        end
    end

    assign irq = irq_en_q && irq_sts_q;

    // =====================================================================
    // 写引擎 (aclk 域): 像素字节流 -> AXI 突发写
    // =====================================================================
    reg         busy_q;
    reg [2:0]   widx_q, didx_q;
    reg [31:0]  beats_done_q;     // W 通道已完成的 beat 数
    reg [31:0]  aw_covered_q;     // 已发出 AW 覆盖的 beat 数
    reg [31:0]  aw_acc_q;         // AW 已被接受覆盖的 beat 数
    reg [63:0]  base_addr_q;      // 当前帧缓存基地址
    reg [C_AXI_DATA_WIDTH-1:0] wbuf_q;   // beat 装配寄存器
    reg [5:0]   byte_cnt_q;       // 当前 beat 已装配字节数
    reg [23:0]  pix_sh_q;         // 像素字节序列化器
    reg [1:0]   pix_left_q;       // 序列化器剩余字节数

    wire [31:0] beats_total = (frame_size_q + BPB - 1) / BPB;
    wire        last_beat   = (beats_done_q == beats_total - 32'd1);
    wire [31:0] rem_bytes   = frame_size_q - beats_done_q * BPB;

    // 每周期最多向 beat 装配 2 字节; 装载新像素时可直通其首字节,
    // 保证 2 个 aclk 消费 1 像素 (aclk 需 >= 2 倍像素速率, 即 >= PCLK)
    wire        load_pix = busy_q && (pix_left_q == 2'd0) && !fifo_empty;
    wire [5:0]  space_w  = (byte_cnt_q >= BPB6) ? 6'd0 : (BPB6 - byte_cnt_q);
    wire [5:0]  rem6     = rem_bytes[5:0];
    wire [5:0]  want_w   = last_beat ?
                           ((byte_cnt_q >= rem6) ? 6'd0 : (rem6 - byte_cnt_q)) : 6'd2;
    wire [5:0]  eff_w    = (space_w < want_w) ? space_w : want_w;
    wire [5:0]  src_cnt  = load_pix ? 6'd3 : {4'd0, pix_left_q};
    wire [5:0]  n_w      = (eff_w < src_cnt) ? eff_w : src_cnt;
    wire        take2    = (n_w >= 6'd2);
    wire        take1    = (n_w == 6'd1);
    wire [23:0] src_data = load_pix ? fifo_dout : pix_sh_q;

    wire        beat_full   = (byte_cnt_q == BPB);
    wire        final_ready = last_beat && (byte_cnt_q == rem_bytes);
    wire        beat_ready  = beat_full || final_ready;
    wire        beat_aw_ok  = (beats_done_q < aw_acc_q);

    wire        wvalid_w      = busy_q && beat_ready && beat_aw_ok;
    wire        w_fire        = wvalid_w && m_axi_wready;
    wire        frame_done_ev = w_fire && last_beat;
    wire        stop_event    = busy_q && !run_q;

    assign m_axi_wvalid = wvalid_w;
    // 非整拍的最后一拍: 装配数据位于档位 BPB-N..BPB-1, 右移到 0..N-1
    wire [31:0] wdata_shift = (last_beat && (rem_bytes < BPB)) ?
                              (8 * (BPB - rem_bytes)) : 32'd0;
    assign m_axi_wdata  = wbuf_q >> wdata_shift;
    assign m_axi_wlast  = (beats_done_q + 32'd1 == aw_acc_q);

    wire [BPB-1:0] wstrb_full = {BPB{1'b1}};
    assign m_axi_wstrb = last_beat ? (wstrb_full >> (BPB - rem_bytes)) : wstrb_full;

    wire [31:0] beats_remain = beats_total - beats_done_q;
    wire [31:0] burst_beats  = (beats_remain < BURST_MAX) ? beats_remain : BURST_MAX;
    wire [63:0] beat_off     = beats_done_q * BPB;
    wire [63:0] aw_addr64    = base_addr_q + beat_off;

    wire aw_go = busy_q && !m_axi_awvalid &&
                 (beats_done_q < beats_total) &&
                 (aw_covered_q == beats_done_q) &&
                 beat_ready;

    wire [2:0] widx_start = (widx_q >= buf_num_q) ? 3'd0 : widx_q;
    wire [2:0] widx_next  = (widx_start + 3'd1 >= buf_num_q) ? 3'd0 : widx_start + 3'd1;

    always @(posedge aclk) begin
        if (!aresetn || srst_q) begin
            busy_q        <= 1'b0;
            widx_q        <= 3'd0;
            didx_q        <= 3'd0;
            beats_done_q  <= 32'd0;
            aw_covered_q  <= 32'd0;
            aw_acc_q      <= 32'd0;
            byte_cnt_q    <= 6'd0;
            pix_sh_q      <= 24'd0;
            pix_left_q    <= 2'd0;
            base_addr_q   <= 64'd0;
            wbuf_q        <= {C_AXI_DATA_WIDTH{1'b0}};
            m_axi_awvalid <= 1'b0;
            m_axi_awaddr  <= {C_AXI_ADDR_WIDTH{1'b0}};
            m_axi_awlen   <= 8'd0;
        end else begin
            // 像素装载(可直通首字节) 与 beat 字节装配
            if (load_pix) begin
                if (take2) begin
                    pix_sh_q   <= {fifo_dout[7:0], 16'd0};
                    pix_left_q <= 2'd1;
                end else if (take1) begin
                    pix_sh_q   <= {fifo_dout[15:0], 8'd0};
                    pix_left_q <= 2'd2;
                end else begin
                    pix_sh_q   <= fifo_dout;
                    pix_left_q <= 2'd3;
                end
            end else begin
                if (take2) begin
                    pix_sh_q   <= {pix_sh_q[7:0], 16'd0};
                    pix_left_q <= pix_left_q - 2'd2;
                end else if (take1) begin
                    pix_sh_q   <= {pix_sh_q[15:0], 8'd0};
                    pix_left_q <= pix_left_q - 2'd1;
                end
            end

            // 新字节从高位插入, 旧字节下移: 第 k 字节位于 wdata 档位 BPB-N+k
            // (N 为该拍实际字节数; 非整拍输出时统一右移补齐, 见 wdata_shift)
            if (take2)
                wbuf_q <= {src_data[15:8], src_data[23:16],
                           wbuf_q[C_AXI_DATA_WIDTH-1:16]};
            else if (take1)
                wbuf_q <= {src_data[23:16], wbuf_q[C_AXI_DATA_WIDTH-1:8]};

            if (take2)
                byte_cnt_q <= byte_cnt_q + 6'd2;
            else if (take1)
                byte_cnt_q <= byte_cnt_q + 6'd1;

            // W 通道
            if (w_fire) begin
                beats_done_q <= beats_done_q + 32'd1;
                byte_cnt_q   <= 6'd0;
            end

            // AW 通道: 每个突发首拍就绪时发地址
            if (aw_go) begin
                m_axi_awvalid <= 1'b1;
                m_axi_awaddr  <= aw_addr64[C_AXI_ADDR_WIDTH-1:0];
                m_axi_awlen   <= burst_beats - 32'd1;
                aw_covered_q  <= beats_done_q + burst_beats;
            end else if (m_axi_awvalid && m_axi_awready) begin
                m_axi_awvalid <= 1'b0;
            end
            if (m_axi_awvalid && m_axi_awready)
                aw_acc_q <= aw_covered_q;

            // 帧启动: FIFO 出现有效像素
            if (!busy_q && run_q && !fifo_empty &&
                (frame_size_q != 32'd0) && (buf_num_q != 3'd0)) begin
                busy_q       <= 1'b1;
                beats_done_q <= 32'd0;
                aw_covered_q <= 32'd0;
                aw_acc_q     <= 32'd0;
                byte_cnt_q   <= 6'd0;
                pix_left_q   <= 2'd0;
                base_addr_q  <= {buf_hi_q[widx_start], buf_lo_q[widx_start]};
                widx_q       <= widx_start;
            end

            // 帧完成: 最后一拍写出
            if (frame_done_ev) begin
                busy_q <= 1'b0;
                didx_q <= widx_q;
                widx_q <= widx_next;
            end

            // 停止: RUN 拉低
            if (stop_event) begin
                busy_q        <= 1'b0;
                m_axi_awvalid <= 1'b0;
            end
        end
    end

    // =====================================================================
    // FIFO 清空: 停止 / 软复位时丢弃残留像素
    // (帧完成时不 flush: FIFO 中已是下一帧的先头像素, 保留以保证帧间无缝衔接)
    // =====================================================================
    reg        flush_tgl_q, flush_tgl_d;
    (* ASYNC_REG = "TRUE" *) reg [2:0] flush_sync_p;

    always @(posedge aclk) begin
        if (!aresetn) begin
            flush_tgl_q <= 1'b0;
            flush_tgl_d <= 1'b0;
        end else begin
            flush_tgl_d <= flush_tgl_q;
            if (srst_q || stop_event)
                flush_tgl_q <= ~flush_tgl_q;
        end
    end
    assign rd_flush = flush_tgl_q ^ flush_tgl_d;

    always @(posedge cam_pclk or negedge aresetn) begin
        if (!aresetn) flush_sync_p <= 3'b000;
        else          flush_sync_p <= {flush_sync_p[1:0], flush_tgl_q};
    end
    assign wr_flush = flush_sync_p[2] ^ flush_sync_p[1];

    // =====================================================================
    // AXI4-Lite 从机接口
    // =====================================================================
    assign axil_wren = s_axil_awready && s_axil_wready &&
                       s_axil_awvalid && s_axil_wvalid;

    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axil_awready <= 1'b0;
            s_axil_wready  <= 1'b0;
            s_axil_bvalid  <= 1'b0;
            s_axil_bresp   <= 2'b00;
        end else begin
            if (!s_axil_awready && s_axil_awvalid && s_axil_wvalid) begin
                s_axil_awready <= 1'b1;
                s_axil_wready  <= 1'b1;
            end else begin
                s_axil_awready <= 1'b0;
                s_axil_wready  <= 1'b0;
            end
            if (s_axil_bvalid && s_axil_bready)
                s_axil_bvalid <= 1'b0;
            else if (axil_wren)
                s_axil_bvalid <= 1'b1;
        end
    end

    function [31:0] rd_mux;
        input [11:0] a;
        begin
            case (a[7:2])
                5'd0:  rd_mux = {29'd0, irq_en_q, run_q};
                5'd1:  rd_mux = {24'd0, didx_q, widx_q, busy_q};
                5'd2:  rd_mux = {31'd0, irq_sts_q};
                5'd3:  rd_mux = width_q;
                5'd4:  rd_mux = height_q;
                5'd5:  rd_mux = frame_size_q;
                5'd6:  rd_mux = {29'd0, buf_num_q};
                5'd7:  rd_mux = buf_lo_q[0];
                5'd8:  rd_mux = buf_hi_q[0];
                5'd9:  rd_mux = buf_lo_q[1];
                5'd10: rd_mux = buf_hi_q[1];
                5'd11: rd_mux = buf_lo_q[2];
                5'd12: rd_mux = buf_hi_q[2];
                default: rd_mux = 32'd0;
            endcase
        end
    endfunction

    reg [11:0] araddr_q;

    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axil_arready <= 1'b0;
            s_axil_rvalid  <= 1'b0;
            s_axil_rdata   <= 32'd0;
            s_axil_rresp   <= 2'b00;
            araddr_q       <= 12'd0;
        end else begin
            if (!s_axil_arready && s_axil_arvalid && !s_axil_rvalid) begin
                s_axil_arready <= 1'b1;
                araddr_q       <= s_axil_araddr;
            end else begin
                s_axil_arready <= 1'b0;
            end
            if (s_axil_arready && s_axil_arvalid) begin
                s_axil_rvalid <= 1'b1;
                s_axil_rdata  <= rd_mux(s_axil_araddr);
            end else if (s_axil_rvalid && s_axil_rready) begin
                s_axil_rvalid <= 1'b0;
            end
        end
    end

endmodule
