`timescale 1ns/1ns

module sub(x,y,z,cout,carry,overflow,zero);
input [63:0] x;
input [63:0] y;
wire [63:0] not_y;
output [63:0] z;
output carry;
output overflow;
output cout;
output zero;
wire [64:0] inter;
wire [63:0] ok;
genvar i;
assign inter[0] = 1;
generate
for(i = 0; i<64; i=i+1) begin: loop0
    not d0(not_y[i],y[i]);
end
for(i = 0; i<64; i=i+1) begin: loop1
    full_adder d1(x[i],not_y[i],inter[i],z[i],inter[i+1]);
end
assign ok[0] = z[0];
for(i = 1;  i<64; i=i+1) begin : loop2
    or d5(ok[i],ok[i-1],z[i]);  
end 
endgenerate
assign carry = ~inter[64];
wire a,b,c;
xor d2(a,x[63],not_y[63]);
xnor d3(b,not_y[63],z[63]);
or d4(c,a,b);
assign overflow = ~c;
assign zero = ~ok[63];
assign cout = inter[64];
endmodule

