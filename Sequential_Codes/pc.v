module dff (
    input clk,
    input reset,
    input d,
    output reg q
);

initial begin
    q = 1'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule

module pc (
    input clk,
    input reset,
    input [63:0] pc_in,
    output [63:0] pc_out
);

genvar i;

generate
    for(i = 0; i < 64; i = i + 1) begin : pc_bits
        dff dff_instance (
            .clk(clk),
            .reset(reset),
            .d(pc_in[i]),
            .q(pc_out[i])
        );
    end
endgenerate

endmodule