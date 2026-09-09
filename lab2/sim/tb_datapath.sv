`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/08/2026 06:01:56 PM
// Design Name:
// Module Name: tb_datapath
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

module tb_datapath();

    logic [3:0] tb_A, tb_B, expected;
    logic [1:0] op;
    logic [3:0] result;
    logic zf;
    logic expected_zf;

    integer i;
    integer j;
    integer k;

    datapath DUT (
        .a(tb_A),
        .b(tb_B),
        .op(op),
        .result(result),
        .zero(zf)
    );

    initial begin

        tb_A = 0;
        tb_B = 0;
        op   = 0;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 4; k = k + 1) begin

                    tb_A = i;
                    tb_B = j;
                    op   = k;

                    #10;

                    case (op)
                        2'b00: expected = tb_A + tb_B;
                        2'b01: expected = tb_A - tb_B;
                        2'b10: expected = tb_A & tb_B;
                        2'b11: expected = tb_A | tb_B;
                    endcase

                    expected_zf = (expected == 4'b0000);

                    if (expected != result) begin
                        $error(
                            "FAILED: A=%b B=%b op=%b expected=%b result=%b",
                            tb_A, tb_B, op, expected, result
                        );
                    end

                    if (expected_zf != zf) begin
                        $error(
                            "FAILED: A=%b B=%b op=%b expected_zero=%b zero=%b",
                            tb_A, tb_B, op,expected_zf, zf
                        );
                    end

                    if ((expected == result) && (expected_zf == zf)) begin
                        $display(
                            "PASSED: A=%b B=%b op=%b result=%b zero=%b",
                            tb_A, tb_B, op, result, zf
                        );
                    end

                end
            end
        end

        $display("======================================");
        $display("All tests completed.");
        $display("======================================");

        $finish;

    end

endmodule
