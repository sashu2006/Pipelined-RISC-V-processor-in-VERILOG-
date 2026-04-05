module full_adder_64_bit(a,b,sum,carry_out,carry_flag,overflow_flag,cin);
    input wire[63:0]a;
    input wire[63:0]b;
    input wire cin;
    output wire carry_flag;
    output wire overflow_flag;
    output wire[63:0]sum;
    output wire carry_out;
    output wire zero_flag;

    wire [64:0]carry;
    assign carry[0]=cin;

    wire [63:0]b2;
    genvar j;
    generate

        for (j=0;j<64;j=j+1) begin: invert_loop
            xor(b2[j],b[j],cin);
        end
    endgenerate

    genvar i;
    
    generate
        for (i=0;i<64;i=i+1) 
        begin: add
            full_adder_1_bit uut(
                .a(a[i]),
                .b(b2[i]),
                .sum(sum[i]),
                .cin(carry[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign carry_out=carry[64];
    xor(carry_flag,carry_out,cin);
    //assign carry_flag=carry_out;
    xor g1(overflow_flag,carry[63],carry[64]);
endmodule