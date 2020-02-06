`timescale 1ns / 1ps

module ALU32Bit(ALUControl, A, B, Lo, Hi, outLo, outHi, ALUResult, Zero);

input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
input [31:0] A, B;    // inputs

output reg [31:0] ALUResult; // answer
output reg Zero;    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */
    integer i;
   
    input [31:0] Lo;
    input [31:0] Hi;
    output reg [31:0] outLo;
    output reg [31:0] outHi;
    reg [63:0] total;
    reg temp;
    reg [31:0] tempA;

always @(*) begin

    if (ALUControl == 6'b000000) begin
        ALUResult = $signed(A) + $signed(B); //Add and addi, based off controller
    end
   
    else if (ALUControl == 6'b000001) begin
        ALUResult = A + B;  //Addi unsigned word and add unsigned word, based off controller
    end
   
    else if (ALUControl == 6'b000010) begin
        ALUResult = A - B;  //Sub
    end
   
    else if (ALUControl == 6'b000011) begin
        ALUResult = $signed(A) * $signed(B);  //Multiply
    end
   
    else if (ALUControl == 6'b000100) begin
        total = $signed(A) * $signed(B);    //Multiply word
        outLo = total[31:0];
        outHi = total[63:32];
    end
   
    else if (ALUControl == 6'b000101) begin
        total = A * B;    //Multiply unsigned word
        outLo = total[31:0];
        outHi = total[63:32];
    end
   
    else if (ALUControl == 6'b000110) begin
        //total = $signed(A) * $signed(B);    //Multiply and add Word to Hi, Lo
        //total = {Hi, Lo} + total;
        //outLo = total[31:0];
        //outHi = total[63:32];
       // {outHi,outLo} = {Hi,Lo} + (A * B);
       tempA = $signed(A) * $signed(B);
       tempA = {Hi, Lo} + $signed(tempA);
       {outHi, outLo} = tempA;
       ALUResult = 0;
    end
   
    else if (ALUControl == 6'b000111) begin
        //total = $signed(A) * $signed(B);    //Multiply and subtract Word to Hi, Lo
        //total = {Hi, Lo} - total;
        //outLo = total[31:0];
        //outHi = total[63:32];
        //{outHi,outLo} = {Hi,Lo} - (A * B);
        tempA = $signed(A) * $signed(B);
               tempA = {Hi, Lo} - $signed(tempA);
               {outHi, outLo} = tempA;
               ALUResult = 0;
    end

//***************************************************//
//***************************************************//
//****************START OF LOGICAL*******************//
//***************************************************//
//***************************************************//

    else if (ALUControl == 6'b001000) begin
        ALUResult = A & B;  //And and And Immediate
    end
   
    else if (ALUControl == 6'b001001) begin
        ALUResult = A | B;  //Or and Or Immediate
    end
   
    else if (ALUControl == 6'b001010) begin
        ALUResult = ~(A | B);  //Nor
    end
   
    else if (ALUControl == 6'b001011) begin
        ALUResult = (A & ~B) | (~A & B);  //Xor and Xor Immediate
    end
   
    else if (ALUControl == 6'b001100) begin
        ALUResult[31:16] = 16'b0;  //Seh
        ALUResult[15:0] = A[15:0];
    end
   
    else if (ALUControl == 6'b001101) begin
        ALUResult = (A << B); //Sll 
    end
    
   
    else if (ALUControl == 6'b001110) begin
        ALUResult = (A >> B);  //Srl
    end
   
    else if (ALUControl == 4'b001111) begin
        if($signed(A) < $signed(B)) begin
            ALUResult = 32'h000000001; //Slt and slti
        end
    end
   
    else if (ALUControl == 6'b010000) begin
        if (B != 0) begin
            ALUResult = A; //Movn
        end
    end
   
    else if (ALUControl == 6'b010001) begin
        if (B == 0) begin
            ALUResult = A; //Movz
        end
    end
   
    else if (ALUControl == 6'b010010) begin
            ALUResult = ((B>>A) | (B << (32 - A))); //rotr and rotrv
    end
   
    else if (ALUControl == 6'b010011) begin
            ALUResult = A >>> B; //sra  
    end
   
    else if (ALUControl == 6'b010100) begin
        tempA = B;
//        tempA[23:0] = 24'b0;   //Seb
//        ALUResult = tempA;
        if(B[7] == 1) begin
            tempA[31:8] = 24'hFFFFFF;
        end
        else begin
            tempA[31:8] = 24'h000000;
        end
        ALUResult = tempA;
    end
   
    else if (ALUControl == 6'b010101) begin
        if (A < B) begin
            ALUResult = 32'h00000001;   //Sltiu and sltu
        end
        else
            ALUResult = 32'h0;
    end
   
    else if (ALUControl == 6'b010110) begin
        outLo = Lo;
        ALUResult = 0;
        outHi = A; //Mthi
    end
   
    else if (ALUControl == 6'b010111) begin
        outHi = Hi;   
        ALUResult = 0;     
        outLo = A;  //Mtlo
    end
   
    else if (ALUControl == 6'b011000) begin
        ALUResult = Hi; //Mfhi
    end
   
    else if (ALUControl == 6'b011001) begin
        ALUResult = Lo; //Mflo
    end
    
     else if(ALUControl == 6'b011010) begin
        ALUResult = (B << A); // Sllv
    end
    
    else if (ALUControl == 6'b011011) begin
            ALUResult = (B >> A);  //Srlv
    end
    
     else if (ALUControl == 6'b011100) begin
         ALUResult = B >>> A;   //srav
    end

//*************************************************//
//*************************************************//
//*****************START OF DATA*******************//
//*************************************************//
//*************************************************//
    else if (ALUControl == 6'b100010) begin
            ALUResult = {B[15:0], 16'h0000};  //lui
    end
    else if (ALUControl == 6'b100011) begin
                if (A >= 0) begin  //bgez
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end
    end
    else if (ALUControl == 6'b100100) begin
                if (A == B) begin  //beq
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end  
    end
    else if (ALUControl == 6'b100101) begin
                if (A != B) begin  //bne
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end  
    end
    else if (ALUControl == 6'b100110) begin
                if (A > 0) begin  //bgtz
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end
    end
    else if (ALUControl == 6'b100111) begin
                if (A <= 0) begin  //blez
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end
    end
    else if (ALUControl == 6'b101000) begin
                if (A < 0) begin  //bltz
                    ALUResult = 0;
                end
                else begin
                    ALUResult = 1;
                end
    end
    else if (ALUControl == 6'b101001) begin
                ALUResult = 0;  //j
    end
    else if (ALUControl == 6'b101010) begin
                ALUResult = 0;  //jr
    end
    else if (ALUControl == 6'b101011) begin
                ALUResult = 0;  //jal
    end
    


    if (ALUResult == 0) begin
        Zero = 1;
    end
    else begin
        Zero = 0;
    end
end
endmodule