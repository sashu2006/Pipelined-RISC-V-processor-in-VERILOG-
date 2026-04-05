module mux (I0,I1,S,Y);
    input wire I0,I1,S;
    output wire Y;

    wire t1,t2,t3;
    not(t1,S);
    and(t2,t1,I0);
    and(t3,S,I1);
    or(Y,t2,t3);
    

endmodule