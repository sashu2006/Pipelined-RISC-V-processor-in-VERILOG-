module imm_gen(instr,imm_ext);
    input wire [31:0] instr;
    output reg [63:0] imm_ext;
    
    wire [6:0] opcode;
    assign opcode=instr[6:0];

    always @(*) begin

        case (opcode)
            7'b0010011: begin
                imm_ext[11:0]=instr[31:20];
                imm_ext[63:12]={52{imm_ext[11]}};
            end

            7'b0000011: begin
                imm_ext[11:0]=instr[31:20];
                imm_ext[63:12]={52{imm_ext[11]}};
            end

            7'b0100011: begin
                imm_ext[11:5]=instr[31:25];
                imm_ext[4:0]=instr[11:7];
                imm_ext[63:12]={52{imm_ext[11]}};
            end

            7'b1100011: begin
                imm_ext[11]=instr[31];
                imm_ext[9:4]=instr[30:25];
                imm_ext[3:0]=instr[11:8];
                imm_ext[10]=instr[7];
                imm_ext[63:12]={52{imm_ext[11]}};
            end

            default:
                imm_ext[63:0]=64'b0;
        endcase
    end
endmodule