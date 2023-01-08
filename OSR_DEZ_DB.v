`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:50 06/14/2022
// Design Name:   OSR_Dezimierer
// Module Name:   H:/FPGA_Prak/Versuch4/UART/OSR_DEZ_DB.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: OSR_Dezimierer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module OSR_DEZ_DB;

	// Inputs
	wire clk;
	clock_generator timer(.clk(clk));
	reg reset_n;

	// Outputs
	wire tx_clk;

	// Instantiate the Unit Under Test (UUT)
	OSR_Dezimierer uut (
		.clk(clk), 
		.reset_n(reset_n), 
		.tx_clk(tx_clk)
	);

	initial begin
		// Initialize Inputs
	
		reset_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
        reset_n = 1;
		// Add stimulus here

	end
      
endmodule

