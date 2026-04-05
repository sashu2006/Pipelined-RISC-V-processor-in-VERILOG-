`timescale 1ns/1ns

module comparator(data1, data2, equal);
input [63:0] data1;
input [63:0] data2;
output reg equal;
reg [63:0] xor_array;
reg [63:0] or_array;
integer i;
always@(*) begin
    for(i = 0; i<64; i = i+1) begin
        xor_array[i] = data1[i]^data2[i];
    end
    or_array[0] = xor_array[0];
    for(i = 1; i<64; i = i+1) begin
        or_array[i] = or_array[i-1]| xor_array[i];
    end
    equal = ~or_array[63];
end
endmodule