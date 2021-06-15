//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:Amelia Carse
// Date: 15/06/21
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module lights (
    input clk,
    input rst,
    input button,
    output reg [2:0] colour

    );
always @ (posedge clk) begin
	if(rst == 1)
	  colour = 3'b0;
	else begin
		if(button == 0)
		colour <= ((colour == 3'b000) || (colour == 3'b111)) ? 3'b001: colour;
		else
		colour <= (colour < 3'b110)? colour + 3'b001: 3'b000;
	     end
	end
      
endmodule
       
