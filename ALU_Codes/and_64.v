`timescale 1ns/1ns
module and_64(x,y,z,cout,carry, overflow, zero);
input [63:0] x;
input [63:0] y;
output [63:0] z;
wire [63:0] inter;
output carry;
output cout;
output overflow;
output zero;
genvar i;
generate
for(i = 0; i <= 63; i=i+1) begin : loop1
    and fill(z[i],y[i],x[i]);
end
genvar j;
assign inter[0] = z[0];
for(j = 1; j<=63; j=j+1) begin : loop2
    or ok(inter[j],inter[j-1],z[j]);
end
endgenerate
assign zero = ~inter[63];
assign overflow = 1'b0;
assign carry = 1'b0;
assign cout = carry;
endmodule
