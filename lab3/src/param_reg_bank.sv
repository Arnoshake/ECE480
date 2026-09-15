`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2026 10:04:58 AM
// Design Name: 
// Module Name: param_reg_bank
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


module param_reg_bank #(
    parameter int M = 4, // register amnt
    parameter int W = 8 // register width
)(
    input logic                 clk,rst,wr_en,
    input logic [$clog2(M)-1:0] rd_addr, wr_addr,
    input logic [W-1:0] wr_data,
    output logic [W-1:0]        rd_data
    

    );
    logic [W-1:0] regs [0:M-1];
    assign rd_data = regs[rd_addr];
    
    always_ff @(posedge clk) begin
        if (rst) begin
            for (int r = 0; r < M; r++) begin
                regs[r] <= '0;
            end
        end else if (wr_en) begin
            regs[wr_addr] <= wr_data;
        end
    end
    
    
endmodule
