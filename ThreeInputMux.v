`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2019 02:34:15 PM
// Design Name: 
// Module Name: 3InputMux
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


module ThreeInputMux(Output, A, B, C, Control);
    
    input [31:0] A;
    input [31:0] B;
    input [31:0] C;
    input [1:0] Control;
    
    output reg [31:0] Output;
    
    always @(*) begin
    if(Control == 2'b00) begin
        Output = A;
    end
    else if(Control == 2'b01) begin
        Output = B;
    end
    else if(Control == 2'b10) begin
        Output = C;
    end
    
    
    
    end
    

endmodule
