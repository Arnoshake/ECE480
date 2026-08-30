`timescale 1ns / 1ps


module comparator2bit(
input logic [1:0] a, b,
output logic    aeqb,agtb,altb
    );
    assign aeqb = (a[1] ~^ b[1] ) & (a[0] ~^ b[0] ); // the first digit must be same, the second digit must be same
    assign agtb = (a[1] & ~b[1]) | ( (a[1] ~^ b[1] ) & (a[0] & ~b[0]) ); // the first digit is > OR the first digit same and 2nd digit is >
    assign altb = (~a[1] & b[1]) | ( (a[1] ~^ b[1] ) & (~a[0] & b[0]) ); // the first digit is < OR the first digit same and 2nd digit is <
endmodule
