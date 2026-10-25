module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg reg_write,
    output reg mem_write,
    output reg alu_src,
    output reg branch,
    output reg mem_to_reg,

    output reg [1:0] imm_src,
    output reg [1:0] alu_control
);

always @(*) begin

    // Default values
    reg_write = 0;
    mem_write = 0;
    alu_src = 0;
    branch = 0;
    mem_to_reg = 0;
    imm_src = 0;
    alu_control = 0;

    case (opcode)

        // R-type instructions
        7'b0110011: begin

            reg_write = 1;

            case (funct3)

                3'b000: begin
                    if (funct7[5])
                        alu_control = 2'b01;  // SUB
                    else
                        alu_control = 2'b00;  // ADD
                end

                3'b111:
                    alu_control = 2'b10;      // AND

                3'b110:
                    alu_control = 2'b11;      // OR

                default:
                    alu_control = 2'b00;

            endcase

        end

        // ADDI
        7'b0010011: begin
            reg_write = 1;
            alu_src = 1;
            alu_control = 2'b00;
        end

        // LW
        7'b0000011: begin
            reg_write = 1;
            alu_src = 1;
            mem_to_reg = 1;
        end

        // SW
        7'b0100011: begin
            mem_write = 1;
            alu_src = 1;
            imm_src = 2'b01;
        end

        // BEQ
        7'b1100011: begin
            branch = 1;
            imm_src = 2'b10;
            alu_control = 2'b01;
        end

        default: begin
        end

    endcase

end

endmodule