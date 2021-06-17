//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:Amelia Carse
// Date: 17/06/21
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module lights_selector(
    //Todo: add ports 
	input clk,
        input sel,
	input rst,
	input button,
	output [23:0] light
    );
	
	//wires and registers
	wire [23:0] rgb;
	wire [2:0] colour;
	//wire enable

//Todo: Instantiate lED module
lights my_lights(
		.clk (clk),
		.rst (rst),
		.button (button),
		.colour (colour)
    	);

//Todo: Instantiate RGB converter module
RGB_converter my_RGB_converter(
		.clk (clk),
		.colour (colour),
		.enable (1'b1),	
		.rgb (rgb)
	);
//Todo: Instantiate multiplexer (doorbell, ex2) module
doorbell my_doorbell(
		.a(24'hFFFFFF),
		.b(rgb),
		.sel(sel),
		.out(light)
	            );
endmodule
