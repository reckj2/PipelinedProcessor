`timescale 1ns / 1ps

module Adder(A, B, Result);

    input [31:0] A;
    input [31:0] B;

    output reg [31:0] Result;

    always @(*) begin
        Result = A + B;
    end
    
endmodule
