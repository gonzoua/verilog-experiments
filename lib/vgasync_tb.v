`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:43 01/28/2013
// Design Name:   vga_sync
// Module Name:   C:/Projects/verilog-experiments/lib/vgasync_tb.v
// Project Name:  vgademo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_sync
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vgasync_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);

	initial begin
		$display($time, " << Starting the Simulation >>");
		
		// Initialize Inputs
		clk = 0;
		reset = 1;

		#20 reset = 0;
	end
	
	always
		#10 clk = ~clk; // every ten nanoseconds invert
      
endmodule

