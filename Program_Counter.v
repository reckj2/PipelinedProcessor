`timescale 1ns / 1ps

module ProgramCounter(Address, PCResult, Reset, Clk, write);

	input [31:0] Address;
	input Reset, Clk, write;
	//output [31:0] debug_reg;
    //(* mark_debug = "true" *) wire [31:0] debug_reg;
	output reg [31:0] PCResult;
	
    always @(posedge Clk) begin
        if (Reset == 1) begin
            PCResult <= 0;
        end
    else begin
        if(write) begin
            PCResult <= Address;
        end
    end
    //assign debug_reg = Address;
    end

endmodule
