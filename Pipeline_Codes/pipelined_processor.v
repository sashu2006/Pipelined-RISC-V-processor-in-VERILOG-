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
`include "IF_ID_pipeline.v"
`include "ID_EX_pipeline.v"
`include "EX_MEM_pipeline.v"
`include "MEM_WB_pipeline.v"
`include "comparator.v"
`include "hazard_detection_unit.v"
`include "forwarding_unit.v"
`include "mux_4.v"
`include "stall_mux.v"
`include "ld_sd_fwd.v"
`include "Branch_Forwarding_Unit.v"



module pipelined_processor(clk,reset);

    input wire clk,reset;
    wire [63:0] four;
    assign four=64'd4;
    wire [63:0]pc_in; //INPUT TO PC
    wire [63:0]pc_out; //OUTPIT FROM PC
    wire PCWrite; //coming from HDU
    wire [31:0] curr_instr; //instruction coming out of instr mem currently
    wire [63:0] pc_inc; //pc+4
    wire flush_IF_ID; //flush signal to if/id reg
    wire stall_IF_ID;//stall signal for IF/ID register
    wire [31:0] instr_out_IF_ID;//instruction out of IF/ID register
    wire [63:0] pc_out_IF_ID; //PC out of IF/ID REG;
    wire [63:0] write_data; //WRITEBACK FRO  LAT MUX
    wire RegWrite_MEM_WB; //CONTROL SIGNAL FRO  LAT PIPELINE
    wire [63:0]read_data1; //
    wire [63:0]read_data2;
    wire [63:0] imm_ext;
    wire [63:0] imm_shift; //shifter immediate by 1 bit.
    wire [63:0] branch_target_address;//  Target in ID stage
    wire [63:0] ALURes_EX_MEM; //
    wire ctrl_rs1; //ctrl signal to rs1 mux in ID stage;
    wire ctrl_rs2; //ctrl signal to rs2 mux in ID stage;
    wire [63:0] comp_input_1; //fist input to comparator
    wire [63:0] comp_input_2; //second input to comparator
    wire branch_equality; //it is 1 if the registers are qual 0 if uneual
    wire[1:0]ALUOp; //NEWLY GENERATED
    wire MemRead,MemWrite,MemtoReg,Branch,RegWrite,ALUSrc;//NEWLY GENERATED
    wire PCsrc;
    wire [6:0]control_signals_input_array;
    wire [6:0]control_signals_output_array;
    wire stall_mux_control; //comes from HDU
    wire [4:0] rd_MEM_WB; //comes from last pipeline register
    wire [4:0] rd_ID_EX;
    wire [4:0] rs1_ID_EX;
    wire [4:0] rs2_ID_EX;
    wire [63:0] imm_ext_ID_EX;
    wire [63:0] data1_ID_EX;
    wire [63:0] data2_ID_EX;
    wire RegWrite_ID_EX;
    wire MemtoReg_ID_EX;
    wire ALUSrc_ID_EX;
    wire [1:0] ALUOp_ID_EX;
    wire MemRead_ID_EX;
    wire MemWrite_ID_EX;
    wire funct_7_ID_EX;
    wire [2:0] funct_3_ID_EX;
    wire [3:0] ALUControl;
    wire [63:0] ALURes_MEM_WB; // comes from MEM_WB pipeline (forwarding)
    wire [63:0] operand_1; // input 1 to alu
    wire [63:0] operand_2;
    wire [63:0] mid_operand; // between the 2 muxes in eX stage
    wire [1:0] forward_a;
    wire [1:0] forward_b; // both coming frommt eh forwarding unit
    wire [63:0] ALURes; // direct output of the ALU
    wire cout, carry_flag, overflow_flag, zero_flag; //take lite
    wire RegWrite_EX_MEM; // for forwarding unit
    wire [4:0] rd_EX_MEM; // for forwarding unit
    wire [63:0] write_data_EX_MEM; //DATA TO BE STORED COING FROM EX/MEM
    wire MemWrite_EX_MEM; //COMING OUT OF EX/MEM
    wire MemRead_EX_MEM; //COMING OUT OF EX/MEM
    wire MemtoReg_EX_MEM; //COMING OUT OF EX/MEM
    wire [4:0] rs2_EX_MEM; //RS2 COMING OUT OF EX/MEM
    wire [63:0] mem_out; //data read from memory
    wire MemRead_MEM_WB; //coming out of mem/wb pipeline
    wire mem_src; //this is a control signla for te mux which is used for the ld-sd fowarding unit
    wire [63:0] data_mem_input; // output of the ld_sd_mux which ges into the memory
    wire [63:0] mem_out_MEM_WB; // coming out of me/wb pipeline
    wire comp_ctrl_1;//
    wire comp_ctrl_2;
    wire MemtoReg_MEM_WB;
    wire [63:0] data_mem_out_MEM_WB;

    pc pc_module(
    .clk(clk),
    .reset(reset),
    .pc_in(pc_in),
    .PCWrite(PCWrite),
    .pc_out(pc_out));

    Instr_Mem instruction_memory(
        .addr(pc_out),//output from pc
        .instr(curr_instr)
    );

    adder adder(
        .a(pc_out),
        .b(four),
        .sum(pc_inc)
    );

    IF_ID_pipeline IF_ID(
        .instr(curr_instr),
        .clk(clk), 
        .reset(reset),
        .flush(flush_IF_ID), 
        .stall(stall_IF_ID),
        .instr_out(instr_out_IF_ID),
        .pc(pc_out),
        .pc_out(pc_out_IF_ID)
    );

    reg_file reg_file(
        .clk(clk),
        .reset(reset),
        .read_reg1(instr_out_IF_ID[19:15]),
        .read_reg2(instr_out_IF_ID[24:20]),
        .write_reg(rd_MEM_WB),//comes from last pieline
        .write_data(write_data),//REMMBEBT TO COONECT BACK
        .reg_write_en(RegWrite_MEM_WB),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    imm_gen imm_gen(
        .instr(instr_out_IF_ID),
        .imm_ext(imm_ext)
    );

    shift_left_1 shifter(
        .imm_in(imm_ext),
        .imm_out(imm_shift)
    );

    adder branch_target(
        .a(pc_out_IF_ID),
        .b(imm_shift),
        .sum(branch_target_address)
    );

    comparator comp(
        .data1(comp_input_1),
        .data2(comp_input_2),
        .equal(branch_equality)
    );

    control_unit control_unit(
    .opcode(instr_out_IF_ID[6:0]),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
    );

    and(PCsrc,branch_equality,Branch);
    mux_64 pc_mux(.I0(pc_inc),.I1(branch_target_address),.S(PCsrc),.Y(pc_in));

    assign control_signals_input_array[0]=RegWrite;
    assign control_signals_input_array[1]=MemtoReg;
    assign control_signals_input_array[2]=ALUSrc;
    assign control_signals_input_array[3]=ALUOp[0];
    assign control_signals_input_array[4]=ALUOp[1];
    assign control_signals_input_array[5]=MemRead;
    assign control_signals_input_array[6]=MemWrite;


    stall_mux stall_mux(
        .I0(control_signals_input_array),
        .S(stall_mux_control),
        .Y(control_signals_output_array)
    );

    ID_EX_pipeline ID_EX_pipeline(.rd(instr_out_IF_ID[11:7]),
    .rs1(instr_out_IF_ID[19:15]),
    .rs2(instr_out_IF_ID[24:20]),
    .imm_ext(imm_ext),
    .reg_data1(read_data1),
    .reg_data2(read_data2),
    .RegWrite(control_signals_output_array[0]),
    .MemtoReg(control_signals_output_array[1]),
    .ALUSrc(control_signals_output_array[2]),
    .ALUOp(control_signals_output_array[4:3]),
    .clk(clk),
    .reset(reset),
    .MemRead(control_signals_output_array[5]),
    .MemWrite(control_signals_output_array[6]),
    .func3(instr_out_IF_ID[14:12]),
    .func7(instr_out_IF_ID[30]),
    .rd_out(rd_ID_EX),
    .rs1_out(rs1_ID_EX),
    .rs2_out(rs2_ID_EX),
    .imm_ext_out(imm_ext_ID_EX),
    .reg_data1_out(data1_ID_EX),
    .reg_data2_out(data2_ID_EX),
    .RegWrite_out(RegWrite_ID_EX),
    .MemtoReg_out(MemtoReg_ID_EX),
    .ALUSrc_out(ALUSrc_ID_EX),
    .ALUOp_out(ALUOp_ID_EX),
    .MemRead_out(MemRead_ID_EX),
    .MemWrite_out(MemWrite_ID_EX),
    .func7_out(funct_7_ID_EX),
    .func3_out(funct_3_ID_EX)
    );

    alu_control alu_control(
        .ALUOp(ALUOp_ID_EX),
        .funct3(funct_3_ID_EX),
        .funct7(funct_7_ID_EX),
        .ALUControl(ALUControl)
    );

    mux_4 mux_a(
        .i0(data1_ID_EX),
        .i1(write_data),
        .i2(ALURes_EX_MEM),
        .i3(64'b0),
        .s(forward_a),
        .y(operand_1)
    );


    mux_4 mux_b(
        .i0(data2_ID_EX),
        .i1(write_data),
        .i2(ALURes_EX_MEM),
        .i3(64'b0),
        .s(forward_b),
        .y(mid_operand)
    );

    mux_64 alu_mux(
        .I0(mid_operand),
        .I1(imm_ext_ID_EX),
        .S(ALUSrc_ID_EX),
        .Y(operand_2)
    );



     alu_64_bit alu(
        .a(operand_1),
        .b(operand_2),
        .opcode(ALUControl),
        .result(ALURes),
        .cout(cout),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag),
        .zero_flag(zero_flag)
    );


// forwarding unit normal

    forwarding_unit forward_ex(
        .ex_mem_rd(rd_EX_MEM),
        .ex_mem_regwrite(RegWrite_EX_MEM),
        .mem_wb_rd(rd_MEM_WB),
        .mem_wb_regwrite(RegWrite_MEM_WB),
        .id_ex_rs1(rs1_ID_EX),
        .id_ex_rs2(rs2_ID_EX),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );

    EX_MEM_pipeline EX_MEM_pipeline(
        .rd(rd_ID_EX),
        .ALURes(ALURes),
        .Write_Data(mid_operand),
        .MemWrite(MemWrite_ID_EX),
        .MemRead(MemRead_ID_EX),
        .RegWrite(RegWrite_ID_EX),
        .MemtoReg(MemtoReg_ID_EX),
        .clk(clk),
        .reset(reset),
        .rs2(rs2_ID_EX),
        .rd_out(rd_EX_MEM),
        .ALURes_out(ALURes_EX_MEM),
        .Write_Data_out(write_data_EX_MEM),
        .MemWrite_out(MemWrite_EX_MEM),
        .MemRead_out(MemRead_EX_MEM),
        .RegWrite_out(RegWrite_EX_MEM),
        .MemtoReg_out(MemtoReg_EX_MEM),
        .rs2_out(rs2_EX_MEM)

    );

    data_mem data_mem(
        .clk(clk),
        .reset(reset),
        .address(ALURes_EX_MEM),
        .write_data(data_mem_input),
        .MemRead(MemRead_EX_MEM),
        .MemWrite(MemWrite_EX_MEM),
        .read_data(mem_out)
    );

    ld_sd_fwd ld_sd_fwd (
        .EX_MEM_rs2(rs2_EX_MEM),
        .EX_MEM_MemWrite(MemWrite_EX_MEM),
        .MEM_WB_rd(rd_MEM_WB),
        .MEM_WB_MemRead(MemRead_MEM_WB),
        .Forward_Mem(mem_src)
    );

    mux_64 ld_sd_mux(
        .I0(write_data_EX_MEM),
        .I1(data_mem_out_MEM_WB),
        .S(mem_src),
        .Y(data_mem_input)
    );

    Branch_Forwarding_Unit Branch_Forwarding_Unit(
        .IF_ID_rs1(instr_out_IF_ID[19:15]),
        .IF_ID_rs2(instr_out_IF_ID[24:20]),
        .EX_MEM_rd(rd_EX_MEM),
        .EX_MEM_RegWrite(RegWrite_EX_MEM),
        .EX_MEM_MemRead(MemRead_EX_MEM),   
        .ForwardA_ID(comp_ctrl_1),
        .ForwardB_ID(comp_ctrl_2)
    );

    mux_64 comp_sel_1(
        .I0(read_data1),
        .I1(ALURes_EX_MEM),
        .S(comp_ctrl_1),
        .Y(comp_input_1)
    );

    mux_64 comp_sel_2(
        .I0(read_data2),
        .I1(ALURes_EX_MEM),
        .S(comp_ctrl_2),
        .Y(comp_input_2)
    );

    hazard_detection_unit hazard_detection_unit (
        .IF_ID_rs1(instr_out_IF_ID[19:15]),
        .IF_ID_rs2(instr_out_IF_ID[24:20]),
        .Branch(Branch),           
        .MemWrite(MemWrite),         
        .Equal(branch_equality),            
        .ID_EX_rd(rd_ID_EX),
        .ID_EX_MemRead(MemRead_ID_EX),   
        .ID_EX_RegWrite(RegWrite_ID_EX), 
        .EX_MEM_rd(rd_EX_MEM),
        .EX_MEM_MemRead(MemRead_EX_MEM), 
        .PCWrite(PCWrite),        
        .IF_ID_Write(stall_IF_ID),     
        .Stall_Flush(stall_mux_control),     
        .IF_Flush(flush_IF_ID)     
    );

    MEM_WB_pipeline MEM_WB_pipeline(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite_EX_MEM),
        .MemRead(MemRead_EX_MEM),
        .MemtoReg(MemtoReg_EX_MEM),
        .rd(rd_EX_MEM),
        .Data_mem(mem_out),
        .ALURes(ALURes_EX_MEM),
        .RegWrite_out(RegWrite_MEM_WB),
        .MemRead_out(MemRead_MEM_WB),
        .MemtoReg_out(MemtoReg_MEM_WB),
        .rd_out(rd_MEM_WB),
        .Data_mem_out(data_mem_out_MEM_WB),
        .ALURes_out(ALURes_MEM_WB)
    );

    mux_64 wb_mux(.I0(ALURes_MEM_WB),.I1(data_mem_out_MEM_WB),.S(MemtoReg_MEM_WB),.Y(write_data));

endmodule