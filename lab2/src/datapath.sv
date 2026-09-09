`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2026 06:02:39 PM
// Design Name: 
// Module Name: datapath
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


module datapath (
    input logic [1:0] op,
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [3:0] result,
    output logic zero
);
    logic [3:0] mux_out;
    logic [3:0] A,B,C,D;
    assign A = a + b;
    assign B = a - b;
    assign C = a & b;
    assign D = a | b;
        
    mux_if mux_inst (
            .d0(A),
            .d1(B),
            .d2(C),
            .d3(D),
            .sel(op),
            .y(mux_out)
        );
    assign result = mux_out;
    assign zero = (result == 4'b0000);
endmodule
