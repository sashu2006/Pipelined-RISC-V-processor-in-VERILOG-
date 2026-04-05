module and_gate(a,b,c,carry_out,carry_flag,overflow_flag);
    input wire [63:0]a;
    input wire [63:0]b;
    output wire [63:0]c;
    output wire carry_out;
    output wire carry_flag;
    output wire overflow_flag;


    genvar i;
    
    generate
        for (i=0;i<64;i=i+1)
        begin: and_64bit
            and(c[i],a[i],b[i]);
        end
    endgenerate

    assign carry_flag=1'b0;
    assign overflow_flag=1'b0;
    assign carry_out=1'b0;
endmodule