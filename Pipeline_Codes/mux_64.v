module mux_64(I0, I1, S, Y);
    input wire [63:0] I0, I1;
    input wire S;
    output wire [63:0] Y;

    assign Y = S ? I1 : I0;

endmodule