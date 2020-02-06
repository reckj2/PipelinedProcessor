`timescale 1ns / 1ps


module IDEX(Reset, Jump, InstructionOut, Sh1Out, regWriteIn, regWriteOut,
shin, shout,
zeroIn, zeroOut,
Clk, PCSrcIn, MemToRegIn, BranchIn, MemWriteIn, MemReadIn, 
ALUSRCIn, RegDstIn, ALUOpIn, AdderIn, 
ReadD1In, ReadD2In, SignExIn, Instr1In, Instr2In, rsAddressIn,
Sh1OutIDEX, PCSrcOut, MemToRegOut, BranchOut, MemWriteOut, MemReadOut, 
ALUSRCOut, RegDstOut, ALUOpOut, AdderOut, 
ReadD1Out, ReadD2Out, SignExOut, Instr1Out, Instr2Out, rsAddressOut, InstructionOutIDEX, JumpIDEX, Load, LoadOut,
Store, StoreOut, Flush);
    
    input [1:0] Load, Store;
    input Jump;
    input [31:0] InstructionOut;
    input Sh1Out;
    input Reset;
    input regWriteIn;
    input shin;
    input [31:0] zeroIn;
    input Clk;
    input PCSrcIn;
    input MemToRegIn;
    input BranchIn;
    input MemWriteIn;
    input MemReadIn;
    input ALUSRCIn;
    input RegDstIn;
    input [5:0] ALUOpIn;
    input [31:0] AdderIn;
    input [31:0] ReadD1In;
    input [31:0] ReadD2In;
    input [31:0] SignExIn;
    input [4:0] Instr1In;
    input [4:0] Instr2In;
    input [4:0] rsAddressIn;
    input Flush;
    
    output reg [1:0] LoadOut, StoreOut;
    output reg JumpIDEX;
    output reg Sh1OutIDEX;
    output reg regWriteOut;
    output reg shout;
    output reg [31:0] zeroOut;
    output reg PCSrcOut;
    output reg MemToRegOut;
    output reg BranchOut;
    output reg MemWriteOut;
    output reg MemReadOut;
    output reg ALUSRCOut;
    output reg RegDstOut;
    output reg [5:0] ALUOpOut;
    output reg [31:0] AdderOut;
    output reg [31:0] ReadD1Out;
    output reg [31:0] ReadD2Out;
    output reg [31:0] SignExOut;
    output reg [4:0] Instr1Out;
    output reg [4:0] Instr2Out;
    output reg [4:0] rsAddressOut;
    output reg [31:0] InstructionOutIDEX;
    
 
    always @ (posedge Clk) begin
    
        if(Reset == 1 || Flush) begin
            regWriteOut <= 0;
            
            StoreOut <= 0;
            LoadOut <= 0;
            JumpIDEX <= 0;
            shout <= 0;
            Sh1OutIDEX <= 0;
            zeroOut <= 0;
            
            MemToRegOut <= 0;
            PCSrcOut <= 0;
            BranchOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            
            ALUSRCOut <= 0;
            RegDstOut <= 0;
            ALUOpOut <= 0;
            AdderOut <= 0;
            ReadD1Out <= 0;
            ReadD2Out <= 0;
            SignExOut <= 0;
            Instr1Out <= 0;
            Instr2Out <= 0;
            InstructionOutIDEX <= 0;
            
            rsAddressOut = 0;
    
    end
    
    else begin
        regWriteOut <= regWriteIn;
        
        StoreOut <= Store;
        LoadOut <= Load;
        JumpIDEX <= Jump;
        shout <= shin;
        Sh1OutIDEX <= Sh1Out;
        zeroOut <= zeroIn;
        
        MemToRegOut <= MemToRegIn;
        PCSrcOut <= PCSrcIn;
        BranchOut <= BranchIn;
        MemWriteOut <= MemWriteIn;
        MemReadOut <= MemReadIn;
        
        ALUSRCOut <= ALUSRCIn;
        RegDstOut <= RegDstIn;
        ALUOpOut <= ALUOpIn;
        AdderOut <= AdderIn;
        ReadD1Out <= ReadD1In;
        ReadD2Out <= ReadD2In;
        SignExOut <= SignExIn;
        Instr1Out <= Instr1In;
        Instr2Out <= Instr2In;
        InstructionOutIDEX <= InstructionOut;
        
        rsAddressOut <= rsAddressIn;
    end    
    end
    
endmodule
