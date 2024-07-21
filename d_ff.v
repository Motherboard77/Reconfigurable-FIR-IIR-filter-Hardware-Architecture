`timescale 1ns / 1ps

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
