`timescale 1ns / 1ps

module basys3_top (
    input  logic       clk,       
    input  logic [1:0] sw,        // sw[0]: Enable, sw[1]: Direction
    input  logic       btnC,      // Center button: Synchronous Reset
    output logic [3:0] led        // led[3:0]: counter value (4bits)
);

    // Internal hookup signals
    logic tick;
    logic counter_en;

    // Enable Logic: count steps only when user enable is ON and tick fires
    assign counter_en = sw[0] & tick;

  
    // 50,000,000 cycles -> 2 updates per second
    
    tick_generator #(
        .CYCLES(50_000_000)
    ) u_tick_gen (
        .clk  (clk),
        .rst  (btnC),
        .tick (tick)
    );

    N_counter #(
        .WIDTH(4)
    ) u_counter (
        .clk (clk),
        .rst (btnC),
        .en  (counter_en),
        .up  (sw[1]),
        .q   (led)
    );

endmodule