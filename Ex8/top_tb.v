//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name:Amelia Carse
// Date:18/06/21
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg clk_p;
	wire clk_n;
	reg rst_n;
	reg [4:0] temp;
	reg err;
	wire heating;
	wire cooling;

//Todo: Clock generation
	initial
    	begin
	   clk_p = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk_p=~clk_p;
	end
	end
	assign clk_n =~ clk_p
//Todo: User logic
	initial begin
	err=0;
	rst_n = 0;
	
