`timescale 1ns / 1ps


module mux_if (
    input logic [3:0] d0,d1,d2,d3,
    input logic [1:0] sel,
    output logic [3:0] y
    
);
    always_comb begin
        if (sel == 2'b00) begin
            y = d0;
        end
        else if (sel == 2'b01) begin
            y = d1;
        end
        else if (sel == 2'b10) begin
            y = d2;
        end
        else begin // 2'b11
            y = d3;
        end

        
        
    end
    
endmodule
