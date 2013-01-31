`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:04:36 01/29/2013
// Design Name:   clock
// Module Name:   C:/Projects/verilog-experiments/projects/vgatext/clock_tb.v
// Project Name:  vgatext
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [3:0] dsec;
	wire [5:0] sec;
	wire [5:0] min;

	// Instantiate the Unit Under Test (UUT)
	clock uut (
		.clk(clk), 
		.reset(reset),
		.dsec(dsec),
		.sec(sec), 
		.min(min)
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

