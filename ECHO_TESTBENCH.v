`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:40:59 06/21/2022
// Design Name:   UART_Echo
// Module Name:   H:/FPGA_Prak/Versuch4/UART/ECHO_TESTBENCH.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Echo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ECHO_TESTBENCH;

	// Inputs
wire clk;
	clock_generator timer(.clk(clk));
	reg reset_n;
	reg RXD;

	// Outputs
	wire TXD;

	// Outputs
	//wire [7:0] RX_DATA;
	
	wire rx_clk;
	wire tx_clk;
	

	reg [7:0] DATA;
	
	//reg start_echo;
	reg start;
	
	wire TXD_2;
	// Outputs
	
	reg A;
	wire B;
	wire tx_busy;
	
	// Instantiate the Unit Under Test (UUT)
	UART_Echo uutt_ (
		.clk(clk), 
		.reset_n(reset_n), 
		.RXD(TXD), 
		.TXD(TXD_2)
		//.button(start_echo)
	);

Baudrate_topmodule BAUD_(
     .clk(clk),
	  .reset_n(reset_n),
     .rx_clk(rx_clk),
     .tx_clk(tx_clk)
    );


	// Instantiate the Unit Under Test (UUT)

	
	TX_Data TX_F (
		.reset_n(reset_n), 
		.clk(tx_clk), 
		.DATA(DATA), 
		.tx_complete_del_flag(A), 
		.button(start), 
		.TXD(TXD), 
		.tx_busy(tx_busy), 
		.tx_complete_flag(B)
	);

	initial begin
		// Initialize Inputs
		
		reset_n = 0;
		RXD = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset_n=1;
		DATA=8'b11010110;
		start = 1; 
 		A=0;
		
		if(tx_busy) begin
		start <=1'b0;
		end
		else
		start<=1'b1;
		end
		//start_echo = 1;
			
		   //#100;
		  //start = 0;
		//  #10000;//
		//$stop; 
		// Add stimulus here
		
//	end
	
	//always @ (*) begin
		//if(tx_busy) begin
		//	#10 DATA <= DATA + 1'b1;
		//end else begin
			//start <= start;
		//	DATA <= DATA;
		//end
//	end
      
endmodule

