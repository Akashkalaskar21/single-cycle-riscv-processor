module imm_gen(
    input [31:0] instruction,
    input [1:0] imm_src,
    output reg [31:0] immediate
);

always @(*) begin

    case (imm_src)

        // I-type: ADDI, LW
        2'b00:
            immediate = {
                {20{instruction[31]}},
                instruction[31:20]
            };

        // S-type: SW
        2'b01:
            immediate = {
                {20{instruction[31]}},
                instruction[31:25],
                instruction[11:7]
            };

        // B-type: BEQ
        2'b10:
            immediate = {
                {19{instruction[31]}},
                instruction[31],
                instruction[7],
                instruction[30:25],
                instruction[11:8],
                1'b0
            };

        default:
            immediate = 0;

    endcase

end

endmodule