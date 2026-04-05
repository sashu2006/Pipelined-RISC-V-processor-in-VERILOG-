


`timescale 1ns/1ns
`include "seq_processor.v"

module seq_tb;
    reg clk;
    reg reset;
    integer cycles;
    integer f;
    integer i;
    integer k;

    reg [63:0] prev_pc;
    seq_processor dut (.clk(clk), .reset(reset));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveforms.vcd");    
        
        $dumpvars(0, clk);             
        $dumpvars(0, dut.reg_file);   
        $dumpvars(0, dut.data_mem);    

        for (k = 0; k < 16; k = k + 1) begin
            $dumpvars(0, dut.data_mem.data_reg[k]); 
        end

        $dumpvars(0, dut.reg_file.reg_file[4]); 
        $dumpvars(0, dut.reg_file.reg_file[5]);
    end

    initial begin
        clk = 0;
        reset = 1;
        cycles = 0;
        prev_pc = 64'hFFFFFFFFFFFFFFFF; 
        
        #20; 
        reset = 0;
    end

    always @(posedge clk) begin
        if (reset == 1'b0) begin
            cycles = cycles + 1;
        end
    end

    always @(negedge clk) begin
        if (reset == 1'b0) begin
            if (dut.curr_instr === 32'h00000000) begin
                cycles = cycles + 1;
                $display("\nProgram finished.");
                dump_and_finish();
            end
            prev_pc = dut.pc;
        end
    end
    
    task dump_and_finish;
        begin
            f = $fopen("register_file.txt", "w");
            for (i = 0; i < 32; i = i + 1) begin
                $fdisplay(f, "%016x", dut.reg_file.reg_file[i]); 
            end
            $fdisplay(f, "%0d", cycles);
            $fclose(f);
            $display("Results successfully written to register_file.txt\n");
            $finish;
        end
    endtask

endmodule