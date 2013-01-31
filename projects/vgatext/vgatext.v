`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:41 01/29/2013 
// Design Name: 
// Module Name:    vgatext 
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
module vgatext(
		input clk, btn,
		output wire [2:0] vgaRed,
		output wire [2:0] vgaGreen,
		output wire [1:0] vgaBlue,
		output vgaHsync, vgaVsync
    );
	 

	wire video_on;
	wire reset;
	
	wire [9:0] pixel_x, pixel_y;

	wire [2:0] color;
	wire intensity;
	wire vsync_n, vsync;
	
	vga_sync vsync_unit
		(.clk(clk), .reset(reset), .hsync_n(vgaHsync), .vsync_n(vsync_n),
		 .video_on(video_on), .p_tick(), .pixel_x(pixel_x), .pixel_y(pixel_y));
	
	pixel_decoder pixel_unit
		(.clk(clk), .reset(reset), .pixel_x(pixel_x), .pixel_y(pixel_y),
		  .video_on(video_on), .vsync(vsync), .color(color), .intensity(intensity));
	
	vga_palette16 palette_unit
		(.color(color), .intensity(intensity),
		 .red(vgaRed), .green(vgaGreen), .blue(vgaBlue));
		 
		 
	assign reset = btn;
	assign vgaVsync = vsync_n;
	assign vsync = ~vsync_n;
	
endmodule
