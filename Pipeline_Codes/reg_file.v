module reg_file(clk, reset, read_reg1, read_reg2, write_reg, write_data, reg_write_en,read_data1, read_data2);
    input wire clk,reset,reg_write_en;
    input wire [4:0] read_reg1,read_reg2,write_reg;
    input wire [63:0] write_data;
    output wire [63:0] read_data1,read_data2;

    reg [63:0] reg_file [31:0];

    assign read_data1=reg_file[read_reg1];
    assign read_data2=reg_file[read_reg2];

    integer i;
    always @(negedge clk or posedge reset) begin
        if(reset==1'b1) begin
            
            for (i=0;i<32;i=i+1) begin:initialization
                reg_file[i][63:0]<=64'b0;
            end
        end
        
        else if(reg_write_en==1'b1 && write_reg !=5'b0) begin
            reg_file[write_reg]<=write_data;
        end
    end


    
endmodule