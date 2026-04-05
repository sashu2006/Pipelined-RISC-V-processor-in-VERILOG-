`timescale 1ns/1ns
module sub_64_test;
//inputs
reg [63:0] x;
reg [63:0] y;
//outputs
wire [63:0] z;
wire carry;
wire overflow;
wire zero;
wire set_val;

sltu uut(x,y,z,set_val,carry,overflow,zero);
initial begin
$dumpfile("sub_64_test.vcd");
$dumpvars(0,sub_64_test);
$monitor("time = %t \t x = %h \t y = %h \t z = %h \t zero = %d \t MSB = %b \t overflow = %d \t",$time,x,y,z,zero,z[63],overflow);
x =-64'd1;
y =64'd1;
#2;
$finish;
end
endmodule
