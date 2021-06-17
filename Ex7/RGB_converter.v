//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name:Amelia Carse
// Date: 17/06/21
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module RGB_converter(
    //Todo: add ports 
	input clk,
        input [2:0] colour,
	input enable,
	output [23:0] rgb
    );
//IP core
	blk_mem_gen_0 top (
	  .addra(colour), //colour input [2:0]
	  .clka(clk),         
	  .dina(24'b0), //input = 3x8bit   
	  .douta(rgb), // output rgb[23:0]
	  .ena(enable),      
	  .wea(1'b0)  
	);
endmodule
