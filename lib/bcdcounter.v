`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:14:40 01/30/2013 
// Design Name: 
// Module Name:    bcdcounter 
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
module bcdcounter
	(
		input clk, reset,
		input en,
		output [7:0] data,
		output tick
	);
	
	reg [7:0] data_reg;
	reg tick_reg;
	
	always @(posedge clk, posedge reset)
		if (reset)
			begin
				data_reg <= 8'b00000000;
				tick_reg <= 0;
			end
		else
			begin
				if (en)
					begin
						if (data_reg[3:0] == 9)
							begin
								data_reg[3:0] <= 0;
								if (data_reg[7:4] == 5)
									begin
										data_reg[7:4] <= 0;
										tick_reg <= 1;
									end
								else
									begin
										data_reg[7:4] <= data_reg[7:4] + 1;
										tick_reg <= 0;
									end
							end
						else
						begin
							tick_reg <= 0;
							data_reg[3:0] <= data_reg[3:0] + 1;
						end
					end
				else
					begin
						tick_reg <= 0;
					end
			end
	
	assign data = data_reg;
	assign tick = tick_reg;
	
endmodule
