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

//Todo: Clock generation
	initial
    	begin
	   clk_p = 1'b0;
	   forever
		#(CLK_PERIOD/2) clk_p=~clk_p;
	end
	assign clk_n =~ clk_p

//Todo: User logic
//Increase temp
	initial begin
	   temp = 5'd17;
	   err = 0;
	   rst_n = 0;
	   forever begin
		#CLK_PERIOD
		temp = temp + 1;
		#CLK_PERIOD
		temp = temp + 1;
		#CLK_PERIOD
		temp = temp + 1;
		#CLK_PERIOD
		temp = temp + 1;
		#CLK_PERIOD
		temp = temp + 1;
		#CLK_PERIOD
		temp = temp + 1; //23 degrees
		#CLK_PERIOD
		temp = temp - 1;
		#CLK_PERIOD
		temp = temp - 1;
		#CLK_PERIOD
		temp = temp - 1;
		#CLK_PERIOD
		temp = temp - 1;
		#CLK_PERIOD
		temp = temp - 1;
		#CLK_PERIOD
		temp = temp - 1; //17 degrees
	   end
	end


initial begin
#(5*CLK_PERIOD)
err = 0;
vector = {cooling, heating};
	forever begin
	#(5*CLK_PERIOD)
	case(vector)
		0: if ((temp <= 18 )&&(heating != 1))begin 
	    					$display("***TEST FAILED!0.1");
             					err=1;
						end
		   else if(heating!=0 && cooling!=0) begin
						$display("***TEST FAILED!0.2 ***");
						err=1;		
						end
		   else if ((temp >= 22)&&(cooling != 1))begin 
	    					$display("***TEST FAILED!0.3");
             					err=1;
						end 
		1: if ((temp <= 20)&&(cooling != 0))begin 
	    					$display("***TEST FAILED!1.1");
             					err=1;
						end 
		   else if ((temp > 20)&&(cooling != 1))begin 
	    					$display("***TEST FAILED!1.2");
             					err=1;
						end
		2: if ((temp < 20)&&(heating != 1))begin 
	    					$display("***TEST FAILED!2.1");
             					err=1;
						end
		 else if ((temp >= 20)&&(heating != 0))begin 
	    					$display("***TEST FAILED!2.2");
             					err=1;
						end
		endcase
	end
end
//test to ensure cooling and heating aren't on at the same time
initial begin
	vector = {cooling,heating};
   		forever begin
			#CLK_PERIOD
			vector = {cooling,heating};
			if(vector == 2'b11) begin
		   	$display("***TEST FAILED! cooling and heating cannot run in parallel***");
		   	err=1;
			end
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
	.temp_0 (temp[0]),
	.temp_1 (temp[1]),
	.temp_2 (temp[2]),
	.temp_3 (temp[3]),
	.temp_4 (temp[4]),
	.clk_n (clk_n),
	.clk_p (clk_p),
	.rst_n (rst_n),
	.heating (heating),
	.cooling (cooling)
	);
 
endmodule
	
