`timescale 1ns/1ns
`include "mux.v"
`include "full_adder.v"
`include "add.v"
`include "sub.v"
`include "and_64.v"
`include "or_64.v"
`include "xor_64.v"
`include "sll.v"
`include "srl.v"
`include "sra.v"
`include "slt.v"
`include "sltu.v"


module alu_64_bit (a,b,opcode,result,cout,carry_flag,overflow_flag,zero_flag);
input [63:0] a;
input [63:0] b;
input [3:0] opcode;
output [63:0] result;
output cout;
output carry_flag;
output overflow_flag;
output zero_flag;

//wires for add function;
wire [63:0] out_add;
wire cout_add,carry_add,overflow_flag_add,zero_flag_add;

//wires for sub function;
wire [63:0] out_sub;
wire cout_sub,carry_sub,overflow_flag_sub,zero_flag_sub;

//wires for and function;
wire [63:0] out_and;
wire cout_and,carry_and,overflow_flag_and,zero_flag_and;

//wires for or function;
wire [63:0] out_or;
wire cout_or,carry_or,overflow_flag_or,zero_flag_or;

//wires for xor function;
wire [63:0] out_xor;
wire cout_xor,carry_xor,overflow_flag_xor,zero_flag_xor;

//wires for sll function;
wire [63:0] out_sll;
wire cout_sll,carry_sll,overflow_flag_sll,zero_flag_sll;

//wires for srl function;
wire [63:0] out_srl;
wire cout_srl,carry_srl,overflow_flag_srl,zero_flag_srl;

//wires for sra function;
wire [63:0] out_sra;
wire cout_sra,carry_sra,overflow_flag_sra,zero_flag_sra;

//wires for slt function;
wire [63:0] out_slt;
wire cout_slt,carry_slt,overflow_flag_slt,zero_flag_slt;

//wires for sltu function;
wire [63:0] out_sltu;
wire cout_sltu,carry_sltu,overflow_flag_sltu,zero_flag_sltu;

reg [63:0] ans;
reg zero, overflow, carry, cout_reg;

assign result = ans;
assign zero_flag = zero;
assign carry_flag = carry;
assign cout = cout_reg;
assign overflow_flag = overflow;

//running the functions;

add     op1  (.x(a), .y(b), .z(out_add), .cout(cout_add), .carry(carry_add), .overflow(overflow_flag_add), .zero(zero_flag_add));
sub     op2  (.x(a), .y(b), .z(out_sub), .cout(cout_sub), .carry(carry_sub), .overflow(overflow_flag_sub), .zero(zero_flag_sub));
xor_64  op3  (.x(a), .y(b), .z(out_xor), .cout(cout_xor), .carry(carry_xor), .overflow(overflow_flag_xor), .zero(zero_flag_xor));
or_64   op4  (.x(a), .y(b), .z(out_or),  .cout(cout_or),  .carry(carry_or),  .overflow(overflow_flag_or),  .zero(zero_flag_or));
and_64  op5  (.x(a), .y(b), .z(out_and), .cout(cout_and), .carry(carry_and), .overflow(overflow_flag_and), .zero(zero_flag_and));
sll     op6  (.x(a), .shift(b), .y(out_sll), .cout(cout_sll), .carry(carry_sll), .overflow(overflow_flag_sll), .zero(zero_flag_sll));
srl     op7  (.x(a), .shift(b), .y(out_srl), .cout(cout_srl), .carry(carry_srl), .overflow(overflow_flag_srl), .zero(zero_flag_srl));
sra     op8  (.x(a), .shift(b), .y(out_sra), .cout(cout_sra), .carry(carry_sra), .overflow(overflow_flag_sra), .zero(zero_flag_sra));
slt     op9  (.x(a), .y(b), .set_val(out_slt),  .cout(cout_slt),  .carry(carry_slt),  .overflow(overflow_flag_slt),  .zero(zero_flag_slt));
sltu    op10 (.x(a), .y(b), .set_val(out_sltu), .cout(cout_sltu), .carry(carry_sltu), .overflow(overflow_flag_sltu), .zero(zero_flag_sltu));


//case switch statements
always @(*) begin // this always we execute
    ans = 64'b0;
    zero = 0;
    overflow = 0;
    carry = 0;
    cout_reg = 0;

    case(opcode)

        4'b0000: begin
            ans = out_add;
            zero = zero_flag_add;
            overflow = overflow_flag_add;
            carry = carry_add;
            cout_reg = cout_add;
        end

        4'b1000: begin
            ans = out_sub;
            zero = zero_flag_sub;
            overflow = overflow_flag_sub;
            carry = carry_sub;
            cout_reg = cout_sub;
        end

        4'b0100: begin
            ans = out_xor;
            zero = zero_flag_xor;
            overflow = overflow_flag_xor;
            carry = carry_xor;
            cout_reg = cout_xor;
        end

        4'b0111: begin
            ans = out_and;
            zero = zero_flag_and;
            overflow = overflow_flag_and;
            carry = carry_and;
            cout_reg = cout_and;
        end

        4'b0110: begin
            ans = out_or;
            zero = zero_flag_or;
            overflow = overflow_flag_or;
            carry = carry_or;
            cout_reg = cout_or;
        end

        4'b0001: begin
            ans = out_sll;
            zero = zero_flag_sll;
            overflow = overflow_flag_sll;
            carry = carry_sll;
            cout_reg = cout_sll;
        end

        4'b0010: begin
            ans = out_slt;
            zero = zero_flag_slt;
            overflow = overflow_flag_slt;
            carry = carry_slt;
            cout_reg = cout_slt;
        end

        4'b0011: begin
            ans = out_sltu;
            zero = zero_flag_sltu;
            overflow = overflow_flag_sltu;
            carry = carry_sltu;
            cout_reg = cout_sltu;
        end

        4'b1101: begin
            ans = out_sra;
            zero = zero_flag_sra;
            overflow = overflow_flag_sra;
            carry = carry_sra;
            cout_reg = cout_sra;
        end

        4'b0101: begin
            ans = out_srl;
            zero = zero_flag_srl;
            overflow = overflow_flag_srl;
            carry = carry_srl;
            cout_reg = cout_srl;
        end

        default ans = 64'b0; //if none of the opcodes havve matched
    endcase
end

endmodule



