`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:27 05/10/2022 
// Design Name: 
// Module Name:    RX_Data 
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
module RX_Data(//////////
	 input  wire reset_n,
	 input  wire clk,
    input  wire RXD,
	 input  wire rx_complete_del_flag, 
		
    output reg [7:0] RX_DATA,
	 output reg rx_complete_flag
    );
	 

reg [3:0] rx_index;
reg [3:0] state;
reg [3:0] wait_cnt;
//reg [7:0] DATA_START;
reg [7:0] DATA;
//reg [7:0] DATA_STOP;

parameter IDLE=4'd0;
parameter START_BIT=4'd1;
parameter get_data =4'd2; 
parameter STOP_BIT=4'd3;
parameter COMPLETE=4'd4;

always @ (posedge clk or negedge reset_n) 
begin
		if(!reset_n) //reset Logik
	begin
			state <= IDLE;
			RX_DATA <= 8'b0;
			DATA <= 8'b0;
		//	DATA_START<= 8'b0;
			//DATA_STOP<= 8'b0;
			rx_complete_flag<=1'b0;
			rx_index<=4'b000;
			wait_cnt<=4'd15;
			
	end
		else 
			begin//Flache FSM_Struktur
				case(state)
	IDLE:begin	
						RX_DATA <= 8'b0;
						DATA <= 8'b0;
						//DATA_START<= 8'b0;
						
						rx_index<=4'b0000;
						wait_cnt<=4'd15;
						
					if(rx_complete_del_flag) begin 
						rx_complete_flag<=1'b0;
						state<=IDLE;
					end
					else begin  
						rx_complete_flag<=rx_complete_flag;
					//	rx_complete_flag<=1'b0;
						if(!RXD)begin
						state<=START_BIT;
						end
						else begin
						state<=IDLE;
						end
					end
			end		
	
	START_BIT:begin
						RX_DATA <= 8'b0;
						DATA <= 8'b0;
						rx_index<=4'b0000;
						
						if(wait_cnt!=4'd0)begin 
						wait_cnt<=wait_cnt-1'b1;
						state<=START_BIT;
						end
						else begin
						wait_cnt<=4'd15;
						//state<=(DATA_START>7)? START_BIT:get_data; //>=8
						state<=get_data;
						end
					end	
				
   get_data:begin
						
						DATA<=DATA+RXD;
				if(wait_cnt!=4'd0)begin 
						wait_cnt<=wait_cnt-1'b1;
						state<=get_data;
				end
				else begin
						RX_DATA[rx_index]<=(DATA>7)? 1:0;//>=8
					if(rx_index<7)begin
						rx_index<=rx_index+1;
						wait_cnt<=4'd15;
						DATA <= 8'b0;
						state<=get_data;
					end	
					else begin
					state<=STOP_BIT;
					wait_cnt<=4'd15;
					end
				end
					  
							
				end

	
		
	 STOP_BIT:begin
	 // i added a wait_time here 15:18
						DATA <= 8'b0;
						rx_index<=4'b0000;
						rx_complete_flag<=1'b1;
						//DATA_STOP<=DATA_STOP+RXD;
						if(wait_cnt!=4'd0)begin 
						wait_cnt<=wait_cnt-1'b1;
						//DATA_STOP<=DATA_STOP;
						end
						else begin
						//state<=(DATA_STOP>=8)? IDLE:STOP_BIT;
						//DATA_STOP<=(DATA_STOP>=8)? 1:0;
						wait_cnt<=4'd15;
						state<=IDLE;
						end
					end

				endcase
end	
end

endmodule