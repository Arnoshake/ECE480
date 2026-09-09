`timescale 1ns / 1ps

module tb_N_decoder;

    logic [1:0] a1;
    logic [3:0] y1;
    logic [3:0] expected1;
    
    logic [2:0] a2;
    logic [7:0] y2;
    logic [7:0] expected2;

    N_decoder #(.N(2)) DUT1 (
        .a(a1),
        .y(y1)
    );

    N_decoder #(.N(3)) DUT2 (
        .a(a2),
        .y(y2)
    );

    logic [7:0] expected [0:7];

    initial begin
        expected[0] = 8'b0000_0001;
        expected[1] = 8'b0000_0010;
        expected[2] = 8'b0000_0100;
        expected[3] = 8'b0000_1000;
        expected[4] = 8'b0001_0000;
        expected[5] = 8'b0010_0000;
        expected[6] = 8'b0100_0000;
        expected[7] = 8'b1000_0000;

        // N = 2 
        for (int i = 0; i < 4; i++) begin
            a1 = i;
            expected1 = expected[i][3:0];
            #10;

            if (y1 != expected1) begin
                $error("N=2 FAILED: a1=%b, expected y1=%b, got y1=%b",a1,expected1,y1);
            end
            else begin
                $display("N=2 PASSED: a1=%b, y1=%b",a1,y1);
            end
        end

        $display("Testing for N=2 Complete!");


        // N = 3 
        for (int i = 0; i < 8; i++) begin
            a2 = i;
            expected2 = expected[i];
            #10;

            if (y2 != expected2) begin
                $error(
                    "N=3 FAILED: a2=%b, expected y2=%b, got y2=%b",a2,expected2,y2);
            end
            else begin
                $display("N=3 PASSED: a2=%b, y2=%b",a2,y2);
            end
        end

        $display("Testing for N=3 Complete!");
        $display("EOT");

        $finish;
    end

endmodule
