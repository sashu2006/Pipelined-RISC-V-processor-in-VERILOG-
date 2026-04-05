`timescale 1ns/1ns
module sra_test;
//inputs
reg [63:0] x;
wire [63:0] y;
//outputs
reg [63:0] shift;
wire carry;
wire cout;
wire overflow;
wire zero;
sra uut(x,y,shift,cout,carry,overflow,zero);
initial begin
$dumpfile("sra_test.vcd");
$dumpvars(0,sra_test);
$monitor("time = %t \t x = %h \t y = %h \t shift = %h \t zero = %b \t ",$time, x,y,shift,zero);
x = 64'h0000000000000000;
shift = 4;
#2;
$finish;
end
endmodule
