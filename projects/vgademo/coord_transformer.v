`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:33 01/28/2013 
// Design Name: 
// Module Name:    coord_transformer 
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
module coord_transformer(
		input clk, reset, vsync,
		input [9:0] x, y,
		output [9:0] new_x, new_y
		);

	wire increase;
	reg [9:0] shift_value_reg;
	wire [9:0] shift_value_next;
	wire [10:0] raw_x_value;

	mod_m_timer #(.N(19), .M(400000)) divider(.clk(clk), .reset(reset), .tick(increase));
	counter #(.N(10), .M(640)) x_shift(.clk(clk), .reset(reset), .add(increase), .value(shift_value_next));
	
	// change shift value only during vsync
	always @(posedge clk)
		if (reset)
			shift_value_reg <= 10'b0000000000;
		else
			if (vsync)
				shift_value_reg <= shift_value_next;
			
	
	assign raw_x_value = shift_value_reg + x;
	assign new_x = (raw_x_value < 640) ? raw_x_value : (raw_x_value - 640);
	assign new_y = y;

endmodule
