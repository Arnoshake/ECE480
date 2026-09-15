`timescale 1ns / 1ps

module tick_generator #(parameter int CYCLES = 100)(
input logic clk, rst,
output logic tick
);
    localparam int COUNT_W = $clog2(CYCLES);
    logic [COUNT_W-1:0] count;
    always_ff @(posedge clk) begin
        if (rst) begin
            count <= '0;
            tick <= 1'b0;
        end else if (count == CYCLES-1) begin
            count <= '0;
            tick <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick <= 1'b0;
        end
    end
endmodule
