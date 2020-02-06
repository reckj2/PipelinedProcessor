`timescale 1ns / 1ps

module Instruction_Memory(Address, Instruction);
input [31:0] Address;
output reg [31:0] Instruction;

reg [31:0] memory [0:500];

initial begin
$readmemh ("Instruction_memory.txt", memory);
end

always @ * begin
    Instruction <= memory[Address[31:2]];
end

endmodule
