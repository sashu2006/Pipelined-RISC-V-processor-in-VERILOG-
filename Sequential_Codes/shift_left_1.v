module shift_left_1(imm_in,imm_out);
    input wire [63:0] imm_in;
    output wire [63:0] imm_out;

    assign imm_out[0]=1'b0;
    assign imm_out[63:1]=imm_in[62:0];
endmodule