`timescale 1ns/1ns

module Branch_Forwarding_Unit(
    input [4:0] IF_ID_rs1,
    input [4:0] IF_ID_rs2,
    input [4:0] EX_MEM_rd,
    input EX_MEM_RegWrite,
    input EX_MEM_MemRead,   
    output ForwardA_ID,
    output ForwardB_ID
);

    assign ForwardA_ID = EX_MEM_RegWrite & (~EX_MEM_MemRead) & (EX_MEM_rd != 5'b0) & (EX_MEM_rd == IF_ID_rs1);
    assign ForwardB_ID = EX_MEM_RegWrite & (~EX_MEM_MemRead) & (EX_MEM_rd != 5'b0) & (EX_MEM_rd == IF_ID_rs2);

endmodule