module control_unit (
    input  [6:0] opcode,
    output Branch,
    output MemRead,
    output MemtoReg,
    output [1:0] ALUOp,
    output MemWrite,
    output ALUSrc,
    output RegWrite
);

wire op0_n, op1_n, op2_n, op3_n, op4_n, op5_n, op6_n;

not (op0_n, opcode[0]);
not (op1_n, opcode[1]);
not (op2_n, opcode[2]);
not (op3_n, opcode[3]);
not (op4_n, opcode[4]);
not (op5_n, opcode[5]);
not (op6_n, opcode[6]);

wire r_type, addi, ld, sd, beq;
and (r_type,
     op6_n, opcode[5], opcode[4],
     op3_n, op2_n, opcode[1], opcode[0]);

and (addi,
     op6_n, op5_n, opcode[4],
     op3_n, op2_n, opcode[1], opcode[0]);


and (ld,
     op6_n, op5_n, op4_n,
     op3_n, op2_n, opcode[1], opcode[0]);

and (sd,
     op6_n, opcode[5], op4_n,
     op3_n, op2_n, opcode[1], opcode[0]);

and (beq,
     opcode[6], opcode[5], op4_n,
     op3_n, op2_n, opcode[1], opcode[0]);

or (RegWrite, r_type, addi, ld);

or (MemRead, ld);

or (MemWrite, sd);

or (MemtoReg, ld);

or (ALUSrc, addi, ld, sd);

or (Branch, beq);

or (ALUOp[1], r_type, addi);

or (ALUOp[0], beq, addi);

endmodule