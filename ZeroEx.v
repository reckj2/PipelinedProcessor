`timescale 1ns / 1ps

module ZeroEx(in, out);

    input [4:0] in;
    output reg [31:0] out;
    
    always @(in) begin
        out[31:5] = 27'b0;
        out[4:0] = in;
    end
endmodule
