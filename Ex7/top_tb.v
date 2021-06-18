//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:Amelia Carse
// Date:17/06/21
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
// Parameters
parameter CLK_PERIOD = 10;
reg clk;
reg sel;
reg rst;
reg button;
reg err;
wire [23:0] light;
reg [23:0] light_prev;

//Todo: Clock generation
  initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
err = 0;
rst = 1;
button = 0;
sel = 0;

#(10*CLK_PERIOD)
	if (light != 24'hFFFFFF) begin 
	    		$display("***TEST FAILED! Light should be white when sel = 0");
             err=1;
	end


rst = 1;
button = 0;
sel = 1;

#(10*CLK_PERIOD)
	if (light != 24'h000000) begin 
	    		$display("***TEST FAILED! Light should reset when rst = 1 and sel = 1");
             err=1;
	end






  
rst = 0;
button = 1;
light_prev = 24'h0000FF;
       forever begin
        #(10*CLK_PERIOD)
	light_prev = (light_prev == 24'h0000FF)? 24'h00FF00:
			(light_prev == 24'h00FF00)? 24'hFF0000:
			(light_prev == 24'hFF0000)? 24'h00FFFF:
			(light_prev == 24'h00FFFF)? 24'hFF0000:
			(light_prev == 24'hFF0000)? 24'hFF00FF:
			(light_prev == 24'hFF00FF)? 24'hFFFF00:
			(light_prev == 24'hFFFF00)? 24'h0000FF:
			(light_prev == 24'hFFFFFF)? 24'h0000FF:
			(light_prev == 24'h000000)? 24'h0000FF:			 
			24'h0000FF;

		if(light != light_prev)
          		begin 
	    		$display("***TEST FAILED! colour tansition error when button on");
             err=1;
		end
	end
end

//Todo: Finish test, check for success
initial begin
        #1000
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


//Todo: Instantiate module
lights_selector top(
     .rst (rst),
     .clk (clk),
     .sel (sel),
     .button (button),
     .light (light)
     );
 
endmodule 
