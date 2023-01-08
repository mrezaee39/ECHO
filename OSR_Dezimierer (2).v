`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:11 06/14/2022 
// Design Name: 
// Module Name:    OSR_Dezimierer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module OSR_Dezimierer(
    input  wire clk,
    input wire reset_n,
    output reg tx_clk
    );

reg[9:0] counter;
parameter n=10'd7;//damit die OSR 16 ist : 0-7 = 8 times
reg state;
always @(posedge clk or negedge reset_n)
	begin
if(!reset_n)
	begin
		tx_clk<=1'd0;
	   counter<=10'd0;
	  end 
else begin
									if (counter==n)begin
										tx_clk <= ~tx_clk;
										counter <= 10'd0;
									end
								   else begin
										counter <= counter+1'd1;
									end		
							end
					
end
endmodule	