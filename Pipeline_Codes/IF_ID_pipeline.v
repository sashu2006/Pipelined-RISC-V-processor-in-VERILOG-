`timescale 1ns/1ns

module IF_ID_pipeline(instr, clk, reset, flush, stall, instr_out, pc, pc_out);
input [31:0] instr;
output reg [31:0] instr_out;
input [63:0] pc;
output reg [63:0] pc_out;
input flush, stall, reset, clk;

always @ (posedge clk) begin
    if(reset == 1'b1) begin
        pc_out <= 64'b0;
        instr_out <= 32'b0; //remember to check with pranav what to set eh instruction to in case of a flush
    end
    else if(flush == 1'b1) begin
        pc_out <= 64'b0;
        instr_out <= 32'b0;//same here
    end
    else if(stall == 1'b1) begin
        pc_out <= pc;
        instr_out <= instr;
    end
end

endmodule


