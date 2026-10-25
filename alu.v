module alu(
    input [31:0] a,
    input [31:0] b,
    input [1:0] alu_control,
    output reg [31:0] result,
    output zero
);

always @(*) begin

    case (alu_control)

        2'b00: result = a + b;  // Addition
        2'b01: result = a - b;  // Subtraction
        2'b10: result = a & b;  // AND
        2'b11: result = a | b;  // OR

        default: result = 0;

    endcase

end

assign zero = (result == 0);

endmodule