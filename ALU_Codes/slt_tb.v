`timescale 1ns/1ns
module slt_64_test;
//inputs
reg [63:0] x;
reg [63:0] y;
//outputs
wire [63:0] set_val;
wire carry;
wire overflow;
wire zero;
wire cout;

slt uut(x,y,set_val,cout,carry,overflow,zero);
initial begin
$dumpfile("slt_64_test.vcd");
$dumpvars(0,slt_64_test);
$monitor("time = %t \t x = %h \t y = %h \t z = %h \t zero = %h \t MSB = %h \t overflow = %h",$time,x,y,set_val,zero,set_val[63],overflow);
x =64'h7FFFFFFFFFFFFFFF;
y =64'h8000000000000000;
#2;
$finish;
end
endmodule
