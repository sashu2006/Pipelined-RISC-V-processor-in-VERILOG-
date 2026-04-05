module stall_mux(I0,S,Y);
    input wire [6:0] I0;
    input wire S;
    output wire [6:0] Y;
    wire [6:0] temp;
    assign temp=7'b0;

    assign Y = S ? temp: I0;

endmodule