`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2026 10:06:45 PM
// Design Name: 
// Module Name: tb_mux
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


module tb_mux(

    );
    logic [3:0] d0,d1,d2,d3;
    logic [1:0] sel;
    logic [3:0] y_switch, y_if;
    mux_if dut_if ( .d0(d0),.d1(d1),.d2(d2),.d3(d3),.sel(sel),.y(y_if));
    mux_switch dut_switch ( .d0(d0),.d1(d1),.d2(d2),.d3(d3),.sel(sel),.y(y_switch));
    
    
    initial begin
        d0 = 4'b0001;
        d1 = 4'b0010;
        d2 = 4'b0100;
        d3 = 4'b1000;
        for (int i = 0; i < 4; i++) begin
            sel = i;
            #10;
            if (y_switch != y_if) begin
                $error("y_switch DNE y_if! y_switch = %d, y_if = %d",y_switch,y_if);
            end
            if ( sel == 0 && (y_switch != d0 || y_if != d0 )) begin
                $error("outputs do no match selector: sel = %d, y_switch = %d, y_if = %d",sel,y_switch,y_if);
            end
            else if ( sel == 1 && (y_switch != d1 || y_if != d1 )) begin
                $error("outputs do no match selector: sel = %d, y_switch = %d, y_if = %d",sel,y_switch,y_if);
            end
            else if ( sel == 2 && (y_switch != d2 || y_if != d2 )) begin
                $error("outputs do no match selector: sel = %d, y_switch = %d, y_if = %d",sel,y_switch,y_if);
            end
            else if ( sel == 3 && (y_switch != d3 || y_if != d3 )) begin
                $error("outputs do no match selector: sel = %d, y_switch = %d, y_if = %d",sel,y_switch,y_if);
            end
            
            
        end
        $display("End of Tests");
        $finish;
    end

endmodule
