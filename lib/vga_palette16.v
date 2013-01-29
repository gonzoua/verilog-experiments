`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:04 01/28/2013 
// Design Name: 
// Module Name:    vga_palette16 
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
module vga_palette16(
		input intensity,
		input [2:0] color,
		output [2:0] red, green,
		output [1:0] blue
    );

	wire [2:0] on, off;
	
	assign off = intensity ? 3'b010 : 3'b000;
	assign on = intensity ? 3'b111 : 3'b101;

	assign red = color[2] ? on : off;
	// special case for brown
	assign green = ((intensity == 0) && (color == 3'b110)) ? 3'b010 :
		color[1] ? on : off;
	assign blue = color[0] ? on[2:1] : off[2:1];
endmodule
