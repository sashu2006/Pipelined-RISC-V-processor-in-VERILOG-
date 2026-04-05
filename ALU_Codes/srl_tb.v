`timescale 1ns/1ns
module srl_test;
//inputs
reg [63:0] x;
wire [63:0] y;
//outputs
reg [63:0] shift;
wire carry;
wire overflow;
wire cout;
wire zero;

srl uut(x,y,shift,cout,carry,overflow,zero);
initial begin
$dumpfile("srl_test.vcd");
$dumpvars(0,srl_test);
$monitor("time = %t \t x = %h \t y = %h \t shift = %h \t zero = %b \t ",$time, x,y,shift,zero);
x = 64'h0000000000000001;
shift = 1;
#2;
$finish;
end
endmodule
