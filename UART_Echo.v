`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:17 06/21/2022 
// Design Name: 
// Module Name:    UART_Echo 
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
module UART_Echo(
		input wire clk,
		input wire reset_n,
		input wire RXD,
		//input wire button,
		
		output wire TXD
		
    );

wire tx_clk;
wire rx_clk;

//wire rx_complete_del_flag;
wire [7:0] RX_DATA;
//wire rx_complete_flag;

wire A;//rx_complete_flag
wire B;
wire tx_busy;

Baudrate_topmodule BD_generator(
     .clk(clk),
	  .reset_n(reset_n),
     .rx_clk(rx_clk),
     .tx_clk(tx_clk)
    );
	
RX_Data RX_ (
		.reset_n(reset_n), 
		.clk(rx_clk), 
		.RXD(RXD), 
		.rx_complete_del_flag(tx_busy), 
		.RX_DATA(RX_DATA), 
		.rx_complete_flag(A)
	);	

//wire start;
//assign start=1'b1;

TX_Data TX_ (
		.reset_n(reset_n), 
		.clk(tx_clk), 
		.DATA(RX_DATA), 
		.tx_complete_del_flag(A), 
		.button(A),///// 
		.TXD(TXD), 
		.tx_busy(tx_busy), 
		.tx_complete_flag(B)
	);
	
	
endmodule