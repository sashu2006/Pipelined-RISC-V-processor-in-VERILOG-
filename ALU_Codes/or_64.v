`timescale 1ns/1ns

module or_64(x,y,z,cout,carry, overflow,zero);
input [63:0] x;
input [63:0] y;
output [63:0] z;
wire [63:0] inter;
output cout;
output zero;
output carry;
output overflow;

genvar i;
generate
for(i = 0; i<64; i=i+1) begin: loop1
    or d1(z[i],x[i],y[i]);
end
assign inter[0] = z[0];
for(i = 1; i<64; i=i+1) begin: loop2
    or d2(inter[i],inter[i-1],z[i]);
end
endgenerate
assign zero = ~inter[63];
assign carry = 1'b0;
assign overflow = 1'b0;
assign cout = carry;
endmodule
