`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:46 01/28/2013 
// Design Name: 
// Module Name:    vga_sync 
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
module vga_sync(
		input wire clk, reset,
		output wire hsync_n, vsync_n, video_on, p_tick,
		output wire [9:0] pixel_x, pixel_y
    );

	localparam HD = 640;
	localparam HF = 48;
	localparam HB = 16;
	localparam HR = 96;
	localparam VD = 480;
	localparam VF = 10;
	localparam VB = 33;
	localparam VR = 2;


	// mod-2 counter
	reg mod2_reg;
	wire mod2_next;
	
	// sync counters
	reg [9:0] h_count_reg, h_count_next;
	reg [9:0] v_count_reg, v_count_next;
	
	// output buffer
	reg v_sync_reg, h_sync_reg;
	wire v_sync_next, h_sync_next;
	
	// status signal
	wire h_end, v_end, pixel_tick;
	
	// body
	// registers
	always @(posedge clk, posedge reset)
		if (reset)
			begin
				mod2_reg <= 1'b0;
				v_count_reg <= 0;
				h_count_reg <= 0;
				v_sync_reg <= 1'b0;
				h_sync_reg <= 1'b0;
			end
		else
			begin
				mod2_reg <= mod2_next;
				v_count_reg <= v_count_next;
				h_count_reg <= h_count_next;
				v_sync_reg <= v_sync_next;
				h_sync_reg <= h_sync_next;
			end
			
	// 25MHz enable tick
	assign mod2_next = ~mod2_reg;
	assign pixel_tick = mod2_reg;
	
	// status signals
	// end of horyzontal counter
	assign h_end = (h_count_reg == (HD+HF+HB+HR-1));
	assign v_end = (v_count_reg == (VD+VF+VB+VR-1));
	
	// next-state logic for mod-800 horizontal sync counter
	always @*
		if (pixel_tick)
			if (h_end)
				h_count_next = 0;
			else
				h_count_next = h_count_reg + 1;
		else
			h_count_next = h_count_reg;

	// next-state logic for mod-800 horizontal sync counter
	always @*
		if (pixel_tick & h_end)
			if (v_end)
				v_count_next = 0;
			else
				v_count_next = v_count_reg + 1;
		else
			v_count_next = v_count_reg;

	// horizontal and vertical sync. Active low
	assign h_sync_next = (h_count_reg >= (HD+HB) &&
								 h_count_reg <= (HD+HB+HR-1)) ? 0 : 1;
	assign v_sync_next = (v_count_reg >= (VD+VB) &&
								 v_count_reg <= (VD+VB+VR-1)) ? 0 : 1;

	// video on/off
	assign video_on = (h_count_reg < HD) && (v_count_reg < VD);
	
	// output
	assign hsync_n = h_sync_reg;
	assign vsync_n = v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	assign p_tick = pixel_tick;
endmodule
