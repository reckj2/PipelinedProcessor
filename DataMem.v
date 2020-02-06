`timescale 1ns / 1ps



module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, Load, Store); 

    input [1:0] Store;
    input [1:0] Load;
    input [31:0] Address; 	
    input [31:0] WriteData;  
    input Clk;
    input MemWrite; 		
    input MemRead; 			
    integer i;
    
    output reg[31:0] ReadData;
       reg [31:0] memory [0:255];
    
	initial begin
	memory[0] <= 32'd0;
    memory[1] <= 32'd1;
    memory[2] <= 32'd2;
    memory[3] <= 32'd3;
    memory[4] <= 32'd4;
    memory[5] <= -32'd1;

	end
	
	always @(posedge Clk) begin
        if (MemWrite == 1'b1) begin
            //Store word
            if (Store == 2'b00) begin
                memory[Address[11:2]] <= WriteData;
            end
            //Store halfword
            else if (Store == 2'b01) begin
                if (Address[1] == 1'b0) begin
                    memory[Address[11:2]][15:0] <= WriteData[15:0];
                end
                else begin
                    memory[Address[11:2]][31:16] <= WriteData[31:16];
                end
            end
            //Store byte
            else if (Store == 2'b10) begin
                if (Address[1:0] == 2'b0) begin
                    memory[Address[11:2]][7:0] <= WriteData[7:0];
                end
                else if (Address[1:0] == 2'b01) begin
                    memory[Address[11:2]][15:8] <= WriteData[15:8];
                end
                else if (Address[1:0] == 2'b10) begin
                    memory[Address[11:2]][23:16] <= WriteData[23:16];
                end
                else if (Address[1:0] == 2'b11) begin
                    memory[Address[11:2]][31:24] <= WriteData[31:24];
                end
            end
        end
    end    
    
    always @(*) begin
        if (MemRead == 1'b1) begin
            //Load word
            if (Load == 2'b00) begin
                ReadData <= memory[Address[11:2]];
            end
            //Load halfword
            else if (Load == 2'b01) begin
                if (1 == 1) begin
                    ReadData <= memory[Address[11:2]][15:0];
                    ReadData <= memory[Address[11:2]][31:16];
                end
                else begin
                    memory[Address[11:2]] <= WriteData;
                end
            end
            //Load byte
            else if (Load == 2'b00) begin
                if (Address[1:0] == 2'b0) begin
                    if(memory[Address[11:2]][7] == 1) begin
                        ReadData[31:8] <= 24'hFFFFFF;
                        ReadData[7:0] <= memory[Address[11:2]][7:0];
                    end
                    else begin
                        ReadData[31:8] <= 24'h000000;
                        ReadData[7:0] <= memory[Address[11:2]][7:0];
                    end                   
                end
                if (Address[1:0] == 2'b01) begin
                    if(memory[Address[11:2]][15] == 1) begin
                        ReadData[31:16] <= 24'hFFFFFF;
                        ReadData[7:0] <= memory[Address[11:2]][15:8];
                    end
                    else begin
                        ReadData[31:8] <= 24'h0;
                        ReadData[7:0] <= memory[Address[11:2]][15:8];
                    end                   
                end
                if (Address[1:0] == 2'b10) begin
                    if(memory[Address[11:2]][23] == 1) begin
                        ReadData[31:8] <= 24'hFFFFFF;
                        ReadData[7:0] <= memory[Address[11:2]][23:16];
                    end
                    else begin
                        ReadData[31:8] <= 24'h0;
                        ReadData[7:0] <= memory[Address[11:2]][23:16];
                    end                   
                end
                if (Address[1:0] == 2'b11) begin
                    if(memory[Address[11:2]][31] == 1) begin
                        ReadData[31:8] <= 24'hFFFFFF;
                        ReadData[7:0] <= memory[Address[11:2]][31:24];
                    end
                    else begin
                        ReadData[31:8] <= 24'h0;
                        ReadData[7:0] <= memory[Address[11:2]][31:24];
                    end                 
                end                
            end
        end
        else begin
                ReadData <= 32'h0;    
        end        
    end    
endmodule
