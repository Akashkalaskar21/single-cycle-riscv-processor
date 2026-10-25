`timescale 1ns / 1ps

module riscv_tb;

reg clk;
reg reset;

wire [31:0] pc_out;
wire [31:0] instruction_out;


// Create processor
riscv_single_cycle uut(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .instruction_out(instruction_out)
);


// Generate clock
always #5 clk = ~clk;


initial begin

    clk = 0;
    reset = 1;

    // Reset the processor
    #12;
    reset = 0;

    // Run the program
    #130;

    // Display register values
    $display("----- PROCESSOR RESULTS -----");

    $display("x1 = %0d", uut.rf.registers[1]);
    $display("x2 = %0d", uut.rf.registers[2]);
    $display("x3 = %0d", uut.rf.registers[3]);
    $display("x4 = %0d", uut.rf.registers[4]);
    $display("x5 = %0d", uut.rf.registers[5]);
    $display("x6 = %0d", uut.rf.registers[6]);
    $display("x7 = %0d", uut.rf.registers[7]);
    $display("x8 = %0d", uut.rf.registers[8]);
    $display("x9 = %0d", uut.rf.registers[9]);

    $display("Memory[0] = %0d", uut.dmem.memory[0]);

    // Check expected results
    if (
        uut.rf.registers[1] == 10 &&
        uut.rf.registers[2] == 5  &&
        uut.rf.registers[3] == 15 &&
        uut.rf.registers[4] == 5  &&
        uut.rf.registers[5] == 0  &&
        uut.rf.registers[6] == 15 &&
        uut.rf.registers[7] == 15 &&
        uut.rf.registers[8] == 0  &&
        uut.rf.registers[9] == 7  &&
        uut.dmem.memory[0] == 15
    )

        $display("PASS: All processor tests completed successfully");

    else
        $display("FAIL: Check the processor and waveform");

    $finish;

end

endmodule