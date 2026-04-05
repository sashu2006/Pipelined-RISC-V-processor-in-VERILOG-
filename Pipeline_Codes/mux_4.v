module mux_4(i0,i1,i2,i3,s,y);
    input wire [63:0] i0,i1,i2,i3;
    input wire [1:0] s;
    output reg [63:0] y;

    always @(*) begin
        case (s)

            2'b00: begin
                y=i0;
            end

            2'b01: begin
                y=i1;
            end

            2'b10: begin
                y=i2;
            end

            2'b11: begin
                y=i3;
            end
            default: begin
                y=64'b0;
            end
        endcase
    end
endmodule