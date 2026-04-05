module adder(a,b,sum);
    input wire[63:0]a;
    input wire[63:0]b;
    output wire[63:0]sum;

    wire [64:0]carry;
    assign carry[0]=1'b0;
    genvar i;
    
    generate
        for (i=0;i<64;i=i+1) 
        begin: add
            fa uut(
                .a(a[i]),
                .b(b[i]),
                .sum(sum[i]),
                .cin(carry[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
endmodule