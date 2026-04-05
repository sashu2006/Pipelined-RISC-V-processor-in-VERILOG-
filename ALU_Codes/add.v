`timescale 1ns/1ns


module add(x,y,z,cout,carry,overflow,zero);
input [63:0] x;
input [63:0] y;
output [63:0] z;
output carry;
output cout;
output overflow;
output zero;
wire [64:0] inter;
wire [63:0] ok;
genvar i;
assign inter[0] = 0;
generate
for(i = 0; i<64; i=i+1) begin: loop1
    full_adder d1(x[i],y[i],inter[i],z[i],inter[i+1]);
end
assign ok[0] = z[0];
for(i = 1;  i<64; i=i+1) begin : loop2
    or d5(ok[i],ok[i-1],z[i]);
end 
endgenerate
assign carry = inter[64];
wire a,b,c;
xor d2(a,x[63],y[63]);
xnor d3(b,y[63],z[63]);
or d4(c,a,b);
assign overflow = ~c;
assign zero = ~ok[63];
assign cout = carry;
endmodule

