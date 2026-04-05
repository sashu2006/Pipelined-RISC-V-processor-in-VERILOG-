`timescale 1ns/1ns

module mux_2x1(x0,x1,s,y);
input x0;
input x1;
input s;
output y;
wire a,b,c,d;
not d1(a,s);
and d2(b,a,x0);
and d3(c,s,x1);
or d4(y,b,c);
endmodule