`timescale 1ns / 1ps

module MUX2to1_8bit(a,b,sel,data_out);

input [7:0] a;
input [7:0] b;
input sel;
output [7:0] data_out;

assign data_out = sel? a:b ;  

endmodule
