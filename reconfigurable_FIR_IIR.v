`timescale 1ns / 1ps

module reconfigurable_FIR_IIR(clock,reset,control,data_in,data_out);

input clock;
input reset;
input control;
input [7:0] data_in;
output [7:0] data_out;

parameter b0 = 2, b1=1,b2=3,b3=4, a1=2, a2=3;

wire [7:0] x1,x2,x3;
wire [7:0] t0,t3;

wire [7:0] y_out;
wire [7:0] y1,y2;

d_ff X_FF1(data_in,clock,reset,x1);
d_ff X_FF2(x1,clock,reset,x2);
MUX2to1_8bit MUX1(x2,1'b0,control,x3);
d_ff X_FF3(x3,clock,reset,x4);

assign t0 = b0*data_in + b1*x1 +b2*x2 + b3*x4 ;
//assign t1 = b2*x2 + b3*x4;
//assign t2 = t0+t1;

d_ff Y_FF1(y_out,clock,reset,y1);
d_ff Y_FF2(y1,clock,reset,y2);

assign t3 = -a1*y1 + a2*y2 + b0*data_in + b1*x1 +b2*x2 + b3*x4 ;
//assign y_out = t3 + t0;

MUX2to1_8bit MUX2(t0,t3,control,data_out);

endmodule


module d_ff(data_in,clock,reset,data_out);

input [7:0] data_in;
input clock;
input reset;
output reg [7:0] data_out;

always@(posedge clock or posedge reset)
begin
    if(reset)
    data_out <= 8'b0000_0000;
    else
    data_out <= data_in;
end

endmodule

module MUX2to1_8bit(a,b,sel,data_out);

input [7:0] a;
input [7:0] b;
input sel;
output [7:0] data_out;

assign data_out = sel? a:b ;  

endmodule

