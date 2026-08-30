`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2026 10:45:17 AM
// Design Name: 
// Module Name: top
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


module top(
    input logic [3:0] sw,
    output logic [2:0] led
    );
    logic [1:0] a, b;
    
    assign a = sw[1:0];
    assign b = sw[3:2];
    comparator2bit u0 (
        .a(a),
        .b(b),
        .aeqb(led[1]),
        .agtb(led[0]),
        .altb(led[2])
    );
endmodule
