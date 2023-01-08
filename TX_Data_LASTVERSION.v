`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:45 06/14/2022 
// Design Name: 
// Module Name:    TX_Data 
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
module TX_Data(
	 input  wire reset_n,////
	 input  wire clk,
    input  wire [7:0] DATA,
	 input  wire tx_complete_del_flag,
    input  wire button,//output of debouncer	 
		
    output reg  TXD,
	 output reg tx_busy,
	 output reg tx_complete_flag
    );
	 
reg [7:0] Buffer;
//assign Buffer = DATA;

reg [3:0] tx_index;
reg [3:0] state;
   
parameter IDLE=3'd0;
parameter START_BIT=3'd1; 
parameter DATA_TX=3'd2; 
parameter STOP_BIT=3'd3;

always @ (posedge clk or negedge reset_n) 
begin
		if(!reset_n) //reset Logik
	begin
			state <= IDLE;
			TXD<=1'b1;
			tx_complete_flag<=1'b0;
			tx_busy<=1'b0;
			tx_index<=4'b000; // it was 3 I turned it to 4
			Buffer<=8'b0;
	end
		else 
			begin//Flache FSM_Struktur
				case(state)
	IDLE:begin	
						TXD<=1'b1;//pull up in order to notic start bit 
						tx_busy<=1'b0;
						tx_index<=4'b000;
//						if(tx_complete_del_flag) begin  //Handshaking seite 7 aus script Versucht4
//						tx_complete_flag<=1'b0;
//						state<=IDLE;
//						end
//						else begin  // do we not need a button or something which says start?! in order to go to next state
//						tx_complete_flag<=tx_complete_flag;
						if(button) begin//debouncer
						state<=START_BIT;
						Buffer <= DATA;
						end
						else begin
						state<=IDLE;
						Buffer <= Buffer;
						end
	end
					
   START_BIT:begin
						TXD<=1'b0;
						tx_complete_flag<=1'b0;
						tx_busy<=1'b1;
						tx_index<=4'b000;
						state<=DATA_TX;
	end

	 DATA_TX:begin
						tx_complete_flag<=1'b0;
						tx_busy<=1'b1;
						TXD<=Buffer[tx_index];
						if(tx_index<7)begin
						tx_index<=tx_index+1; // alternativ : DATA<=DATA>>1;
						state<=DATA_TX;
						end
						else begin
						tx_index<=4'b000;
						state<=STOP_BIT;////////////
						end
	 end
		
	 STOP_BIT:begin
						TXD<=1'b1;
						tx_index<=4'b000;
						tx_complete_flag<=1'b1;
						tx_busy<=1'b0;
						if(!button)begin
						state<=IDLE;
						end
						else begin
						state<=START_BIT;
						end
						
		end		
		
					
				endcase
end	
end

endmodule