`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2026 09:32:33 AM
// Design Name: 
// Module Name: N_decoder
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


module N_decoder #(parameter N = 4)(
    input logic [N-1:0] a,
    output logic [2**N-1:0] y
    
    );
  
    always_comb begin
        y = 1 << (a);
    end

endmodule
