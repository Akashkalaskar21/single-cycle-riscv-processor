module instruction_memory(
    input [31:0] address,
    output reg [31:0] instruction
);

reg [31:0] memory [0:63];

integer i;

initial begin

    // Fill unused locations with NOP instructions
    for (i = 0; i < 64; i = i + 1)
        memory[i] = 32'h00000013;

    // ADDI x1, x0, 10
    memory[0] = 32'h00A00093;

    // ADDI x2, x0, 5
    memory[1] = 32'h00500113;

    // ADD x3, x1, x2
    memory[2] = 32'h002081B3;

    // SUB x4, x1, x2
    memory[3] = 32'h40208233;

    // AND x5, x1, x2
    memory[4] = 32'h0020F2B3;

    // OR x6, x1, x2
    memory[5] = 32'h0020E333;

    // SW x3, 0(x0)
    memory[6] = 32'h00302023;

    // LW x7, 0(x0)
    memory[7] = 32'h00002383;

    // BEQ x3, x6, +8
    memory[8] = 32'h00618463;

    // This instruction should be skipped
    // ADDI x8, x0, 99
    memory[9] = 32'h06300413;

    // ADDI x9, x0, 7
    memory[10] = 32'h00700493;

end

// Each instruction occupies 4 bytes
always @(*) begin

    if (address < 256)
        instruction = memory[address[7:2]];
    else
        instruction = 32'h00000013;

end

endmodule