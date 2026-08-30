`timescale 1ns / 1ps

module tb_comparator2bit;
    logic [1:0] a,b;
    logic       agtb,altb,aeqb;
    
    comparator2bit dut(
        .a(a),
        .b(b),
        .agtb(agtb),
        .altb(altb),
        .aeqb(aeqb)
        );
    initial begin
        for (int A = 0; A < 4; A++)begin
            for (int B = 0; B < 4;B++)begin
                a = A;
                b = B;
                #10;
                 
                if (agtb !== (a > b)) $error("ERROR: a=%b, b=%b | agtb=%b, expected=%b", a, b, agtb, (a > b)); 
                if (aeqb !== (a == b)) $error("ERROR: a=%b, b=%b | aeqb=%b, expected=%b", a, b, aeqb, (a == b));                
                if (altb !== (a < b)) $error("ERROR: a=%b, b=%b | altb=%b, expected=%b", a, b, altb, (a < b)); 
                
                $display("Test: a=%b, b=%b | agtb=%b, aeqb=%b, altb=%b", a, b, agtb, aeqb, altb); 
            end
        end
    $display("=========================================="); 
    $display("ALL 16 COMPARATOR TESTS PASSED!"); 
    $display("=========================================="); 
    $finish;
    end
endmodule
