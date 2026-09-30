`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2026 07:31:33 PM
// Design Name: 
// Module Name: alu
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


module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [2:0]  alu_control,

    output reg  [31:0] result,
    output wire        zero
);

always @(*) begin
    case (alu_control)

        3'b000: result = a + b;  // ADD
        3'b001: result = a - b;  // SUB
        3'b010: result = a & b;  // AND
        3'b011: result = a | b;  // OR

        default: result = 32'b0;

    endcase
end

assign zero = (result == 32'b0);

endmodule