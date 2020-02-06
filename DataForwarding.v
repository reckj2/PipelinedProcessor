`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 02:06:40 PM
// Design Name: 
// Module Name: DataForwarding
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


module DataForwarding(OpCode, A, B, MemWBrd, MemWBRegWrite, 
EXMemrd, EXMemRegWrite, IDEXrt, IDEXrs, IFIDrt, IFIDrs, rsMux, rtMux, swMux);

input [4:0] MemWBrd;
input [4:0] EXMemrd;
input [4:0] IDEXrt;
input [4:0] IDEXrs;
input [4:0] IFIDrt;
input [4:0] IFIDrs;
input [5:0] OpCode;
input MemWBRegWrite;
input EXMemRegWrite;

output reg [1:0] A;
output reg [1:0] B;
output reg rsMux;
output reg rtMux;
output reg swMux;

always @(*) begin

swMux = 1'b0;
rsMux = 1'b0;
rtMux = 1'b0;
A = 2'b00;
B = 2'b00;


if((EXMemRegWrite) && (EXMemrd != 5'b00000) && (EXMemrd == IDEXrt)) begin
    B = 2'b01;
end
if((EXMemRegWrite) && (EXMemrd != 5'b00000) && (EXMemrd == IDEXrs)) begin
    A = 2'b01;
end

if((MemWBrd == IDEXrs) && (EXMemRegWrite)&& (IDEXrs != 5'b00000)) begin
     A = 2'b01;
end
if((MemWBrd == IDEXrt) && (EXMemRegWrite)&& (IDEXrt != 5'b00000)) begin
     B = 2'b01;
end

if((EXMemrd == IDEXrs) && (EXMemRegWrite) && (EXMemrd != 5'b00000) && (IDEXrs != 5'b00000)) begin
     A = 2'b10;
end
if((EXMemrd == IDEXrt) && (EXMemRegWrite) && (EXMemrd != 5'b00000) && (IDEXrt != 5'b00000)) begin
     B = 2'b10;
end

if((MemWBRegWrite) && !(EXMemRegWrite) && (MemWBrd != 5'b00000) && !(EXMemrd != 5'b00000)) begin
    if((EXMemrd == IDEXrt) && (MemWBrd == IDEXrt)) begin
        B = 2'b10;
    end
    if((EXMemrd == IDEXrs) && (MemWBrd == IDEXrs)) begin
        A = 2'b10;
    end
end

if((MemWBrd == IFIDrs) && (IFIDrs != 5'b00000))begin
    rsMux = 1'b1;
end

if((MemWBrd == IFIDrt) && (IFIDrt != 5'b00000)) begin
    rtMux = 1'b1;
end


if(OpCode == 6'b001000)begin
    A = 2'b00;
    B = 2'b00;
end

if(OpCode == 6'b101011)begin
    B = 2'b00;
end

if((OpCode == 6'b101011) && (IDEXrt == MemWBrd))begin
    B = 2'b00;
    swMux = 1'b1;
end

if((OpCode == 6'b101011) && (IDEXrt == EXMemrd))begin
    B = 2'b00;
    swMux = 1'b1;
end




//if((EXMemRegWrite) && (EXMemrd != 5'b00000) && (EXMemrd == IDEXrs) && (MemWBrd != IDEXrs))begin
//    A = 2'b10;
//end
//if((EXMemRegWrite) && (EXMemrd != 5'b00000) && (EXMemrd == IDEXrt) && (MemWBrd != IDEXrt))begin
//    B = 2'b10;
//end


//if((MemWBRegWrite) && (MemWBrd != 6'b000000) && (EXMemrd != IFIDrs) && (MemWBrd == IFIDrs)&& (MemWBrd != IDEXrs))begin
//    rsMux = 1;
//end
//if((MemWBRegWrite) && (MemWBrd != 6'b000000) && (EXMemrd != IFIDrt) && (MemWBrd == IFIDrt) && (MemWBrd != IDEXrt))begin
//    rsMux = 1;
//end




end

endmodule
