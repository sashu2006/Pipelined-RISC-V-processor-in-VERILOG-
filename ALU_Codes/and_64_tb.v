`timescale 1ns/1ns
module and_64_test;
//inputs
reg [63:0] x;
reg [63:0] y;
//outputs
wire [63:0] z;
wire carry;
wire cout;
wire overflow;
wire zero;

and_64 uut(x,y,z,cout,carry,overflow,zero);
initial begin
$dumpfile("and_64_test.vcd");
$dumpvars(0,and_64_test);
$monitor("time = %t \t x = %h \t y = %h \t z = %h \t zero = %d",$time,x,y,z,zero);
x =64'hFFFFFFFFFFFFFFFF ;
y =64'hFFFFFFFFFFFFFFFF ;
#2;
$finish;
end
endmodule
