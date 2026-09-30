`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 07:43:44 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit (
    input [6:0] opcode,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg alu_src,
    output reg branch
);

always @(*) begin

    // Default values
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    mem_to_reg = 0;
    alu_src = 0;
    branch = 0;

    case (opcode)

        // R-type: ADD, SUB, AND, OR
        7'b0110011: begin
            reg_write = 1;
        end

        // ADDI
        7'b0010011: begin
            reg_write = 1;
            alu_src = 1;
        end

        // LW
        7'b0000011: begin
            reg_write = 1;
            mem_read = 1;
            mem_to_reg = 1;
            alu_src = 1;
        end

        // SW
        7'b0100011: begin
            mem_write = 1;
            alu_src = 1;
        end

        // BEQ
        7'b1100011: begin
            branch = 1;
        end

        default: begin
        end

    endcase
end

endmodule
