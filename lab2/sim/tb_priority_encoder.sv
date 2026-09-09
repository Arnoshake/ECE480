`timescale 1ns / 1ps

module tb_priority_encoder();

    logic [3:0] req;
    logic [1:0] code;
    logic [1:0] expected_code;
    logic valid;
    logic expected_valid;

    priority_encoder dut(
        .req(req),
        .code(code),
        .valid(valid)
    );

    initial begin

        for (int i = 0; i < 16; i++) begin

            req = i;

            if (i >= 8) begin
                expected_code = 3;
            end
            else if (i >= 4) begin
                expected_code = 2;
            end
            else if (i >= 2) begin
                expected_code = 1;
            end
            else begin
                expected_code = 0;
            end

            expected_valid = (i != 0);

            #10;

            if ((expected_code != code) || (expected_valid != valid)) begin
                $display(
                    "FAIL: req=%b, expected code=%b valid=%b, got code=%b valid=%b",
                    req, expected_code, expected_valid, code, valid
                );
            end
            else begin
                $display(
                    "PASS: req=%b, code=%b, valid=%b",
                    req, code, valid
                );
            end

        end

        $display("All priority encoder tests completed.");
        $finish;

    end

endmodule
