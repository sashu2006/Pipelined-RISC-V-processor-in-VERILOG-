`timescale 1ns/1ns

module hazard_detection_unit(
    input [4:0] IF_ID_rs1,
    input [4:0] IF_ID_rs2,
    input Branch,           
    input MemWrite,         
    input Equal,            
    input [4:0] ID_EX_rd,
    input ID_EX_MemRead,   
    input ID_EX_RegWrite, 
    input [4:0] EX_MEM_rd,
    input EX_MEM_MemRead, 
    output PCWrite,        
    output IF_ID_Write,     
    output Stall_Flush,     
    output IF_Flush        
);

    wire load_use_stall = ID_EX_MemRead && (ID_EX_rd != 5'b0) && ( (ID_EX_rd == IF_ID_rs1) || ((ID_EX_rd == IF_ID_rs2) && ~MemWrite) );
    wire branch_stall_EX = Branch && ID_EX_RegWrite && (ID_EX_rd != 5'b0) && ((ID_EX_rd == IF_ID_rs1) || (ID_EX_rd == IF_ID_rs2));
    wire branch_stall_MEM = Branch && EX_MEM_MemRead && (EX_MEM_rd != 5'b0) && ((EX_MEM_rd == IF_ID_rs1) || (EX_MEM_rd == IF_ID_rs2));
    wire master_stall = load_use_stall | branch_stall_EX | branch_stall_MEM;

    assign PCWrite     = ~master_stall;
    assign IF_ID_Write = ~master_stall;
    assign Stall_Flush = master_stall;
    assign IF_Flush    = Branch & Equal & ~master_stall;

endmodule