`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 07:41:03 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [2:0] alu_control
);

always @(*) begin

    // R-type instructions
    if (opcode == 7'b0110011) begin

        case (funct3)

            3'b000: begin
                if (funct7 == 7'b0100000)
                    alu_control = 3'b001;   // SUB
                else
                    alu_control = 3'b000;   // ADD
            end

            3'b111: alu_control = 3'b010;   // AND
            3'b110: alu_control = 3'b011;   // OR

            default: alu_control = 3'b000;

        endcase

    end

    // ADDI
    else if (opcode == 7'b0010011) begin
        alu_control = 3'b000;
    end

    // LW and SW need addition for address calculation
    else if (opcode == 7'b0000011 || opcode == 7'b0100011) begin
        alu_control = 3'b000;
    end

    // BEQ uses subtraction to check equality
    else if (opcode == 7'b1100011) begin
        alu_control = 3'b001;
    end

    else begin
        alu_control = 3'b000;
    end

end

endmodule
