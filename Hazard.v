`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 12:12:40 PM
// Design Name: 
// Module Name: Hazard
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


module Hazard(Instruction, InstructionIFID, rs, rt, IDEXrt, IDEXMemRead, ControlMux, IFIDWrite, PCWrite, Branch, Flush);

input [4:0] rs, rt, IDEXrt;
input [31:0] Instruction, InstructionIFID;
input IDEXMemRead, Branch;
output reg ControlMux, IFIDWrite, PCWrite, Flush;

always @(*) begin

Flush = 0;
ControlMux = 1;
IFIDWrite = 1;
PCWrite = 1;

    if(((rs == IDEXrt) || (rt == IDEXrt)) && (IDEXMemRead)) begin
        ControlMux = 0;
        //IFIDWrite = 0;
        PCWrite = 0;
    end
    
    if((Instruction[5:0] == 6'b001000) && 
    ((Instruction[25:21] == InstructionIFID[20:16]) || (Instruction[25:21] == InstructionIFID[15:11])))begin
        IFIDWrite = 0;
        //PCWrite = 0;
    end

if(Branch) begin
    Flush = 1;
end


end

endmodule
