`timescale 1ns / 1ps

module MEMWB(Reset, Clk, RegWriteIn, MemToRegIn, 
ALUResultIn, ReadIn, InstrMuxIn,
RegWriteOut, MemToRegOut, ALUResultOut, 
ReadOut, InstrMuxOut);

    input Reset;
    input Clk;
    input RegWriteIn, MemToRegIn;
    input [31:0] ALUResultIn;
    input [4:0] InstrMuxIn;
    input [31:0] ReadIn;
    
    output reg RegWriteOut, MemToRegOut;
    output reg [31:0] ALUResultOut;
    output reg [31:0] ReadOut;
    output reg [4:0] InstrMuxOut;
   

    
    always @ (posedge Clk) begin
         if(Reset == 1) begin
            RegWriteOut <= 0;
              MemToRegOut <= 0;
              ALUResultOut <= 0;
              InstrMuxOut <= 0;   
              ReadOut <= 0;  
              
          end
      else begin
        RegWriteOut <= RegWriteIn;
        MemToRegOut <= MemToRegIn;
        ALUResultOut <= ALUResultIn;
        InstrMuxOut <= InstrMuxIn;   
        ReadOut <= ReadIn;  
       end
        
    end
    
endmodule
