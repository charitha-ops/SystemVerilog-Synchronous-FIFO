`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2026 10:44:10 AM
// Design Name: 
// Module Name: tb_sync_fifo
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



`timescale 1ns/1ps

module tb_sync_fifo;

    logic clk = 0;
    logic rst = 1;
    logic wr_en = 0, rd_en = 0;
    logic [7:0] din = 0;
    logic [7:0] dout;
    logic full, empty;

    always #5 clk = ~clk;

    sync_fifo dut (
        .clk(clk), .rst(rst),
        .wr_en(wr_en), .rd_en(rd_en),
        .din(din), .dout(dout),
        .full(full), .empty(empty)
    );

    task automatic write_data(input logic [7:0] data);
        @(negedge clk);
        wr_en = 1;
        din = data;
        @(negedge clk);
        wr_en = 0;
    endtask

    task automatic read_check(input logic [7:0] expected);
        @(negedge clk);
        rd_en = 1;
        #1;
        if (dout !== expected)
            $fatal(1, "Expected %h, got %h",
                   expected, dout);
        @(negedge clk);
        rd_en = 0;
    endtask

    initial begin
        repeat (2) @(negedge clk);
        rst = 0;

        if (!empty) $fatal(1, "FIFO should be empty");

        write_data(8'h11);
        write_data(8'h22);
        write_data(8'h33);

        if (empty) $fatal(1, "FIFO should not be empty");

        read_check(8'h11);
        read_check(8'h22);
        read_check(8'h33);

        if (!empty) $fatal(1, "FIFO should be empty again");

        // Fill all 8 entries
        for (int i = 0; i < 8; i++)
            write_data(8'h40 + i);

        if (!full) $fatal(1, "FIFO should be full");

        read_check(8'h40);

        if (full) $fatal(1, "FIFO should no longer be full");

        $display("PASS: FIFO basic tests completed");
        $finish;
    end

endmodule

