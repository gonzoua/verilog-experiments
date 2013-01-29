`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:31 01/28/2013 
// Design Name: 
// Module Name:    counter 
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
module counter	
	#(
		parameter N=4, // number of bits in counter
					 M=10 // mod-M
	)
	(
		input wire clk, add, reset,
		output wire[N-1:0]value
    );

	reg [N-1:0] counter;
	wire [N-1:0] counter_next;

	always @(posedge clk, posedge reset)
		if (reset)
			counter <= 0;
		else
			counter <= counter_next;
			
	assign counter_next = add ?
		((counter == (M-1)) ? 0 : counter + 1) : counter;
		
	assign value = counter;
	
endmodule
