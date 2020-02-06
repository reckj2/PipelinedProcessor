`timescale 1ns / 1ps

module Controller(in, RegDst, RegWrite, ALUSrc, MemRead, MemWrite,
 MemToReg, PCSrc, Sh1, Sh2, ALUOp, Jump, Load, Store, JumpLink, JR);

    
    input [31:0] in;
    wire [5:0] Op = in[31:26];
    wire [5:0] Funct = in[5:0];
    wire R = in[6];
    output reg [1:0] Store;
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, PCSrc, Sh1, Sh2, Jump, JumpLink, JR;
    output reg [5:0] ALUOp;
    output reg [1:0] Load;
    
    always @(in) begin
        Jump <= 0;
        JumpLink <= 0;
        JR <= 0;
        Load <= 2'b11;
        Store <= 2'b11;
        if ((Op == 6'b000000) && (Funct == 6'b100000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b000000; MemRead <= 0;  //Add (signed implicit)
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001000) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b000000; MemRead <= 0; //Addi (signed implicit)
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100001)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b000001; MemRead <= 0; //add unsigned word
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b001001)) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b000001; MemRead <= 0; //addi unsigned word
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b000010; MemRead <= 0; //sub
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b011100) && (Funct == 6'b000010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b000011; MemRead <= 0; //Multiply
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b011000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b000100; MemRead <= 0; //Multiply Word
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b011001)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b000101; MemRead <= 0; //Multiply unsigned word
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b011100) && (Funct == 6'b000000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b000110; MemRead <= 0; //Multiply and add word to hi/lo (MADD)
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b011100) && (Funct == 6'b000100)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b000111; MemRead <= 0; //Multiply and sub word to hi/lo (MSUB)
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100100)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001000; MemRead <= 0; //AND
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001100) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b001000; MemRead <= 0; //ANDI
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 1;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100101)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001001; MemRead <= 0; //Or  
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001101) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b001001; MemRead <= 0; //Ori
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100111)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001010; MemRead <= 0; //Nor
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b100110)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001011; MemRead <= 0; //Xor
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001110) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b001011; MemRead <= 0; //Xori
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b011111) && (Funct == 6'b100000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001100; MemRead <= 0; //Seh
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 1; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001101; MemRead <= 0; //Sll
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 1; Sh2 <= 1;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001110; MemRead <= 0; //Srl
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 1; Sh2 <= 1;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000100)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b011010; MemRead <= 0; //Sllv
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000110) && (R == 0)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b011011; MemRead <= 0; //Srlv
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b101010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b001111; MemRead <= 0; //Slt
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001010) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b001111; MemRead <= 0; //Slti
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b01011)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010000; MemRead <= 0; //Movn
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b001010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010001; MemRead <= 0; //Movz
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000110) && (R == 1)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010010; MemRead <= 0; //Rotrv
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010010; MemRead <= 0; //Rotr
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000011)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010011; MemRead <= 0; //Sra
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 1; Sh2 <= 1;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b000111)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b011100; MemRead <= 0; //Srav
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b011111) && (Funct == 6'b100000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010100; MemRead <= 0; //Seb
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b001011) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b010101; MemRead <= 0; //Sltiu
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b101011)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b010101; MemRead <= 0; //Sltu
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b010001)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b010110; MemRead <= 0; //Mthi
            MemWrite <= 0; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b010011)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 0; ALUOp <= 6'b010111; MemRead <= 0; //Mtlo
            MemWrite <= 0; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b010000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b011000; MemRead <= 0; //Mfhi
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b010010)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b011001; MemRead <= 0; //Mflo
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0;
        end
        
        /////Start of Data and Branch Shmit////////
        else if (Op == 6'b100011) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b0; MemRead <= 1; //lw
            MemWrite <= 0; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Load <= 2'b00;
        end
        else if (Op == 6'b101011) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 0; ALUOp <= 6'b000000; MemRead <= 0; //sw
            MemWrite <= 1; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Store <= 2'b00;
        end
        else if (Op == 6'b101000) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 0; ALUOp <= 6'b0; MemRead <= 0; //sb
            MemWrite <= 1; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Store <= 2'b10;
        end
        else if (Op == 6'b100001) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b0; MemRead <= 1; //lh
            MemWrite <= 0; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Load <= 2'b01;
        end
        else if (Op == 6'b100000) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b0; MemRead <= 1; //lb
            MemWrite <= 0; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Load <= 2'b10;
        end
        else if (Op == 6'b101001) begin
            ALUSrc <= 1; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b0; MemRead <= 0; //sh
            MemWrite <= 1; MemToReg <= 0; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Store <= 2'b01;
        end
        else if (Op == 6'b001111) begin
            ALUSrc <= 1; RegDst <= 0; RegWrite <= 1; ALUOp <= 6'b100010; MemRead <= 0; //lui
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 1; Sh2 <= 0;
        end
        else if (Op == 6'b000001) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b100011; MemRead <= 0; //bgez
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000100) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b100100; MemRead <= 0; //beq
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000101) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b100101; MemRead <= 0; //bne
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000111) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b100110; MemRead <= 0; //bgtz
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000110) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b100111; MemRead <= 0; //blez
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000001) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b101000; MemRead <= 0; //bltz
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 1; Sh1 <= 0; Sh2 <= 0;
        end
        else if (Op == 6'b000010) begin
            ALUSrc <= 0; RegDst <= 0; RegWrite <= 0; ALUOp <= 6'b101001; MemRead <= 0; //j
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Jump <= 1;
        end
        else if ((Op == 6'b000000) && (Funct == 6'b001000)) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b101010; MemRead <= 0; //jr
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; JR <= 1;
        end
        else if (Op == 6'b000011) begin
            ALUSrc <= 0; RegDst <= 1; RegWrite <= 1; ALUOp <= 6'b101011; MemRead <= 0; //jal
            MemWrite <= 0; MemToReg <= 1; PCSrc <= 0; Sh1 <= 0; Sh2 <= 0; Jump <= 1; JumpLink <= 1;
        end
       
        
        
        
end
endmodule