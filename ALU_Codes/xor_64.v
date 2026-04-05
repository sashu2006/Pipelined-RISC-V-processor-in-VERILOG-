`timescale 1ns/1ns

module xor_64(x,y,z,cout,carry, overflow, zero);
input [63:0] x;
input [63:0] y;
output [63:0] z;
output carry;
output overflow;
output cout;
output zero;
wire [63:0] inter;

genvar i;
generate
for(i = 0 ;i<64 ; i = i+1) begin: loop1
    xor d1(z[i],x[i],y[i]);
end
assign inter[0] = z[0];
genvar j;
for(j = 1; j<64; j =j+1) begin: loop2
    or d2(inter[j],inter[j-1],z[j]);
end
endgenerate
assign zero = ~inter[63];
assign overflow = 1'b0;
assign carry = 1'b0;
assign cout = carry;
endmodule
