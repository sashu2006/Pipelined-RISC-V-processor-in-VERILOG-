`timescale 1ns/1ns

module sltu(x,y,set_val,cout,carry,overflow,zero);
input [63:0] x;
input [63:0] y;
wire [63:0] not_y;
wire [63:0] z;
output [63:0] set_val;
output carry;
output cout;
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
not(set_val[0],inter[64]);
assign cout = 1'b0;
assign carry = 1'b0;
assign overflow = 1'b0;
assign zero = inter[64];
endmodule

