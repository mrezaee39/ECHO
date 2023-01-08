`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:50 06/14/2022
// Design Name:   Dezimierer
// Module Name:   H:/FPGA_Prak/Versuch4/UART/Dezimierer.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Dezimierer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Dezimierer;

	// Inputs
	wire clk1;
	clock_generator timer(.clk(clk1));
	reg reset_n;

	// Outputs
	wire clk_dez;

	// Instantiate the Unit Under Test (UUT)
	Dezimierer uut (
		.clk(clk1), 
		.reset_n(reset_n), 
		.clk_dez(clk_dez)
	);

	initial begin
		// Initialize Inputs
		reset_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

