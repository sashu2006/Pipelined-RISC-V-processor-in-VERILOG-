`timescale 1ns/1ns

`define IMEM_SIZE 4096

module Instr_Mem(addr, instr);
input [63:0] addr;
output reg [31:0] instr;

reg [7:0] Instr_Memory[0:`IMEM_SIZE - 1];

integer i;
initial begin
    for( i = 0 ; i<`IMEM_SIZE; i = i+1 ) begin   
        Instr_Memory[i] = 8'b0;
    end
    $readmemh("instructions.txt", Instr_Memory);
end

always @(*) begin
    instr[31:24] = Instr_Memory[addr];
    instr[23:16] = Instr_Memory[addr+1];
    instr[15:8]  = Instr_Memory[addr+2];
    instr[7:0]   = Instr_Memory[addr+3];
end

endmodule

