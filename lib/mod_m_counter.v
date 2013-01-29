`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:41 01/28/2013 
// Design Name: 
// Module Name:    mod_m_counter 
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
module mod_m_timer
	#(
		parameter N=4, // number of bits in timer counter
					 M=10 // mod-M
	)
	(
		input wire clk, reset,
		output wire tick
    );

	reg [N-1:0] counter;
	wire [N-1:0] counter_next;
	
	always @(posedge clk, posedge reset)
		if (reset)
			counter <= 0;
		else
			counter <= counter_next;
			
	assign counter_next = (counter == (M-1)) ? 0 : counter + 1;
	assign tick = (counter == (M-1)) ? 1'b1 : 1'b0;
endmodule
