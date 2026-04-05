module shifter_64_bit(a,b,c,extend_bit,carry_out,carry_flag,overflow_flag);
    input wire [63:0]a;
    input wire [63:0]b;
    input wire extend_bit;
    output wire [63:0]c;
    output wire carry_out;
    output wire carry_flag;
    output wire overflow_flag;

    //stage 0:
    wire [63:0]output_0;

    genvar i;
 

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop0
            if(i>(63-(1<<0))) begin:edge_case0
                mux M(
                    .I0(a[i]),
                    .I1(extend_bit),
                    .S(b[0]),
                    .Y(output_0[i])
                );
            end
            else begin: normal_case0
                mux M(
                    .I0(a[i]),
                    .I1(a[i+1]),
                    .S(b[0]),
                    .Y(output_0[i])
                );
            end
        end
    endgenerate

    //stage 1:
    wire [63:0]output_1;

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop1
            if(i>(63-(1<<1))) begin:edge_case1
                mux M(
                    .I0(output_0[i]),
                    .I1(extend_bit),
                    .S(b[1]),
                    .Y(output_1[i])
                );
            end
            else begin: normal_case1
                mux M(
                    .I0(output_0[i]),
                    .I1(output_0[i+2]),
                    .S(b[1]),
                    .Y(output_1[i])
                );
            end
        end
    endgenerate

    //stage 2:
    wire [63:0]output_2;

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop2
            if(i>(63-(1<<2))) begin:edge_case2
                mux M(
                    .I0(output_1[i]),
                    .I1(extend_bit),
                    .S(b[2]),
                    .Y(output_2[i])
                );
            end
            else begin: normal_case2
                mux M(
                    .I0(output_1[i]),
                    .I1(output_1[i+4]),
                    .S(b[2]),
                    .Y(output_2[i])
                );
            end
        end
    endgenerate

    //stage 3:
    wire [63:0]output_3;

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop3
            if(i>(63-(1<<3))) begin:edge_case3
                mux M(
                    .I0(output_2[i]),
                    .I1(extend_bit),
                    .S(b[3]),
                    .Y(output_3[i])
                );
            end
            else begin: normal_case3
                mux M(
                    .I0(output_2[i]),
                    .I1(output_2[i+(1<<3)]),
                    .S(b[3]),
                    .Y(output_3[i])
                );
            end
        end
    endgenerate


    //stage 4:
    wire [63:0]output_4;

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop4
            if(i>(63-(1<<4))) begin:edge_case4
                mux M(
                    .I0(output_3[i]),
                    .I1(extend_bit),
                    .S(b[4]),
                    .Y(output_4[i])
                );
            end
            else begin: normal_case4
                mux M(
                    .I0(output_3[i]),
                    .I1(output_3[i+(1<<4)]),
                    .S(b[4]),
                    .Y(output_4[i])
                );
            end
        end
    endgenerate


    //stage 5:

    generate
        for (i=0;i<64;i=i+1)
        begin: mux_loop5
            if(i>(63-(1<<5))) begin:edge_case5
                mux M(
                    .I0(output_4[i]),
                    .I1(extend_bit),
                    .S(b[5]),
                    .Y(c[i])
                );
            end
            else begin: normal_case5
                mux M(
                    .I0(output_4[i]),
                    .I1(output_4[i+(1<<5)]),
                    .S(b[5]),
                    .Y(c[i])
                );
            end
        end
    endgenerate


    assign carry_flag=1'b0;
    assign overflow_flag=1'b0;
    assign carry_out=1'b0;
endmodule