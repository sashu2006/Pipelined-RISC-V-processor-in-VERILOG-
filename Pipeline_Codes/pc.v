module pc (
    input clk,
    input reset,
    input [63:0] pc_in,
    input PCWrite,
    output reg [63:0] pc_out
);

always @(posedge clk) begin
    if(reset==1'b1) begin
        pc_out<=64'b0;
    end

    else if(PCWrite==1'b1) begin
        pc_out<=pc_in;
    end
end

endmodule