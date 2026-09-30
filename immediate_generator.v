`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 07:34:36 PM
// Design Name: 
// Module Name: immediate_generator
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


module immediate_generator (
    input [31:0] instruction,
    output reg [31:0] immediate
);

always @(*) begin

    case (instruction[6:0])

        // I-type : ADDI, LW
        7'b0010011,
        7'b0000011:
            immediate = {{20{instruction[31]}}, instruction[31:20]};

        // S-type : SW
        7'b0100011:
            immediate = {{20{instruction[31]}},
                         instruction[31:25],
                         instruction[11:7]};

        // B-type : BEQ
        7'b1100011:
            immediate = {{19{instruction[31]}},
                         instruction[31],
                         instruction[7],
                         instruction[30:25],
                         instruction[11:8],
                         1'b0};

        default:
            immediate = 32'b0;

    endcase
end

endmodule
