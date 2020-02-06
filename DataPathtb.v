`timescale 1ns / 1ps

//Ryan Hammond 50% Josh Reck 50%

module DataPath_tb();

    reg Clk_tb, Rst_tb;
    
    Datapath a1(Clk_tb, Rst_tb);

    always begin
    Clk_tb <= 0;
    #100;
    Clk_tb <= 1;
    #100;
    end

    initial begin
    Rst_tb <= 1; 
    @(posedge Clk_tb);
    Rst_tb <= 1;
    @(posedge Clk_tb);
    Rst_tb <= 0;
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    @(posedge Clk_tb);
    end
    
endmodule
