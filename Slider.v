`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Shawn Horvatic
// 
// Create Date:    10/9/2016
// Design Name: 	 Led Slider
// Module Name:    Slider 
// Project Name: 	 Led Slider
// Target Devices: Mimas V2 Spartan 6 FPGA Development Board with DDR SDRAM
//
// Description: To have each LED light up, one after another. Once it hits LED D1 moves to the right.
//              When It hits LED D8 moves to the left.
//
// Dependencies: 
//
// Revision: 
// Revision 0.02 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Slider(input Clk, output reg [7:0]LED);

// Register used internally	
reg [23:0] moveLEDCnt;
reg enable;
reg currentDirection;
reg currentDirection_Next;
reg reset; 
  
always @(posedge Clk) 
	begin
		moveLEDCnt <= moveLEDCnt+1'b1;
		enable <= moveLEDCnt[23];
		currentDirection <= currentDirection_Next;
	end  

always @*
	begin
		if(LED[7] == 1'b1) 
			currentDirection_Next = 0;
		else if(LED[0] == 1'b1)
			currentDirection_Next = 1;
		else if( currentDirection == 0 )
			currentDirection_Next = 0;
		else
			currentDirection_Next = 1;
		if(LED == 8'b0000_0000)
			reset = 1;
		else
			reset = 0;
			
			
	end
	
always @(posedge enable)
   begin
		if(reset) begin
			LED = 8'b1000_0000;
		end
		else begin
			LED = !currentDirection ? 
					{LED[0],LED[7:1]} :
					{LED[6:0],LED[7]};
		end
   end
endmodule

