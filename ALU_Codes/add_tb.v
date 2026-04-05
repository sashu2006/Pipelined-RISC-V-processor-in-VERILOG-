`timescale 1ns/1ns
module add_64_test;
//inputs
reg [63:0] x;
reg [63:0] y;
//outputs
wire [63:0] z;
wire carry;
wire cout;
wire overflow;
wire zero;

add uut(x,y,z,cout,carry,overflow,zero);
initial begin
$dumpfile("add_64_test.vcd");
$dumpvars(0,add_64_test);
$monitor("time = %t \t x = %h \t y = %h \t z = %h \t zero = %d \t carry = %d \t overflow = %d \t",$time,x,y,z,zero,carry,overflow);
x =64'h0000000000000000 ;
y =64'h0000000000000000 ;
#2;
$finish;
end
endmodule
