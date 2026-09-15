`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2026 10:49:57 AM
// Design Name: 
// Module Name: N_counter
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


module N_counter #(parameter WIDTH = 4)(
    input logic rst,en,up,clk,
    output logic [WIDTH-1:0] q
    );
    always_ff @(posedge clk) begin
       
        if (rst) begin
            q <= '0;
        end
        else  if (en == 0) begin
            q <= q;
        end
        else if (up) begin
            q <= q + 1;
        end
        else begin
            q <= q - 1;
        end
    end
    
endmodule
