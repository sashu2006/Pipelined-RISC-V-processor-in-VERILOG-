module full_adder_1_bit(a,b,cin,cout,sum);
    input wire a,b,cin;
    output wire cout,sum;

    wire t1,t2,t3;

    xor(t1,a,b);
    xor(sum,cin,t1);
    and(t2,a,b);
    and(t3,t1,cin);
    or(cout,t3,t2);

endmodule