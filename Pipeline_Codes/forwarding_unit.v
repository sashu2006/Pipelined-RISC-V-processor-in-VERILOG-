module forwarding_unit(ex_mem_rd,ex_mem_regwrite,mem_wb_rd,mem_wb_regwrite,id_ex_rs1,id_ex_rs2,forward_a,forward_b);

    input wire [4:0] ex_mem_rd,mem_wb_rd,id_ex_rs1,id_ex_rs2;
    input wire ex_mem_regwrite,mem_wb_regwrite;
    output reg [1:0] forward_a,forward_b;

    always @(*) begin

        forward_a=2'b00;
        forward_b=2'b00;

        if(ex_mem_rd!=5'b0 && ex_mem_regwrite==1'b1 && id_ex_rs1==ex_mem_rd) begin
            forward_a=2'b10;
        end

        else if(mem_wb_rd!=5'b0 && mem_wb_regwrite==1'b1 && id_ex_rs1==mem_wb_rd) begin
            forward_a=2'b01;
        end

        if(ex_mem_rd!=5'b0 && ex_mem_regwrite==1'b1 && id_ex_rs2==ex_mem_rd)begin
            forward_b=2'b10;
        end
        else if(mem_wb_rd!=5'b0 && mem_wb_regwrite==1'b1 && id_ex_rs2==mem_wb_rd) begin
            forward_b=2'b01;
        end

    end
endmodule