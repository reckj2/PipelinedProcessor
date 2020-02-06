`timescale 1ns / 1ps

module HiLo(Lo, Hi, Clk, outHi, outLo, DontWrite);
    input [31:0] Lo;
    input [31:0] Hi;
    input Clk, DontWrite;
    output reg [31:0] outLo;
    output reg [31:0] outHi;
   
   
    always @(posedge Clk) begin
        if(!DontWrite) begin
            outLo <= Lo;
            outHi <= Hi;
        end
    end
   
endmodule
