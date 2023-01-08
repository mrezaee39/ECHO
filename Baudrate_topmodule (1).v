`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:11 06/14/2022 
// Design Name: 
// Module Name:    Baudrate_topmodule 
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
module Baudrate_topmodule(
    input wire clk,
	 input wire reset_n,
    output wire rx_clk,
    output wire tx_clk
    );
	 


Dezimierer dez(
  .clk(clk),
  .reset_n(reset_n),
  .rx_clk(rx_clk) 
    );
	 

	 
OSR_Dezimierer OSR_dez(
    .clk(rx_clk),
    .reset_n(reset_n),
    .tx_clk(tx_clk) 
    ); 
	 
	 
endmodule
