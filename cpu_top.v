module cpu_top (
    input clk,
    input reset
);

wire [31:0] pc;
reg  [31:0] next_pc;

wire [31:0] instruction;

wire [6:0] opcode;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [2:0] funct3;
wire [6:0] funct7;

wire [31:0] read_data1;
wire [31:0] read_data2;

wire [31:0] immediate;

wire [2:0] alu_control_signal;
wire [31:0] alu_b;
wire [31:0] alu_result;
wire zero;

wire reg_write;
wire mem_read;
wire mem_write;
wire mem_to_reg;
wire alu_src;
wire branch;

wire [31:0] memory_data;
reg  [31:0] write_back_data;


// Program Counter
program_counter pc_unit (
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)
);


// Instruction Memory
instruction_memory imem (
    .address(pc),
    .instruction(instruction)
);


// Instruction Decoder
decoder decoder_unit (
    .instruction(instruction),
    .opcode(opcode),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .funct3(funct3),
    .funct7(funct7)
);


// Control Unit
control_unit control_unit1 (
    .opcode(opcode),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src),
    .branch(branch)
);


// Register File
register_file registers (
    .clk(clk),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_back_data),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
);


// Immediate Generator
immediate_generator imm_unit (
    .instruction(instruction),
    .immediate(immediate)
);


// ALU Control
alu_control alu_control_unit (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .alu_control(alu_control_signal)
);


// Select second ALU input
assign alu_b = (alu_src) ? immediate : read_data2;


// ALU
alu alu_unit (
    .a(read_data1),
    .b(alu_b),
    .alu_control(alu_control_signal),
    .result(alu_result),
    .zero(zero)
);


// Data Memory
data_memory dmem (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(memory_data)
);


// Write Back
always @(*) begin
    if (mem_to_reg)
        write_back_data = memory_data;
    else
        write_back_data = alu_result;
end


// Next PC
always @(*) begin

    if (branch && zero)
        next_pc = pc + immediate;
    else
        next_pc = pc + 32'd4;

end

endmodule