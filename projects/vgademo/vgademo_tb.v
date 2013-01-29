`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:20 01/28/2013
// Design Name:   vgademo
// Module Name:   C:/Projects/verilog-experiments/projects/vgademo/vgademo_tb.v
// Project Name:  vgademo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vgademo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vgademo_tb;

	// Inputs
	reg clk;
	reg btn;

	// Outputs
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [1:0] vgaBlue;
	wire vgaHsync;
	wire vgaVsync;

	// Instantiate the Unit Under Test (UUT)
	vgademo uut (
		.clk(clk), 
		.btn(btn), 
		.vgaRed(vgaRed), 
		.vgaGreen(vgaGreen), 
		.vgaBlue(vgaBlue), 
		.vgaHsync(vgaHsync), 
		.vgaVsync(vgaVsync)
	);

	initial begin
		$display($time, " << Starting the Simulation >>");
		
		// Initialize Inputs
		clk = 0;
		btn = 1;

		#20 btn = 0;
	end
	
	always
		#10 clk = ~clk; // every ten nanoseconds invert
      
endmodule

