`timescale 1ns/1ns

module ID_EX_pipeline(rd, rs1, rs2, imm_ext, reg_data1, reg_data2, RegWrite, MemtoReg, ALUSrc, ALUOp, clk, reset, MemRead, MemWrite, func3, func7, rd_out, rs1_out, rs2_out, imm_ext_out, reg_data1_out, reg_data2_out, RegWrite_out, MemtoReg_out, ALUSrc_out, ALUOp_out, MemRead_out, MemWrite_out, func7_out, func3_out);
input [4:0] rd;
input [4:0] rs1;
input [4:0] rs2;
input func7;
input [2:0] func3;
input [63:0] imm_ext;
input [63:0] reg_data1;
input [63:0] reg_data2;
input RegWrite, MemtoReg;
input ALUSrc;
input [1:0] ALUOp;
input MemRead, MemWrite;
input clk, reset;

output reg func7_out;
output reg [2:0] func3_out;
output reg [4:0] rd_out;
output reg [4:0] rs1_out;
output reg [4:0] rs2_out;
output reg [63:0] imm_ext_out;
output reg [63:0] reg_data1_out;
output reg [63:0] reg_data2_out;
output reg RegWrite_out, MemtoReg_out;
output reg ALUSrc_out;
output reg [1:0] ALUOp_out;
output reg MemRead_out, MemWrite_out;

//stall and flush thevai illai

always @ (posedge clk) begin
    if(reset == 1'b1) begin
        rd_out <= 5'b0;
        rs1_out <= 5'b0;
        rs2_out <= 5'b0;
        func7_out <= 1'b0;
        func3_out <= 3'b0;
        imm_ext_out <= 64'b0;
        reg_data1_out <= 64'b0;
        reg_data2_out <= 64'b0;
        RegWrite_out <= 1'b0;
        MemtoReg_out <= 1'b0;
        ALUOp_out <= 2'b0;
        ALUSrc_out <= 1'b0;
        MemRead_out <= 1'b0;
        MemWrite_out <= 1'b0;
    end

    else begin
        rd_out <= rd;
        rs1_out <= rs1;
        rs2_out <= rs2;
        func7_out <= func7;
        func3_out <= func3;
        imm_ext_out <= imm_ext;
        reg_data1_out <= reg_data1;
        reg_data2_out <= reg_data2;
        RegWrite_out <= RegWrite;
        MemtoReg_out <= MemtoReg;
        ALUOp_out <= ALUOp;
        ALUSrc_out <= ALUSrc;
        MemRead_out <= MemRead;
        MemWrite_out <= MemWrite;
    end
end

    endmodule
