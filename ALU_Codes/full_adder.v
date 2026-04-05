`timescale 1ns/1ns

module full_adder(x,y,cin,sum,cout);
input x;
input y;
output sum;
output cout;
input cin;
xor d1(sum,x,y,cin);
wire a,b,c;
and d2(a,x,y);
or d3(b,x,y);
and d4(c,b,cin);
or d5(cout,a,c);
endmodule