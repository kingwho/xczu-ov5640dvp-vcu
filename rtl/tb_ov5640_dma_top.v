`timescale 1ns / 1ps
//============================================================================
// tb_ov5640_dma_top.v - ov5640_dma_top 仿真
//  - 模拟 OV5640 DVP RGB565 时序 (vsync/href/8bit data, 高字节在前)
//  - AXI4-Lite 主端配置寄存器
//  - AXI4 写从端内存模型
//  - 校验: 帧完成中断 / STATUS 缓存轮转 (0->1->2->0) / DDR 像素数据正确
//============================================================================
module tb_ov5640_dma_top;

    // 可用 iverilog -Ptb_ov5640_dma_top.DW=... 覆盖, 覆盖不同 AXI 位宽/分辨率组合
    parameter integer DW = 64;               // DUT C_AXI_DATA_WIDTH: 32/64/128
    parameter integer TW = 64;               // 测试分辨率宽
    parameter integer TH = 32;               // 测试分辨率高
    parameter integer STALL = 0;             // 1: 随机背压 awready/wready

    localparam integer W = TW, H = TH;
    localparam integer BPB = DW / 8;         // 与 DUT C_AXI_DATA_WIDTH 对应
    localparam [31:0]  FRAME_SIZE = W * H * 3;
    localparam [31:0]  BUF0 = 32'h0010_0000;
    localparam [31:0]  BUF1 = 32'h0020_0000;
    localparam [31:0]  BUF2 = 32'h0030_0000;

    reg  aclk = 0, aresetn = 0;
    reg  cam_pclk = 0;
    always #5 aclk     = ~aclk;                       // 100 MHz
    always #7 cam_pclk = ~cam_pclk;                   // ~71 MHz

    reg  cam_vsync = 0, cam_href = 0;
    reg  [7:0] cam_data = 0;
    wire cam_rst_n, cam_pwdn;
    wire irq;

    // ---------------- AXI4-Lite ----------------
    reg  [11:0] axil_awaddr = 0;
    reg         axil_awvalid = 0;
    wire        axil_awready;
    reg  [31:0] axil_wdata = 0;
    reg  [3:0]  axil_wstrb = 4'hF;
    reg         axil_wvalid = 0;
    wire        axil_wready;
    wire [1:0]  axil_bresp;
    wire        axil_bvalid;
    reg         axil_bready = 1;
    reg  [11:0] axil_araddr = 0;
    reg         axil_arvalid = 0;
    wire        axil_arready;
    wire [31:0] axil_rdata;
    wire [1:0]  axil_rresp;
    wire        axil_rvalid;
    reg         axil_rready = 1;

    // ---------------- AXI4-Full 写通道 ----------------
    wire [31:0] awaddr;
    wire [7:0]  awlen;
    wire [2:0]  awsize;
    wire [1:0]  awburst;
    wire        awvalid;
    reg         awready = 1;
    wire [DW-1:0] wdata;
    wire [BPB-1:0] wstrb;
    wire        wlast, wvalid;
    reg         wready = 1;
    reg  [1:0]  bresp = 0;
    reg         bvalid = 0;
    wire        bready;

    // 随机背压: STALL=1 时 awready/wready 随机拉低
    initial begin
        if (STALL != 0) begin
            forever begin
                awready <= (($random % 4) != 0);
                wready  <= (($random % 4) != 0);
                @(posedge aclk);
            end
        end
    end

    integer errors = 0;
    reg     sim_done = 0;
    reg [31:0] rdata_r;

    // ---------------- DUT ----------------
    ov5640_dma_top #(
        .C_AXI_ADDR_WIDTH  (32),
        .C_AXI_DATA_WIDTH  (DW),
        .C_BURST_BEATS     (16),
        .C_FIFO_ADDR_WIDTH (10)
    ) dut (
        .aclk            (aclk),
        .aresetn         (aresetn),
        .s_axil_awaddr   (axil_awaddr),
        .s_axil_awprot   (3'd0),
        .s_axil_awvalid  (axil_awvalid),
        .s_axil_awready  (axil_awready),
        .s_axil_wdata    (axil_wdata),
        .s_axil_wstrb    (axil_wstrb),
        .s_axil_wvalid   (axil_wvalid),
        .s_axil_wready   (axil_wready),
        .s_axil_bresp    (axil_bresp),
        .s_axil_bvalid   (axil_bvalid),
        .s_axil_bready   (axil_bready),
        .s_axil_araddr   (axil_araddr),
        .s_axil_arprot   (3'd0),
        .s_axil_arvalid  (axil_arvalid),
        .s_axil_arready  (axil_arready),
        .s_axil_rdata    (axil_rdata),
        .s_axil_rresp    (axil_rresp),
        .s_axil_rvalid   (axil_rvalid),
        .s_axil_rready   (axil_rready),
        .m_axi_awaddr    (awaddr),
        .m_axi_awlen     (awlen),
        .m_axi_awsize    (awsize),
        .m_axi_awburst   (awburst),
        .m_axi_awvalid   (awvalid),
        .m_axi_awready   (awready),
        .m_axi_wdata     (wdata),
        .m_axi_wstrb     (wstrb),
        .m_axi_wlast     (wlast),
        .m_axi_wvalid    (wvalid),
        .m_axi_wready    (wready),
        .m_axi_bresp     (bresp),
        .m_axi_bvalid    (bvalid),
        .m_axi_bready    (bready),
        .irq             (irq),
        .cam_pclk        (cam_pclk),
        .cam_vsync       (cam_vsync),
        .cam_href        (cam_href),
        .cam_data        (cam_data),
        .cam_rst_n       (cam_rst_n),
        .cam_pwdn        (cam_pwdn)
    );

    // ---------------- AXI4 写从端内存模型 ----------------
    reg [7:0] mem [0:32'h003F_FFFF];
    reg [31:0] waddr = 0;
    reg [31:0] beats_left = 0;
    integer b;

    always @(posedge aclk) begin
        if (awvalid && awready) begin
            waddr      <= awaddr;
            beats_left <= awlen + 1;
        end
        if (wvalid && wready) begin
            for (b = 0; b < BPB; b = b + 1)
                if (wstrb[b]) mem[waddr + b] = wdata[8*b +: 8];
            if (beats_left == 1) begin
                if (!wlast) begin
                    errors = errors + 1;
                    $display("[%0t] ERR: wlast missing at addr %08x", $time, waddr);
                end
                bvalid <= 1;
            end
            beats_left <= beats_left - 1;
            waddr      <= waddr + BPB;
        end
        if (bvalid && bready) bvalid <= 0;
    end

    // ---------------- AXI-Lite 任务 ----------------
    task axil_write(input [11:0] addr, input [31:0] data);
        begin
            @(posedge aclk);
            axil_awaddr  <= addr;
            axil_wdata   <= data;
            axil_awvalid <= 1;
            axil_wvalid  <= 1;
            while (!(axil_awready && axil_wvalid)) @(posedge aclk);
            @(posedge aclk);
            axil_awvalid <= 0;
            axil_wvalid  <= 0;
            while (!axil_bvalid) @(posedge aclk);
            @(posedge aclk);
        end
    endtask

    task axil_read(input [11:0] addr, output [31:0] data);
        begin
            @(posedge aclk);
            axil_araddr  <= addr;
            axil_arvalid <= 1;
            while (!(axil_arready && axil_arvalid)) @(posedge aclk);
            @(posedge aclk);
            axil_arvalid <= 0;
            while (!axil_rvalid) @(posedge aclk);
            data = axil_rdata;
            @(posedge aclk);
        end
    endtask

    // ---------------- 摄像头模型 ----------------
    // 像素值 p = y*W + x, RGB565 = p[15:0], 高字节在前
    task send_frame;
        integer x, y, p;
        reg [15:0] rgb;
        begin
            cam_vsync <= 1;
            repeat (40) @(posedge cam_pclk);
            cam_vsync <= 0;
            repeat (10) @(posedge cam_pclk);
            for (y = 0; y < H; y = y + 1) begin
                cam_href <= 1;
                for (x = 0; x < W; x = x + 1) begin
                    p = y * W + x;
                    rgb = p[15:0];
                    cam_data <= rgb[15:8];
                    @(posedge cam_pclk);
                    cam_data <= rgb[7:0];
                    @(posedge cam_pclk);
                end
                cam_href <= 0;
                cam_data <= 0;
                repeat (8) @(posedge cam_pclk);
            end
        end
    endtask

    initial begin
        wait (aresetn);
        while (!sim_done) send_frame;
    end

    // ---------------- 帧数据校验 ----------------
    task check_frame(input [31:0] base, input integer fno);
        integer x, y, p, i;
        reg [15:0] rgb565;
        reg [23:0] rgb888;
        begin
            for (y = 0; y < H; y = y + 1) begin
                for (x = 0; x < W; x = x + 1) begin
                    p = y * W + x;
                    rgb565 = p[15:0];
                    rgb888 = {rgb565[15:11], 3'b0, rgb565[10:5], 2'b0, rgb565[4:0], 3'b0};
                    i = base + p * 3;
                    if (mem[i]   !== rgb888[23:16] ||
                        mem[i+1] !== rgb888[15:8]  ||
                        mem[i+2] !== rgb888[7:0]) begin
                        errors = errors + 1;
                        if (errors < 20)
                            $display("[%0t] ERR frame%0d pix(%0d,%0d): got %02x %02x %02x exp %02x %02x %02x",
                                     $time, fno, x, y,
                                     mem[i], mem[i+1], mem[i+2],
                                     rgb888[23:16], rgb888[15:8], rgb888[7:0]);
                    end
                end
            end
        end
    endtask

    task wait_irq_and_check(input integer expect_idx, input [31:0] base);
        integer t;
        begin
            t = 0;
            while (irq !== 1'b1 && t < 3000000) begin
                @(posedge aclk);
                t = t + 1;
            end
            if (irq !== 1'b1) begin
                errors = errors + 1;
                $display("[%0t] ERR: timeout waiting irq for frame buf %0d", $time, expect_idx);
            end
            axil_read(12'h04, rdata_r);
            if (rdata_r[6:4] !== expect_idx[2:0]) begin
                errors = errors + 1;
                $display("[%0t] ERR: didx=%0d expect %0d (status=%08x)",
                         $time, rdata_r[6:4], expect_idx, rdata_r);
            end
            check_frame(base, expect_idx);
            axil_write(12'h08, 32'h1);      // W1C 清中断
        end
    endtask

    // ---------------- 主流程 ----------------
    initial begin
        repeat (20) @(posedge aclk);
        aresetn = 1;
        repeat (10) @(posedge aclk);

        // 配置 3 块缓存地址
        axil_write(12'h1C, BUF0);  axil_write(12'h20, 32'd0);
        axil_write(12'h24, BUF1);  axil_write(12'h28, 32'd0);
        axil_write(12'h2C, BUF2);  axil_write(12'h30, 32'd0);
        // 分辨率/帧大小/缓存数
        axil_write(12'h0C, W);
        axil_write(12'h10, H);
        axil_write(12'h14, FRAME_SIZE);
        axil_write(12'h18, 32'd3);
        // 软复位后启动
        axil_write(12'h00, 32'h4);          // SRST
        axil_write(12'h00, 32'h3);          // RUN | IRQ_EN

        // 采 4 帧, 验证缓存轮转 0 -> 1 -> 2 -> 0
        wait_irq_and_check(0, BUF0);
        $display("[%0t] frame 0 -> BUF0 OK", $time);
        wait_irq_and_check(1, BUF1);
        $display("[%0t] frame 1 -> BUF1 OK", $time);
        wait_irq_and_check(2, BUF2);
        $display("[%0t] frame 2 -> BUF2 OK", $time);
        wait_irq_and_check(0, BUF0);
        $display("[%0t] frame 3 -> BUF0 OK", $time);

        // 停止, 验证 busy 清零
        axil_write(12'h00, 32'h0);
        repeat (20) @(posedge aclk);
        axil_read(12'h04, rdata_r);
        if (rdata_r[0] !== 1'b0) begin
            errors = errors + 1;
            $display("[%0t] ERR: busy not cleared after stop", $time);
        end

        if (errors == 0) $display("TB PASS");
        else             $display("TB FAIL: %0d errors", errors);
        sim_done = 1;
        #200 $finish;
    end

    // 看门狗
    initial begin
        #20_000_000;
        $display("TB TIMEOUT");
        $finish(1);
    end

endmodule
