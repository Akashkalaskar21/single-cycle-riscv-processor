module data_memory(
    input clk,
    input mem_write,

    input [31:0] address,
    input [31:0] write_data,

    output [31:0] read_data
);

reg [31:0] memory [0:63];

integer i;

// Initially clear the memory
initial begin
    for (i = 0; i < 64; i = i + 1)
        memory[i] = 0;
end

// Write data to memory
always @(posedge clk) begin

    if (mem_write)
        memory[address[7:2]] <= write_data;

end

// Read data from memory
assign read_data = memory[address[7:2]];

endmodule