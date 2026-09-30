`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 07:20:10 PM
// Design Name: 
// Module Name: instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

reg [31:0] memory [0:255];

initial begin
    // ADDI x1, x0, 10
    memory[0] = 32'h00A00093;

    // ADDI x2, x0, 20
    memory[1] = 32'h01400113;

    // ADD x3, x1, x2
    memory[2] = 32'h002081B3;

    // SUB x4, x3, x1
    memory[3] = 32'h40118233;

    // AND x5, x1, x2
    memory[4] = 32'h0020F2B3;

    // OR x6, x1, x2
    memory[5] = 32'h0020E333;

    // ADDI x7, x0, 100
    memory[6] = 32'h06400393;

    // SW x3, 0(x7)
    memory[7] = 32'h0033A023;

    // LW x8, 0(x7)
    memory[8] = 32'h0003A403;

    // BEQ x8, x3, +8
    memory[9] = 32'h00340463;

    // ADDI x9, x0, 999
    memory[10] = 32'h3E700493;

    // ADDI x10, x0, 55
    memory[11] = 32'h03700513;
end

assign instruction = memory[address[9:2]];

endmodule
