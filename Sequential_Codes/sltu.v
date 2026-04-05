module sltu(a,b,c,carry_out,carry_flag,overflow_flag);
    input wire [63:0]a;
    input wire [63:0]b;
    output wire [63:0]c;
    output wire carry_out;
    output wire carry_flag;
    output wire overflow_flag;
    
    assign c[63:1]=63'b0;

    wire [63:0]sum;
    wire carry_out_temp;
    wire carry_flag_temp;
    wire overflow_flag_temp;
    wire cin;
    assign cin=1'b1;

    full_adder_64_bit subtractor(
        .a(a),
        .b(b),
        .sum(sum),
        .carry_out(carry_out_temp),
        .carry_flag(carry_flag_temp),
        .overflow_flag(overflow_flag_temp),
        .cin(cin)
        );
    assign c[0]=carry_flag_temp;

    assign carry_flag=1'b0;
    assign overflow_flag=1'b0;
    assign carry_out=1'b0;
endmodule