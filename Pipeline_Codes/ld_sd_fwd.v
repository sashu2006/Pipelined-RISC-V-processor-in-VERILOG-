`timescale 1ns/1ns

module ld_sd_fwd(
    input [4:0] EX_MEM_rs2,
    input EX_MEM_MemWrite,
    input [4:0] MEM_WB_rd,
    input MEM_WB_MemRead,
    output Forward_Mem
);
assign Forward_Mem = EX_MEM_MemWrite & MEM_WB_MemRead & (MEM_WB_rd != 5'b0) & (MEM_WB_rd == EX_MEM_rs2);

endmodule