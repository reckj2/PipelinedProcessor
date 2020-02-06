`timescale 1ns / 1ps

module SignExtension(in, out);

    input [15:0] in;
    
    
    output reg [31:0] out;
    
    always @(in)
    if (in[15] == 0) begin
        out[15:0] <= in;
        out[31:16] <= 0;
    end
    else begin
        out[15:0] <= in;
        out[31:16] <= 16'hFFFF;
    end
    
endmodule
