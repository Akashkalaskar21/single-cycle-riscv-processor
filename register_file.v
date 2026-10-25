module register_file(
    input clk,
    input reset,
    input reg_write,

    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,

    input [31:0] write_data,

    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

reg [31:0] registers [0:31];

integer i;

// Write data into registers
always @(posedge clk or posedge reset) begin

    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 0;
    end

    else if (reg_write && write_reg != 0) begin
        registers[write_reg] <= write_data;
    end

end

// Read data from registers
always @(*) begin

    if (read_reg1 == 0)
        read_data1 = 0;
    else
        read_data1 = registers[read_reg1];

    if (read_reg2 == 0)
        read_data2 = 0;
    else
        read_data2 = registers[read_reg2];

end

endmodule