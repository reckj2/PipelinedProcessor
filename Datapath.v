`timescale 1ns / 1ps

//Ryan Hammond 50% Josh Reck 50%
//Branch is in Memory Stage

module Datapath(Clk, Reset);
    input Clk;
    input Reset;

//    (* mark_debug = "true" *) wire [31:0] debug_reg;

    wire [31:0] PCmux;
    (* mark_debug = "true" *) wire [31:0] PCOut;
    wire [31:0] Instruction;
    wire [31:0] AdderResult;
    wire [31:0] AdderIFID;
    wire [31:0] InstructionOut;
    wire [4:0] MuxOutMB;
    (* mark_debug = "true" *) wire [31:0] MuxMemToReg;
    wire RegWriteWB;
    wire [31:0] ReadD1Result;
    wire [31:0] ReadD2Result;
    wire [31:0] SignExOut;
    wire RegDstOut;
    wire RegWriteOut;
    wire ALUSrcOut;
    wire MemReadOut;
    wire MemWriteOut;
    wire MemToRegOut;
    wire PCSrcOut;
    wire Sh1Out;
    wire Sh2Out;
    wire Sh1OutIDEX;
    wire [5:0] ALUOpOut;
    
    wire[31:0] ReadMuxOut;
    
    wire Jump, JumpIDEX, JumpEXMEM, JumpLink;
    wire RegDstOutID;
    wire RegWriteOutID;
    wire ALUSrcOutID;
    wire MemReadOutID;
    wire MemWriteOutID;
    wire MemToRegOutID;
    wire PCSrcOutID;
    wire Sh1OutID;
    wire Sh2OutID;
    wire [5:0] ALUOpOutID;
    wire [31:0] AdderOutID;
    wire [31:0] ReadD1ResultID;
    wire [31:0] ReadD2ResultID;
    wire [31:0] SignExOutID;
    wire [4:0] InstOutID;
    wire [4:0] InstOut2ID;
    
    wire[1:0] Load, LoadIDEX, LoadEXMEM, Store, StoreIDEX, StoreEXMEM;
    wire sh2outID;
    
    wire [31:0] ALUMux;
    wire [4:0] RegDSTMux;
    wire [31:0] AddResult, zeroExOut, jalWrDOut;
    
    (* mark_debug = "true" *) wire [31:0] HiOut, LoOut;
    wire [31:0] HiOutALU, LoOutALU;
    wire [31:0] ALUResult;
    wire zeroALU;
    wire [31:0] zeroMuxOut;
    
    wire [31:0] JROut, AddressJR;
    wire JR;
    
    wire PCSrcOutEX, MemToRegOutEX, BranchOutEX, MemWriteOutEX,
    MemReadOutEX, ZeroOutEX, regWriteOutEX;
    wire[4:0] InstrMuxOutEX, jalWrROut;
    wire [31:0] AddResultOutEX;
     
    wire [31:0] ALUResultOutEX, zeroExEX, ReadD2OutEX;
    
    wire [31:0] ReadData;
    
    wire RegWriteOutWB, MemToRegOutWB;
    wire [31:0] ALUResultOutWB, ReadOutWB;
    wire [4:0] InstrMuxOutWB;
    wire [31:0] InstructionOutIDEX;
    wire [31:0] InstructionOutEXMEM;
    wire [31:0] MuxJumpOut;
    wire [31:0] AdderOutEXMEM;
    
    ///DataForwarding Wires///
    wire [1:0] A, B;
    wire [4:0] rsAddressIDEX;
    wire rsMux, rtMux;
    wire swMux;
    wire [31:0] AMuxOut, BMuxOut, rsMuxOut, rtMuxOut, swMuxOut;
    //////////////////////////
    
    ///Hazard Wires///
    wire ControlMux, IFIDWrite, PCWrite;
    wire regWriteMuxOut, Flush;
    //////////////////

///////////////////////////////////////////////////////////////////////////////        
    
    ProgramCounter pc1(JROut, PCOut, Reset, Clk, PCWrite);
    
    Instruction_Memory im1(PCOut, Instruction);
    
    Adder a1(PCOut, 32'd4, AdderResult);
    
    IFID r1(Reset, AdderResult, AdderIFID, Clk,Instruction, InstructionOut, (Jump || Flush), IFIDWrite);
    
///////////////////////////////////////////////////////////////////////////////        

    Mux jalWrR(jalWrROut, InstrMuxOutWB , 5'b11111, JumpLink);
    
    Mux jalWrD(jalWrDOut, MuxMemToReg, AdderIFID, JumpLink);

    RegisterFile rf1(InstructionOut[25:21], InstructionOut[20:16],
        jalWrROut, jalWrDOut, RegWriteOutWB, Clk, ReadD1Result, ReadD2Result);
    
    //Hazard(rs, rt, IDEXrt, IDEXMemRead, 
    //ControlMux, IFIDWrite, PCWrite);
    
    Hazard haz1(Instruction, InstructionOut,  InstructionOut[25:21], InstructionOut[20:16], InstOutID, MemReadOutID,
    ControlMux, IFIDWrite, PCWrite, (BranchOutEX && ZeroOutEX), Flush);
        
    SignExtension se1(InstructionOut[15:0], SignExOut);
    
    Controller c1(InstructionOut, RegDstOut, RegWriteOut, ALUSrcOut, 
        MemReadOut, MemWriteOut, MemToRegOut, PCSrcOut, Sh1Out, Sh2Out, ALUOpOut, Jump,
         Load, Store, JumpLink, JR);
        
     Mux ctrlr1(regWriteMuxOut, 1'b0, RegWriteOut, ControlMux);   
        
     ZeroEx ze1(InstructionOut[10:6], zeroExOut);
     
     Mux rs1(rsMuxOut, ReadD1Result, MuxMemToReg, rsMux);
     
     Mux rt1(rtMuxOut, ReadD2Result, MuxMemToReg, rtMux);
        
    IDEX r2(Reset, Jump, InstructionOut, Sh1Out, regWriteMuxOut, RegWriteOutID,
        Sh2Out, sh2outID,
        zeroExOut, zeroExEX, Clk, 
        PCSrcOut, MemToRegOut, PCSrcOut, MemWriteOut, MemReadOut,
        ALUSrcOut, RegDstOut, ALUOpOut, AdderIFID,
        rsMuxOut,  rtMuxOut, SignExOut, InstructionOut[20:16], InstructionOut[15:11], InstructionOut[25:21],
        Sh1OutIDEX, PCSrcOutID, MemToRegOutID, PCSrcOutID, MemWriteOutID, MemReadOutID,
        ALUSrcOutID, RegDstOutID, ALUOpOutID,  AdderOutID, 
        ReadD1ResultID, ReadD2ResultID, SignExOutID, InstOutID, InstOut2ID, rsAddressIDEX, InstructionOutIDEX, 
        JumpIDEX, Load, LoadIDEX, Store, StoreIDEX, Flush);
        
///////////////////////////////////////////////////////////////////////////////        
        
    Mux msh1(ReadMuxOut, ReadD1ResultID, ReadD2ResultID, Sh1OutIDEX);    
    
    Adder a2(AdderOutID, (SignExOutID << 2), AddResult); 
    
    Mux m1(ALUMux, ReadD2ResultID, SignExOutID, ALUSrcOutID);
    
    FiveBitMux m2(RegDSTMux, InstOutID, InstOut2ID, RegDstOutID);
    
    Mux m3(zeroMuxOut, ALUMux, zeroExEX, sh2outID); 
    
    HiLo hl1(LoOutALU, HiOutALU, Clk, HiOut, LoOut, (PCSrcOutID && zeroALU));
    
    ThreeInputMux am1(AMuxOut, ReadMuxOut, ALUResultOutEX, MuxMemToReg, A);
    
    ThreeInputMux bm1(BMuxOut, zeroMuxOut, ALUResultOutEX, MuxMemToReg, B);
    
    ALU32Bit alu1(ALUOpOutID, AMuxOut, BMuxOut, LoOut, 
    HiOut, LoOutALU, HiOutALU, ALUResult, zeroALU);
    
    /// Data Forwarding ///
    
    //module DataForwarding(A, B, MemWBrd, MemWBRegWrite, 
    //EXMemrd, EXMemRegWrite, IDEXrt, IDEXrs, IFIDrt, IFIDrs, 
    //rsMux, rtMux);
    
    DataForwarding DF1(InstructionOutIDEX[31:26], A, B, InstrMuxOutEX, RegWriteOutWB,
    InstrMuxOutWB, regWriteOutEX, InstOutID, rsAddressIDEX, InstructionOut[20:16], InstructionOut[25:21],
    rsMux, rtMux, swMux);
    
    ///////////////////////
    
//    module EXMEM(Reset, AdderOutID, JumpIDEX, InstructionOutIDEX, regWriteIn, regWriteOut,
//    Clk, PCSrcIn, MemToRegIn, BranchIn, 
//    MemWriteIn, MemReadIn, AddResultIn, ZeroIn, 
//    ALUResultIn, ReadD2In, InstrMuxIn, PCSrcOut, 
//    MemToRegOut, BranchOut, MemWriteOut, MemReadOut, 
//    AddResultOut, ZeroOut, ALUResultOut, ReadD2Out, 
//    InstrMuxOut, InstructionOutEXMEM, JumpEXMEM, AdderOutEXMEM,
//    Load, LoadOut, Store, StoreOut);

    Mux swMux12(swMuxOut, ReadD2ResultID, MuxMemToReg, swMux);
    
    EXMEM em1(Reset, AdderOutID, JumpIDEX, InstructionOutIDEX, RegWriteOutID, regWriteOutEX,
        Clk, PCSrcOutID, MemToRegOutID, PCSrcOutID,
        MemWriteOutID,  MemReadOutID, AddResult, zeroALU,
        ALUResult, swMuxOut, RegDSTMux, PCSrcOutEX, 
        MemToRegOutEX, BranchOutEX, MemWriteOutEX, MemReadOutEX, 
        AddResultOutEX, ZeroOutEX, ALUResultOutEX, ReadD2OutEX, 
        InstrMuxOutEX, InstructionOutEXMEM, JumpEXMEM, AdderOutEXMEM, LoadIDEX, LoadEXMEM, StoreIDEX, StoreEXMEM, Flush);
        
///////////////////////////////////////////////////////////////////////////////        
        
    DataMemory dm1(ALUResultOutEX, ReadD2OutEX, Clk, MemWriteOutEX, 
        MemReadOutEX, ReadData, LoadEXMEM, StoreEXMEM);
        
    // BEGINNING MUX //    
    Mux m4(PCmux, AdderResult, AddResultOutEX, (BranchOutEX && ZeroOutEX));
    
    Mux jumper(MuxJumpOut, PCmux, {AdderIFID[31:28], (InstructionOut[25:0] << 2)}, Jump);
    
    Mux jr(JROut , MuxJumpOut , ReadD1Result, JR);
    
    MEMWB mw1(Reset, Clk, regWriteOutEX, MemToRegOutEX,
      ALUResultOutEX, ReadData, InstrMuxOutEX,
       RegWriteOutWB, MemToRegOutWB, ALUResultOutWB, 
       ReadOutWB, InstrMuxOutWB); 
       
///////////////////////////////////////////////////////////////////////////////        
   
    Mux m5(MuxMemToReg, ReadOutWB, ALUResultOutWB, MemToRegOutWB);
    


endmodule
