`timescale 1ns / 1ps

module EXMEM(Reset, AdderOutID, JumpIDEX, InstructionOutIDEX, regWriteIn, regWriteOut,
Clk, PCSrcIn, MemToRegIn, BranchIn, 
MemWriteIn, MemReadIn, AddResultIn, ZeroIn, 
ALUResultIn, ReadD2In, InstrMuxIn, PCSrcOut, 
MemToRegOut, BranchOut, MemWriteOut, MemReadOut, 
AddResultOut, ZeroOut, ALUResultOut, ReadD2Out, 
InstrMuxOut, InstructionOutEXMEM, JumpEXMEM, AdderOutEXMEM,
Load, LoadOut, Store, StoreOut, Flush);

    input [1:0] Load, Store;
    input AdderOutID;
    input JumpIDEX;
    input InstructionOutIDEX;
    input Reset;
    input regWriteIn;
    input Clk;
    input PCSrcIn;
    input MemToRegIn;
    input BranchIn;
    input MemWriteIn;
    input MemReadIn;
    input [31:0] AddResultIn;
    input ZeroIn;
    input [31:0] ALUResultIn;
    input [31:0] ReadD2In;
    input [4:0] InstrMuxIn;
    input Flush;
    
    output reg [1:0] LoadOut, StoreOut;
    output reg [31:0] AdderOutEXMEM;
    output reg JumpEXMEM;
    output reg [31:0] InstructionOutEXMEM;
    output reg regWriteOut;
    output reg PCSrcOut;
    output reg MemToRegOut;
    output reg BranchOut;
    output reg MemWriteOut;
    output reg MemReadOut;
    output reg [31:0] AddResultOut;
    output reg ZeroOut;
    output reg [31:0] ALUResultOut;
    output reg [31:0] ReadD2Out;
    output reg [4:0] InstrMuxOut;
    

    
    always @ (posedge Clk) begin
        if(Reset == 1 || Flush) begin
            StoreOut <= 0;
            LoadOut <= 0;
            AdderOutEXMEM <= 0;
            JumpEXMEM <= 0;
            InstructionOutEXMEM <= 0;
            regWriteOut <= 0;
            MemToRegOut <= 0;
            PCSrcOut <= 0;
            BranchOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            AddResultOut <= 0;
            ZeroOut <= 0;
            ALUResultOut <= 0;
            ReadD2Out <= 0;
            InstrMuxOut <= 0;
                
        end
        
        else begin
            StoreOut <= Store;
            LoadOut <= Load;
            AdderOutEXMEM <= AdderOutID;
            InstructionOutEXMEM <= InstructionOutIDEX;
            JumpEXMEM <= JumpIDEX;
            regWriteOut <= regWriteIn;
            MemToRegOut <= MemToRegIn;
            PCSrcOut <= PCSrcIn;
            BranchOut <= BranchIn;
            MemWriteOut <= MemWriteIn;
            MemReadOut <= MemReadIn;
            AddResultOut <= AddResultIn;
            ZeroOut <= ZeroIn;
            ALUResultOut <= ALUResultIn;
            ReadD2Out <= ReadD2In;
            InstrMuxOut <= InstrMuxIn;        
        end
    end
    
endmodule
