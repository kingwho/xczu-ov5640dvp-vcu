`timescale 1ns / 1ps
//============================================================================
// ov5640_async_fifo.v
// 双时钟(格雷码指针)异步 FIFO, 用于 cam_pclk 像素流 -> aclk 写引擎 跨时钟域
// 支持 wr_flush / rd_flush 指针复位(清空), 分布式 RAM 实现
//============================================================================
module ov5640_async_fifo #(
    parameter integer DW = 24,              // 数据位宽
    parameter integer AW = 10               // 深度 2^AW
)(
    // 写侧 (源时钟域)
    input  wire          wr_clk,
    input  wire          wr_rstn,
    input  wire          wr_flush,          // 指针复位(清空), 已同步到 wr_clk
    input  wire          wr_en,
    input  wire [DW-1:0] din,
    output wire          full,
    // 读侧 (目的时钟域)
    input  wire          rd_clk,
    input  wire          rd_rstn,
    input  wire          rd_flush,          // 指针复位(清空), 已同步到 rd_clk
    input  wire          rd_en,
    output wire [DW-1:0] dout,
    output wire          empty
);

    (* ram_style = "distributed" *)
    reg [DW-1:0] mem [0:(1<<AW)-1];

    reg [AW:0] wptr_q, wgry_q;
    reg [AW:0] rptr_q, rgry_q;

    (* ASYNC_REG = "TRUE" *) reg [AW:0] rgry_sync1, rgry_sync2;  // 读指针灰码同步到写侧
    (* ASYNC_REG = "TRUE" *) reg [AW:0] wgry_sync1, wgry_sync2;  // 写指针灰码同步到读侧

    assign full  = (wgry_q == {~rgry_sync2[AW:AW-1], rgry_sync2[AW-2:0]});
    assign empty = (rgry_q == wgry_sync2);
    assign dout  = mem[rptr_q[AW-1:0]];

    wire [AW:0] wptr_next = wptr_q + 1'b1;
    wire [AW:0] rptr_next = rptr_q + 1'b1;
    wire        winc      = wr_en && !full;
    wire        rinc      = rd_en && !empty;

    always @(posedge wr_clk or negedge wr_rstn) begin
        if (!wr_rstn || wr_flush) begin
            wptr_q <= {(AW+1){1'b0}};
            wgry_q <= {(AW+1){1'b0}};
        end else if (winc) begin
            mem[wptr_q[AW-1:0]] <= din;
            wptr_q <= wptr_next;
            wgry_q <= (wptr_next >> 1) ^ wptr_next;
        end
    end

    always @(posedge wr_clk or negedge wr_rstn) begin
        if (!wr_rstn) begin
            rgry_sync1 <= {(AW+1){1'b0}};
            rgry_sync2 <= {(AW+1){1'b0}};
        end else begin
            rgry_sync1 <= rgry_q;
            rgry_sync2 <= rgry_sync1;
        end
    end

    always @(posedge rd_clk or negedge rd_rstn) begin
        if (!rd_rstn || rd_flush) begin
            rptr_q <= {(AW+1){1'b0}};
            rgry_q <= {(AW+1){1'b0}};
        end else if (rinc) begin
            rptr_q <= rptr_next;
            rgry_q <= (rptr_next >> 1) ^ rptr_next;
        end
    end

    always @(posedge rd_clk or negedge rd_rstn) begin
        if (!rd_rstn) begin
            wgry_sync1 <= {(AW+1){1'b0}};
            wgry_sync2 <= {(AW+1){1'b0}};
        end else begin
            wgry_sync1 <= wgry_q;
            wgry_sync2 <= wgry_sync1;
        end
    end

endmodule
