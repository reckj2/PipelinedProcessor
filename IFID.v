`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 11:10:33 AM
// Design Name: 
// Module Name: IFID
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IFID(Reset, AdderIn, AdderOut, Clk, InstrIn, InstrOut, Flush, Stall);
    
    input Reset, Flush, Stall;
    input Clk;
    input [31:0] AdderIn;
    input [31:0] InstrIn;
    output reg [31:0] AdderOut;
    output reg [31:0] InstrOut;
    
    always @ (posedge Clk) begin
     if(((Reset == 1) || (Flush)) //|| (!Stall)
     ) begin
            AdderOut <= 0;
            InstrOut <= 0;
    end
    else begin
        AdderOut <= AdderIn;
        InstrOut <= InstrIn;
     end   
    
    end
endmodule
