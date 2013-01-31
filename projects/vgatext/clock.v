`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:31 01/29/2013 
// Design Name: 
// Module Name:    clock 
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
module clock(
		input clk, reset,
		output [7:0] sec, min
    );
	 
	localparam DVSR = 5000000;

	reg [22:0] ms_reg;
	wire [22:0] ms_next;
	reg[3:0] dsec_reg;
	wire [3:0] dsec_next;
	
	wire dsec_en;
	wire dsec_tick, sec_tick;
	
	always @(posedge clk, posedge reset)
		if (reset)
			begin
				dsec_reg <= 4'b0000;
				ms_reg <= 22'b0;
			end
		else
			begin
				dsec_reg <= dsec_next;
				ms_reg <= ms_next;
			end
			
	assign ms_next = (ms_reg == DVSR) ? 22'b0 : (ms_reg + 1);
	assign ms_tick = (ms_reg == DVSR);
		
	assign dsec_en = ms_tick;
	assign dsec_next = (dsec_en && (dsec_reg == 9)) ? 4'b0 :
									dsec_en ? dsec_reg + 1 : dsec_reg;
	assign dsec_tick = (dsec_reg == 9);							


	bcdcounter seconds(
		.clk(clk), .reset(reset), .en(dsec_tick && ms_tick), .tick(sec_tick), .data(sec)
		);

	bcdcounter minutes(
		.clk(clk), .reset(reset), .en(sec_tick && ms_tick), .tick(), .data(min)
		);

endmodule
