`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:17 01/28/2013 
// Design Name: 
// Module Name:    vgademo 
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
module vgademo(
		input clk, btn,
		output wire [2:0] vgaRed,
		output wire [2:0] vgaGreen,
		output wire [1:0] vgaBlue,
		output vgaHsync, vgaVsync
    );
	 

	wire video_on;
	wire reset;
	
	wire [9:0] pixel_x, pixel_y;
	wire [9:0] transformed_x, transformed_y;
	wire [2:0] color;
	wire intensity;
	wire vsync_n, vsync;
	
	vga_sync vsync_unit
		(.clk(clk), .reset(reset), .hsync_n(vgaHsync), .vsync_n(vsync_n),
		 .video_on(video_on), .p_tick(), .pixel_x(pixel_x), .pixel_y(pixel_y));
	
	pixel_decoder pixel_unit
		(.clk(clk), .reset(reset), .pixel_x(transformed_x), .pixel_y(transformed_y),
		  .video_on(video_on), .color(color), .intensity(intensity));
	
	vga_palette16 palette_unit
		(.color(color), .intensity(intensity),
		 .red(vgaRed), .green(vgaGreen), .blue(vgaBlue));
		 
	coord_transformer transform
		(.clk(clk), .reset(reset), .vsync(vsync), .x(pixel_x), .y(pixel_y), .new_x(transformed_x), .new_y(transformed_y));

	assign reset = btn;
	assign vgaVsync = vsync_n;
	assign vsync = ~vsync_n;
	
endmodule
