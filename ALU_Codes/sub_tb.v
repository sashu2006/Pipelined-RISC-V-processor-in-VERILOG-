`timescale 1ns/1ns
module sub_64_test;
//inputs
reg [63:0] x;
reg [63:0] y;
//outputs
wire [63:0] z;
wire carry;
wire overflow;
wire cout;
wire zero;

sub uut(x,y,z,cout,carry,overflow,zero);
initial begin
$dumpfile("sub_64_test.vcd");
$dumpvars(0,sub_64_test);
$monitor("time = %t \t x = %h \t y = %h \t z = %h \t zero = %d \t carry = %d \t overflow = %d \t",$time,x,y,z,zero,carry,overflow);
x =64'h7FFFFFFFFFFFFFFF;
y =64'hFFFFFFFFFFFFFFFF;
#2;
$finish;
end
endmodule
