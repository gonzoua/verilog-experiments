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
		input vsync,
		output intensity, 
		output [2:0] color
    );

	reg [2:0] color_reg, color_next;
	reg intensity_reg, intensity_next;
	wire [31:0] char_next;
	reg [31:0] char_reg;
	wire [7:0] current_char;
	wire [7:0] tile_row;
	reg bitmap_pixel, bitmap_pixel_next;
	wire [7:0] min, sec;
	wire in_area;
	wire [9:0] offset_x, offset_y;
	
	always @(posedge clk, posedge reset)
	if (reset)
		begin
			color_reg <= 3'b000;
			intensity_reg <= 1'b0;
			bitmap_pixel <= 1'b0;
			char_reg <= 32'h0;
		end
	else
		begin
			color_reg <= color_next;
			intensity_reg <= intensity_next;
			bitmap_pixel <= bitmap_pixel_next;
			char_reg <= char_next;
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
			if (in_area)
				case (offset_x[5:3])
					3'b000: bitmap_pixel_next = tile_row[7];
					3'b001: bitmap_pixel_next = tile_row[6];
					3'b010: bitmap_pixel_next = tile_row[5];
					3'b011: bitmap_pixel_next = tile_row[4];
					3'b100: bitmap_pixel_next = tile_row[3];
					3'b101: bitmap_pixel_next = tile_row[2];
					3'b110: bitmap_pixel_next = tile_row[1];
					3'b111: bitmap_pixel_next = tile_row[0];
				endcase
			else
				bitmap_pixel_next = 0;
		end
	
	assign color = (video_on && bitmap_pixel) ? color_reg : 3'b000;
	assign intensity = (video_on && bitmap_pixel) ? intensity_reg : 1'b0;
	
	font8x16_koi8_u_rom font_rom
		(.clk(clk), .addr({current_char,offset_y[6:3]}), .data(tile_row));
		
	clock clock
		(.clk(clk), .reset(reset), .min(min), .sec(sec));

	assign char_next[7:0] = vsync ? (8'h30 + sec[3:0]) : char_reg[7:0];
	assign char_next[15:8] = vsync ? (8'h30 + sec[7:4]) : char_reg[15:8];
	assign char_next[23:16] = vsync ? (8'h30 + min[3:0]) : char_reg[23:16];
	assign char_next[31:24] = vsync ? (8'h30 + min[7:4]) : char_reg[31:24];

	assign current_char = offset_x[8:6] == 3'b000 ? char_reg[31:24] : 
										(offset_x[8:6] == 3'b001) ? char_reg[23:16]: 
										(offset_x[8:6] == 3'b010) ? 8'h3a : 
										(offset_x[8:6] == 3'b011) ? char_reg[15:8]: 
										(offset_x[8:6] == 3'b100) ? char_reg[7:0]: 
										8'h20;
	
	assign in_area = (pixel_x >= 160) && (pixel_x < 480) && (pixel_y >= 176) && (pixel_y < 304);  
	assign offset_x = pixel_x - 160;
	assign offset_y = pixel_y - 176;
endmodule
