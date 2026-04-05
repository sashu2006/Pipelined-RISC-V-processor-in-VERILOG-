module alu_control(ALUOp,funct3,funct7,ALUControl);
    input wire [1:0]ALUOp;
    input wire [2:0]funct3;
    input wire funct7;
    output reg [3:0]ALUControl;

    always @(*)
    begin
        case(ALUOp)
            2'b00: begin
                ALUControl=4'b0000;
            end

            2'b01: begin
                ALUControl=4'b1000;
            end

            2'b11: begin
                ALUControl=4'b0000;
            end

            2'b10: begin
                case(funct3) 
                    3'b000: begin
                        case(funct7)
                            1'b0: begin
                                ALUControl=4'b0000;
                            end

                            1'b1: begin
                                ALUControl=4'b1000;
                            end

                        endcase
                    end

                    3'b111: begin
                        ALUControl=4'b0111;
                    end

                    3'b110: begin
                        ALUControl=4'b0110;
                    end
                endcase
            end
            
        endcase
    end
endmodule