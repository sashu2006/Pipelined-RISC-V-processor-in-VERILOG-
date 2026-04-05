`timescale 1ns/1ns

module slt(x,y,set_val,cout,carry,overflow,zero);
input [63:0] x;
input [63:0] y;
wire [63:0] not_y;
wire [63:0] z;
output carry;
output cout;
output [63:0] set_val;
output overflow;
output zero;
wire [64:0] inter;
genvar i;
assign inter[0] = 1;
generate
for(i = 0; i<64; i=i+1) begin: loop0
    not d0(not_y[i],y[i]);
end
assign set_val[63:1] = 63'b0;
for(i = 0; i<64; i=i+1) begin: loop1
    full_adder d1(x[i],not_y[i],inter[i],z[i],inter[i+1]);
end
endgenerate
wire a,b,c;
xor d2(a,x[63],not_y[63]);
xnor d3(b,not_y[63],z[63]);
or d4(c,a,b);
xor d9(set_val[0], ~c, z[63]);
assign zero = ~set_val[0];
assign overflow = 1'b0;
assign carry = 1'b0;
assign cout = carry;
endmodule

