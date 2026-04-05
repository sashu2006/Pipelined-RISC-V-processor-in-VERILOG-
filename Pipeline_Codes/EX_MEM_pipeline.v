`timescale 1ns/1ns

module EX_MEM_pipeline(rd,rs2,rs2_out, ALURes, Write_Data, MemWrite, MemRead,RegWrite, MemtoReg, clk, reset, rd_out, ALURes_out, Write_Data_out, MemWrite_out, MemRead_out, RegWrite_out, MemtoReg_out);
input [4:0] rd;
input [4:0] rs2; // for addn forwarding
input [63:0] ALURes;
input [63:0] Write_Data;
input MemWrite, MemRead;
input RegWrite, MemtoReg;
input clk, reset;
output reg [4:0] rd_out;
output reg [4:0] rs2_out;
output reg [63:0] ALURes_out;
output reg [63:0] Write_Data_out;
output reg MemRead_out, MemWrite_out;
output reg RegWrite_out, MemtoReg_out;

always @ (posedge clk) begin
    if(reset == 1'b1) begin
        rd_out <= 5'b0;
        rs2_out <= 5'b0;
        ALURes_out <= 64'b0;
        Write_Data_out <= 64'b0;
        MemRead_out <= 1'b0;
        MemWrite_out <= 1'b0;
        RegWrite_out <= 1'b0;
        MemtoReg_out <= 1'b0;
    end
    else begin
        rd_out <= rd;
        rs2_out <= rs2;
        ALURes_out <= ALURes;
        Write_Data_out <= Write_Data;
        MemRead_out <= MemRead;
        MemWrite_out <= MemWrite;
        RegWrite_out <= RegWrite;
        MemtoReg_out <= MemtoReg;     
    end
end
endmodule


