`include "full_adder_64_bit.v"
`include "shifter_64_bit.v"
`include "slt.v"
`include "sltu.v"
`include "xor_gate.v"
`include "or_gate.v"
`include "and_gate.v"
`include "mux.v"
`include "full_adder_1_bit.v"


module alu_64_bit(a, b, opcode, result, cout, carry_flag, overflow_flag, zero_flag);

    input [63:0] a;
    input [63:0] b;
    input [3:0] opcode;
    output reg [63:0] result;      
    output reg cout;                
    output reg carry_flag;          
    output reg overflow_flag;       
    output wire zero_flag;           

    wire [63:0] sum_out, sub_out, sll_out, srl_out, sra_out;
    wire [63:0] slt_out, sltu_out, xor_out, or_out, and_out;
    wire [63:0] a_rev, temp_sll;
    wire cout_add,cout_sub,cout_sll,cout_srl,cout_sra,cout_slt,cout_sltu,cout_and,cout_or,cout_xor;
    wire cflag_add,cflag_sub,cflag_sll,cflag_srl,cflag_sra,cflag_slt,cflag_sltu,cflag_and,cflag_or,cflag_xor;
    wire oflag_add,oflag_sub,oflag_sll,oflag_srl,oflag_sra,oflag_slt,oflag_sltu,oflag_and,oflag_or,oflag_xor;

    genvar k;
    generate
        for (k=0; k<64; k=k+1) begin: reverse
            assign a_rev[k]=a[63-k];
            assign sll_out[k]= temp_sll[63-k];
        end
    endgenerate

    full_adder_64_bit oper0 (.a(a), .b(b), .cin(1'b0), .sum(sum_out), .carry_out(cout_add), .carry_flag(cflag_add),.overflow_flag(oflag_add));

    shifter_64_bit oper1 (.a(a_rev), .b(b), .c(temp_sll), .extend_bit(1'b0),.carry_out(cout_sll), .carry_flag(cflag_sll),.overflow_flag(oflag_sll));

    slt oper2 (.a(a), .b(b), .c(slt_out),.carry_out(cout_slt), .carry_flag(cflag_slt),.overflow_flag(oflag_slt));

    sltu oper3 (.a(a), .b(b), .c(sltu_out),.carry_out(cout_sltu), .carry_flag(cflag_sltu),.overflow_flag(oflag_sltu));

    xor_gate oper4 (.a(a), .b(b), .c(xor_out),.carry_out(cout_xor), .carry_flag(cflag_xor),.overflow_flag(oflag_xor));

    shifter_64_bit oper5 (.a(a), .b(b), .c(srl_out), .extend_bit(1'b0),.carry_out(cout_srl), .carry_flag(cflag_srl),.overflow_flag(oflag_srl));

    or_gate oper6 (.a(a), .b(b), .c(or_out),.carry_out(cout_or), .carry_flag(cflag_or),.overflow_flag(oflag_or));

    and_gate oper7 (.a(a), .b(b), .c(and_out),.carry_out(cout_and), .carry_flag(cflag_and),.overflow_flag(oflag_and));

    full_adder_64_bit oper8 (.a(a), .b(b), .cin(1'b1), .sum(sub_out), .carry_out(cout_sub), .carry_flag(cflag_sub),.overflow_flag(oflag_sub));

    shifter_64_bit oper13 (.a(a), .b(b), .c(sra_out), .extend_bit(a[63]),.carry_out(cout_sra), .carry_flag(cflag_sra),.overflow_flag(oflag_sra));

    always @(*) begin
        result=64'b0;
        case (opcode)
            4'b0000: begin
                result=sum_out;
                carry_flag=cflag_add;
                overflow_flag=oflag_add;
            end
            4'b0001: begin
                result=sll_out;
                carry_flag=cflag_sll;
                overflow_flag=oflag_sll;
            end
            4'b0010: begin
                result=slt_out;
                carry_flag=cflag_slt;
                overflow_flag=oflag_slt;
            end
            4'b0011: begin
                result=sltu_out;
                carry_flag=cflag_sltu;
                overflow_flag=oflag_sltu;
            end
            4'b0100: begin
                result=xor_out;
                carry_flag=cflag_xor;
                overflow_flag=oflag_xor;
            end
            4'b0101: begin
                result=srl_out;
                carry_flag=cflag_srl;
                overflow_flag=oflag_srl;
            end
            4'b0110: begin
                result=or_out;
                carry_flag=cflag_or;
                overflow_flag=oflag_or;
            end
            4'b0111: begin
                result=and_out;
                carry_flag=cflag_and;
                overflow_flag=oflag_and;
            end
            4'b1000: begin
                result=sub_out;
                carry_flag=cflag_sub;
                overflow_flag=oflag_sub;
            end
            4'b1101: begin
                result=sra_out;
                carry_flag=cflag_sra;
                overflow_flag=oflag_sra;
            end
            default: result=64'b0;
        endcase
    end

    assign zero_flag=(result==64'b0); 

endmodule

