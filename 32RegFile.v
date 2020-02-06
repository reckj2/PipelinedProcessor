`timescale 1ns / 1ps

  module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, 
  RegWrite, Clk, ReadData1,ReadData2);

input[4:0] ReadRegister1, ReadRegister2, WriteRegister; //readreg2 == R_en
input[31:0] WriteData;
input Clk;
input RegWrite;
output reg[31:0] ReadData1;
output reg[31:0] ReadData2;
(* mark_debug = "true" *) reg [31:0] RegFile [0:31];

integer i;
        
        initial begin
        RegFile [0] <= 32'd0;
        RegFile [1] <= 32'd0;
        RegFile [2] <= 32'd0;
        RegFile [3] <= 32'd0;
        RegFile [4] <= 32'd0;
        RegFile [5] <= 32'd0;
        RegFile [6] <= 32'd0;
        RegFile [7] <= 32'd0;
        RegFile [8] <= 32'd0;
        RegFile [9] <= 32'd0;
        RegFile [10] <= 32'd0;
        RegFile [11] <= 32'd0;
        RegFile [12] <= 32'd0;
        RegFile [13] <= 32'd0;
        RegFile [14] <= 32'd0;
        RegFile [15] <= 32'd0;
        RegFile [16] <= 32'd0;
        RegFile [17] <= 32'd0;
        RegFile [18] <= 32'd0;
        RegFile [19] <= 32'd0;
        RegFile [20] <= 32'd0;
        RegFile [21] <= 32'd0;
        RegFile [22] <= 32'd0;
        RegFile [23] <= 32'd0;
        RegFile [24] <= 32'd0;
        RegFile [25] <= 32'd0;
        RegFile [26] <= 32'd0;
        RegFile [27] <= 32'd0;
        RegFile [28] <= 32'd0;
        RegFile [29] <= 32'd0;
        RegFile [30] <= 32'd0;
         RegFile [31] <= 32'd0;
             end

     always @(negedge Clk) begin
        ReadData1 <=  RegFile[ReadRegister1];
        ReadData2 <=  RegFile[ReadRegister2];
        i <= RegWrite;
        end
        
        
    always @(posedge Clk) begin
        if(i == 1)begin
        RegFile[WriteRegister] <= WriteData;
        end
        RegFile [0] <= 32'd0;
        end
endmodule
