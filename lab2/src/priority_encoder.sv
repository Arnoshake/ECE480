`timescale 1ns / 1ps


module priority_encoder (
    input logic [3:0] req,
    output logic [1:0] code,
    output logic      valid
    
);
    always_comb begin
        valid = |req;
        code = 2'b00; //default
        unique casez(req)
            4'b1???: code = 2'b11;
            4'b01??: code = 2'b10;
            4'b001?: code = 2'b01;
            4'b0001: code = 2'b00;
            
        endcase
    end
    
endmodule
