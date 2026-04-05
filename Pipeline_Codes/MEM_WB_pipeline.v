`timescale 1ns/1ns

module MEM_WB_pipeline(clk, reset, RegWrite, MemRead,MemtoReg, rd, Data_mem, ALURes, RegWrite_out, MemRead_out,MemtoReg_out, rd_out, Data_mem_out, ALURes_out);
output reg [4:0] rd_out;
output reg [63:0] ALURes_out;
output reg [63:0] Data_mem_out;
output reg RegWrite_out, MemtoReg_out,MemRead_out;
input [4:0] rd;
input [63:0] Data_mem;
input [63:0] ALURes;
input RegWrite, MemtoReg,MemRead;
input clk, reset;

always @ (posedge clk) begin
    if(reset == 1'b1) begin
        rd_out <= 5'b0;
        RegWrite_out <= 1'b0;
        MemtoReg_out <= 1'b0;
        ALURes_out <= 64'b0;
        Data_mem_out <= 64'b0;
        MemRead_out<=1'b0;
    end
    else begin
        rd_out <= rd;
        ALURes_out <= ALURes;
        Data_mem_out <= Data_mem;
        RegWrite_out <= RegWrite;
        MemtoReg_out <= MemtoReg;
        MemRead_out<=MemRead;   
    end
end
endmodule


