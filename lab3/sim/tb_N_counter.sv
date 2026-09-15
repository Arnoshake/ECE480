`timescale 1ns / 1ps

module tb_N_counter();

    logic clk = 0;
    logic rst, en, up;
    logic [3:0] q1;
    logic [7:0] q2;

    logic [3:0] expected_q1 = '0;
    logic [7:0] expected_q2 = '0;
    
    int err_cnt = 0;
    int cycle_cnt = 0;

    N_counter #(.WIDTH(4)) DUT4 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .up(up),
        .q(q1)
    );

    N_counter #(.WIDTH(8)) DUT8 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .up(up),
        .q(q2)
    );

    always #5 clk = ~clk;

    // Reference model & assertions
    always @(posedge clk) begin
        cycle_cnt++;

        if (rst) begin
            expected_q1 = 4'd0;
            expected_q2 = 8'd0;
        end else if (en) begin
            expected_q1 = up ? (expected_q1 + 4'd1) : (expected_q1 - 4'd1);
            expected_q2 = up ? (expected_q2 + 8'd1) : (expected_q2 - 8'd1);
        end

        #1; // Sample after clock-to-out

        if (q1 !== expected_q1) begin
            $display("[ERROR @ %0t ns] DUT4: got %0d, expected %0d (rst=%b en=%b up=%b)", 
                     $time, q1, expected_q1, rst, en, up);
            err_cnt++;
        end

        if (q2 !== expected_q2) begin
            $display("[ERROR @ %0t ns] DUT8: got %0d, expected %0d (rst=%b en=%b up=%b)", 
                     $time, q2, expected_q2, rst, en, up);
            err_cnt++;
        end
    end

    // Stimulus sequence
    initial begin
        // Init & Reset
        rst = 1; en = 0; up = 1;
        @(negedge clk);

        // Count up
        rst = 0; en = 1; up = 1;
        repeat (5) @(negedge clk);

        // Enable disabled (hold)
        en = 0;
        repeat (3) @(negedge clk);

        // Count down
        en = 1; up = 0;
        repeat (4) @(negedge clk);

        // Synchronous reset
        rst = 1; en = 1;
        @(negedge clk);

        // Underflow test (0 -> max)
        rst = 0; en = 1; up = 0;
        repeat (2) @(negedge clk);

        // Overflow test (max -> 0)
        rst = 1;
        @(negedge clk);
        rst = 0; up = 1; en = 1;
        repeat (17)  @(negedge clk);  // Rolls over 4-bit DUT
        repeat (250) @(negedge clk);  // Rolls over 8-bit DUT

        @(negedge clk);

        // Summary log
        $display("\n----------------------------------------");
        $display("tb_N_counter finished at %0t ns (%0d cycles)", $time, cycle_cnt);
        if (err_cnt == 0) begin
            $display("PASS: All checks passed (0 mismatches)");
        end else begin
            $display("FAIL: %0d mismatch(es) detected", err_cnt);
        end
        $display("----------------------------------------\n");

        $finish;
    end
endmodule