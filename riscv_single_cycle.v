module riscv_single_cycle(
    input clk,
    input reset,
    output [31:0] pc_out,
    output [31:0] instruction_out
);

reg [31:0] pc;

wire [31:0] instruction;

wire reg_write;
wire mem_write;
wire alu_src;
wire branch;
wire mem_to_reg;

wire [1:0] imm_src;
wire [1:0] alu_control;

wire [31:0] read_data1;
wire [31:0] read_data2;

wire [31:0] immediate;
wire [31:0] alu_input_b;
wire [31:0] alu_result;
wire zero;

wire [31:0] memory_data;
wire [31:0] write_back_data;

// Outputs for simulation
assign pc_out = pc;
assign instruction_out = instruction;


// Instruction Memory
instruction_memory imem(
    .address(pc),
    .instruction(instruction)
);


// Control Unit
control_unit control(
    .opcode(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),

    .reg_write(reg_write),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .branch(branch),
    .mem_to_reg(mem_to_reg),

    .imm_src(imm_src),
    .alu_control(alu_control)
);


// Register File
register_file rf(
    .clk(clk),
    .reset(reset),
    .reg_write(reg_write),

    .read_reg1(instruction[19:15]),
    .read_reg2(instruction[24:20]),
    .write_reg(instruction[11:7]),

    .write_data(write_back_data),

    .read_data1(read_data1),
    .read_data2(read_data2)
);


// Immediate Generator
imm_gen imm(
    .instruction(instruction),
    .imm_src(imm_src),
    .immediate(immediate)
);


// Select ALU input
assign alu_input_b = alu_src ? immediate : read_data2;


// ALU
alu alu_unit(
    .a(read_data1),
    .b(alu_input_b),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
);


// Data Memory
data_memory dmem(
    .clk(clk),
    .mem_write(mem_write),

    .address(alu_result),
    .write_data(read_data2),

    .read_data(memory_data)
);


// Select data to write into registers
assign write_back_data = mem_to_reg ? memory_data : alu_result;


// Update Program Counter
always @(posedge clk or posedge reset) begin

    if (reset)
        pc <= 0;

    else if (branch && zero)
        pc <= pc + immediate;

    else
        pc <= pc + 4;

end

endmodule