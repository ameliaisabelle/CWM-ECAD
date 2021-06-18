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
	reg [1:0] vector;
	reg err;
	wire heating;
	wire cooling;
	reg direction;

//Todo: Clock generation
   initial
    begin
       clk_p = 1'b0;
       forever
         #(CLK_PERIOD/2) clk_p=~clk_p;
     end
 
assign clk_n=~clk_p;

     initial begin
       err=0;
       temp=0;
       direction=1;
       rst_n =1;
       #(CLK_PERIOD*10)
       rst_n=0;
       forever begin
         #CLK_PERIOD
         direction = (temp==5'd1) ? 1 : (temp==5'd31) ? 0 : direction;
         temp = direction? temp + 1 : temp -1 ;       
       end
     end

//Todo: Finish test, check for success
	initial begin
        #500
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate  module
	AC_sys my_AC_sys(
	.temp (temp),
	.clk_n (clk_n),
	.clk_p (clk_p),
	.rst_n (rst_n),
	.heating (heating),
	.cooling (cooling)
	);
 
endmodule
	
