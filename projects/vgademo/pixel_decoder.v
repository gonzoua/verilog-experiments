`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:35 01/28/2013 
// Design Name: 
// Module Name:    pixel_decoder 
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
module pixel_decoder(
		input clk, reset, video_on,
		input [9:0] pixel_x, pixel_y,
		output intensity, 
		output [2:0] color
    );

	reg [2:0] color_reg, color_next;
	reg intensity_reg, intensity_next;
	
	always @(posedge clk, posedge reset)
	if (reset)
		begin
			color_reg <= 3'b000;
			intensity_reg <= 1'b0;
		end
	else
		begin
			color_reg <= color_next;
			intensity_reg <= intensity_next;
		end
		
	always @*
		begin
			color_next = (pixel_x < 80) ? 3'b000 :
				(pixel_x < 2*80) ? 3'b001 :
				(pixel_x < 3*80) ? 3'b010 :
				(pixel_x < 4*80) ? 3'b011 :
				(pixel_x < 5*80) ? 3'b100 :
				(pixel_x < 6*80) ? 3'b101 :
				(pixel_x < 7*80) ? 3'b110 : 3'b111;
			intensity_next = pixel_y < 240 ? 1'b0 : 1'b1;
		end
	
	assign color = (video_on) ? color_reg : 3'b000;
	assign intensity = (video_on) ? intensity_reg : 1'b0;

endmodule
