`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2026 10:42:12 AM
// Design Name: 
// Module Name: sync_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter PTR_WIDTH = $clog2(DEPTH)
)(
    input  logic clk,
    input  logic rst,
    input  logic wr_en,
    input  logic rd_en,
    input  logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout,
    output logic full,
    output logic empty
);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
    logic [PTR_WIDTH:0] count;

    logic wr_accept, rd_accept;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    assign rd_accept = rd_en && !empty;
    assign wr_accept = wr_en && (!full || rd_accept);

    assign dout = mem[rd_ptr];

    always_ff @(posedge clk) begin
        if (rst) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
        end else begin
            if (wr_accept) begin
                mem[wr_ptr] <= din;
                wr_ptr <= (wr_ptr == DEPTH-1)
                        ? '0 : wr_ptr + 1'b1;
            end

            if (rd_accept)
                rd_ptr <= (rd_ptr == DEPTH-1)
                        ? '0 : rd_ptr + 1'b1;

            case ({wr_accept, rd_accept})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end

endmodule


