`timescale 1ns/1ns

module sll(x,y,shift,cout,carry,overflow,zero);
input [63:0] x;
input [63:0] shift;
output [63:0] y;
output carry;
output overflow;
output cout;
output zero;
wire [5:0] s;
wire [63:0] inter1;
wire [63:0] inter2;
wire [63:0] inter3;
wire [63:0] inter4;
wire [63:0] inter5;

genvar i;
generate
for(i = 0; i<6; i=i+1) begin: loop1
    assign s[i] = shift[i];
end

//level 0, for 1 bit shifting (64 muxes)

for(i = 0; i<64; i=i+1) begin: loop2
    if(i == 0) begin
        mux_2x1 d0(x[0],1'b0,s[0],inter1[0]);
    end else begin
        mux_2x1 d1(x[i], x[i-1], s[0], inter1[i]);
    end
end

//level 1, for 2 bit shifting (64 muxes again!)

for(i = 0; i<64; i=i+1) begin: loop3
    if(i < 2) begin
        mux_2x1 d0(inter1[i],1'b0,s[1],inter2[i]);
    end else begin
        mux_2x1 d1(inter1[i], inter1[i-2], s[1], inter2[i]);
    end
end

//level 2, for 4 bit shifting (64 muxes again!)

for(i = 0; i<64; i=i+1) begin: loop4
    if(i < 4) begin
        mux_2x1 d0(inter2[i],1'b0,s[2],inter3[i]);
    end else begin
        mux_2x1 d1(inter2[i], inter2[i-4], s[2], inter3[i]);
    end
end

//level 3, for 8 bit shifting (64 muxes again!)

for(i = 0; i<64; i=i+1) begin: loop5
    if(i < 8) begin
        mux_2x1 d0(inter3[i],1'b0,s[3],inter4[i]);
    end else begin
        mux_2x1 d1(inter3[i], inter3[i-8], s[3], inter4[i]);
    end
end

//level 4, for 16 bit shifting (64 muxes again!)

for(i = 0; i<64; i=i+1) begin: loop6
    if(i < 16) begin
        mux_2x1 d0(inter4[i],1'b0,s[4],inter5[i]);
    end else begin
        mux_2x1 d1(inter4[i], inter4[i-16], s[4], inter5[i]);
    end
end

//level 5, for 32 bit shifting (64 muxes again!)

for(i = 0; i<64; i=i+1) begin: loop7
    if(i < 32) begin
        mux_2x1 d0(inter5[i],1'b0,s[5],y[i]);
    end else begin
        mux_2x1 d1(inter5[i], inter5[i-32], s[5], y[i]);
    end
end

wire [63:0] car;
assign car[0] = y[0];
for(i = 1; i<64; i=i+1) begin: loop8
    or d11(car[i],car[i-1],y[i]);
end
endgenerate
assign zero = ~car[63];
assign carry = 1'b0;
xor d12(overflow,x[63],y[63]);
assign cout = 1'b0;
endmodule