`include "alu_control.v"
`include "Data_Mem.v"
`include "imm_gen.v"
`include "Instr_Mem.v"
`include "reg_file.v"
`include "shift_left_1.v"
`include "pc.v"
`include "control_unit.v"
`include "adder.v"
`include "fa.v"
`include "alu.v"
`include "mux_64.v"



module seq_processor(clk,reset);

    input wire clk,reset;
    wire [63:0] four;
    assign four=64'd4;
    wire[63:0]pc;
    wire [63:0]pc_in;

    wire [63:0] instr_addr;
    wire [31:0] curr_instr;
    wire [63:0] write_data;
    wire [63:0] read_data_mem;
    wire [63:0] imm_ext;


    wire [63:0]read_data1,read_data2;

    wire[63:0]operand_1,operand_2;

    wire[3:0]ALUControl;
    wire[63:0] alu_result;

    wire cout, carry_flag, overflow_flag, zero_flag;

    wire[1:0]ALUOp; 
    wire MemRead,MemWrite,MemtoReg,Branch,reg_write_en,ALUSrc;
    wire PCsrc;

    wire [63:0]pc_inc,branch_pc;
    wire [63:0] imm_shift;

    pc pc_module(
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc)
    );
    assign instr_addr=pc;

    adder pc_incrementer(.a(pc),.b(four),.sum(pc_inc));

    Instr_Mem instr_mem(
        .addr(instr_addr),
        .instr(curr_instr)
    );

    control_unit control_unit(
    .opcode(curr_instr[6:0]),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(reg_write_en)
    );

    reg_file reg_file(
        .clk(clk),
        .reset(reset),
        .read_reg1(curr_instr[19:15]),
        .read_reg2(curr_instr[24:20]),
        .write_reg(curr_instr[11:7]),
        .write_data(write_data),
        .reg_write_en(reg_write_en),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    alu_control alu_control(
        .ALUOp(ALUOp),
        .funct3(curr_instr[14:12]),
        .funct7(curr_instr[30]),
        .ALUControl(ALUControl)
    );

    imm_gen imm_gen(
        .instr(curr_instr),
        .imm_ext(imm_ext)
    );

    assign operand_1=read_data1;

    alu_64_bit alu(
        .a(operand_1),
        .b(operand_2),
        .opcode(ALUControl),
        .result(alu_result),
        .cout(cout),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag),
        .zero_flag(zero_flag)
    );

    and(PCsrc,Branch,zero_flag);

    shift_left_1 shifter(
        .imm_in(imm_ext),
        .imm_out(imm_shift)
    );


    adder branch_target(.a(pc),.b(imm_shift),.sum(branch_pc));

    data_mem data_mem(
        .clk(clk),
        .reset(reset),
        .address(alu_result),
        .write_data(read_data2),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .read_data(read_data_mem)
    );

    mux_64 wb_mux(.I0(alu_result),.I1(read_data_mem),.S(MemtoReg),.Y(write_data));
    mux_64 alu_mux(.I0(read_data2),.I1(imm_ext),.S(ALUSrc),.Y(operand_2));
    mux_64 pc_mux(.I0(pc_inc),.I1(branch_pc),.S(PCsrc),.Y(pc_in));

   



endmodule