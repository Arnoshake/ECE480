`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2026 10:49:27 AM
// Design Name: 
// Module Name: tb_param_reg_bank
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


module tb_param_reg_bank;
    logic clk = 0;
    logic rst;

    // DUT 1 Signals: M = 4, W = 8 
    logic                     wr_en1;
    logic [$clog2(4)-1:0]     rd_addr1; // [1:0]
    logic [$clog2(4)-1:0]     wr_addr1; // [1:0]
    logic [7:0]               wr_data1; // [7:0]
    logic [7:0]               rd_data1;
    
    param_reg_bank #(
        .M (4),
        .W (8)
    ) DUT1 (
        .clk     (clk),
        .rst     (rst),
        .wr_en   (wr_en1),
        .rd_addr (rd_addr1),
        .wr_addr (wr_addr1),
        .wr_data (wr_data1),
        .rd_data (rd_data1)
    );

    // DUT 2 Signals: M = 8, W = 4 
    logic                     wr_en2;
    logic [$clog2(8)-1:0]     rd_addr2; // [2:0]
    logic [$clog2(8)-1:0]     wr_addr2; // [2:0]
    logic [3:0]               wr_data2; // [3:0]
    logic [3:0]               rd_data2;

    param_reg_bank #(
        .M (8),
        .W (4)
    ) DUT2 (
        .clk     (clk),
        .rst     (rst),
        .wr_en   (wr_en2),
        .rd_addr (rd_addr2),
        .wr_addr (wr_addr2),
        .wr_data (wr_data2),
        .rd_data (rd_data2)
    );
    
    always #5 clk = ~clk;
    
    logic [7:0] exp_regs1 [0:3];
    logic [3:0] exp_regs2 [0:7];
    int err_cnt = 0;
    
    initial begin
        $display("[%0t] Initializing...", $time);
        rst      = 0;
        wr_en1   = 0;
        wr_en2   = 0;
        wr_addr1 = '0;
        wr_addr2 = '0;
        wr_data1 = '0;
        wr_data2 = '0;
        rd_addr1 = '0;
        rd_addr2 = '0;
        
        for (int i = 0; i < 4; i++) exp_regs1[i] = '0;
        for (int i = 0; i < 8; i++) exp_regs2[i] = '0;

        $display("[%0t] Starting Reset Verification...", $time);
        @(negedge clk);
        rst = 1;
        @(negedge clk);
        rst = 0;

      
        for (int i = 0; i < 4; i++) begin
            rd_addr1 = i;
            #1;
            if (rd_data1 !== '0) begin
                $display("[ERROR %0t] DUT1 Reset Failed at addr %0d! Got: %h, Exp: 0", $time, i, rd_data1);
                err_cnt++;
            end
        end

        for (int i = 0; i < 8; i++) begin
            rd_addr2 = i;
            #1;
            if (rd_data2 !== '0) begin
                $display("[ERROR %0t] DUT2 Reset Failed at addr %0d! Got: %h, Exp: 0", $time, i, rd_data2);
                err_cnt++;
            end
        end

        // 2. 
        for (int i = 0; i < 8; i++) begin
            @(negedge clk);
            if (i > 3) begin
                wr_en1   = 0;
                wr_en2   = 1;
                wr_addr2 = i;
                wr_data2 = i;
                exp_regs2[i] = i;
            end else begin
                wr_en1   = 1;
                wr_addr1 = i;
                wr_data1 = i + 10; 
                exp_regs1[i] = i + 10;

                wr_en2   = 1;
                wr_addr2 = i;
                wr_data2 = i;
                exp_regs2[i] = i;
            end
        end

        @(negedge clk);
        wr_en1 = 0;
        wr_en2 = 0;

       $display("[%0t] Starting Reading Registers Out of Order Verification...", $time);
        for (int i = 7; i >= 0; i--) begin
            if (i > 3) begin
                rd_addr2 = i;
                #1;
                if (rd_data2 !== exp_regs2[i]) begin
                    $display("[ERROR %0t] DUT2 Mismatch at addr %0d! Got: %h, Exp: %h", $time, i, rd_data2, exp_regs2[i]);
                    err_cnt++;
                end
            end else begin
                rd_addr1 = i;
                rd_addr2 = i;
                #1;
                if (rd_data1 !== exp_regs1[i]) begin
                    $display("[ERROR %0t] DUT1 Mismatch at addr %0d! Got: %h, Exp: %h", $time, i, rd_data1, exp_regs1[i]);
                    err_cnt++;
                end
                if (rd_data2 !== exp_regs2[i]) begin
                    $display("[ERROR %0t] DUT2 Mismatch at addr %0d! Got: %h, Exp: %h", $time, i, rd_data2, exp_regs2[i]);
                    err_cnt++;
                end
            end
        end

        $display("[%0t] Starting Overwriting Verification...", $time);
        for (int i = 0; i < 8; i++) begin
            @(negedge clk);
            if (i > 3) begin
                wr_en1   = 0;
                wr_en2   = 1;
                wr_addr2 = i;
                wr_data2 = i + 1;
                exp_regs2[i] = i + 1;
            end else begin
                wr_en1   = 1;
                wr_addr1 = i;
                wr_data1 = i + 20;
                exp_regs1[i] = i + 20;

                wr_en2   = 1;
                wr_addr2 = i;
                wr_data2 = i + 1;
                exp_regs2[i] = i + 1;
            end
        end

        @(negedge clk);
        wr_en1 = 0;
        wr_en2 = 0;

        
        for (int i = 0; i < 4; i++) begin
            rd_addr1 = i;
            #1;
            if (rd_data1 !== exp_regs1[i]) begin
                $display("[ERROR %0t] DUT1 Overwrite Mismatch at addr %0d! Got: %h, Exp: %h", $time, i, rd_data1, exp_regs1[i]);
                err_cnt++;
            end
        end

        for (int i = 0; i < 8; i++) begin
            rd_addr2 = i;
            #1;
            if (rd_data2 !== exp_regs2[i]) begin
                $display("[ERROR %0t] DUT2 Overwrite Mismatch at addr %0d! Got: %h, Exp: %h", $time, i, rd_data2, exp_regs2[i]);
                err_cnt++;
            end
        end
        
    
        $display("[%0t] Starting Persistence Verification...", $time);

      
        @(negedge clk);
        wr_en1   = 1'b1;
        wr_addr1 = 2'd1;
        wr_data1 = 8'h3C;
        exp_regs1[1] = 8'h3C; 

        wr_en2   = 1'b1;
        wr_addr2 = 3'd4;
        wr_data2 = 4'h7;
        exp_regs2[4] = 4'h7;  
        @(negedge clk);
        wr_en1 = 1'b0;
        wr_en2 = 1'b0;
        repeat (3) @(negedge clk);

        // (Address 1 must have 8'h3C; 0, 2, and 3 must retain old values)
        for (int i = 0; i < 4; i++) begin
            rd_addr1 = i;
            #1; 
            if (rd_data1 !== exp_regs1[i]) begin
                $display("[ERROR %0t] DUT1 Persistence Mismatch @ addr %0d! Got: %h, Exp: %h",
                         $time, i, rd_data1, exp_regs1[i]);
                err_cnt++;
            end
        end

        // (Address 4 must have 4'h7; 0-3, 5-7 must retain old values)
        for (int i = 0; i < 8; i++) begin
            rd_addr2 = i;
            #1; 
            if (rd_data2 !== exp_regs2[i]) begin
                $display("[ERROR %0t] DUT2 Persistence Mismatch @ addr %0d! Got: %h, Exp: %h",
                         $time, i, rd_data2, exp_regs2[i]);
                err_cnt++;
            end
        end
     
     
        $display("[%0t] Starting Read-After-Write Verification...", $time);

        // Set wr_addr and rd_addr to the SAME location before posedge clk
        @(negedge clk);
        // DUT1 target: Address 3
        wr_en1   = 1'b1;
        wr_addr1 = 2'd3;
        rd_addr1 = 2'd3;
        wr_data1 = 8'h99;
        exp_regs1[3] = 8'h99;

        // DUT2 target: Address 6
        wr_en2   = 1'b1;
        wr_addr2 = 3'd6;
        rd_addr2 = 3'd6;
        wr_data2 = 4'hA;
        exp_regs2[6] = 4'hA;

        // Step into posedge where write commits, then check after clock-to-q delay
        @(posedge clk);
        #1;

        if (rd_data1 !== 8'h99) begin
            $display("[ERROR %0t] DUT1 RAW Mismatch @ addr 3! Got: %h, Exp: 99", $time, rd_data1);
            err_cnt++;
        end

        if (rd_data2 !== 4'hA) begin
            $display("[ERROR %0t] DUT2 RAW Mismatch @ addr 6! Got: %h, Exp: A", $time, rd_data2);
            err_cnt++;
        end


        @(negedge clk);
        wr_en1 = 1'b0;
        wr_en2 = 1'b0;
        
        
        @(negedge clk);
        rst = 1;
        @(negedge clk);
        rst = 0;

        
        $display("\n==========================================");
        if (err_cnt == 0) begin
            $display("ALL TESTS PASSED: Register banks verified successfully.");
        end else begin
            $display("TEST FAILED: %0d error(s) detected.", err_cnt);
        end
        $display("==========================================\n");

        $finish;
    end
    
endmodule
