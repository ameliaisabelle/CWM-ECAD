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
rst = (0 || 1);
button = (0 || 1);
sel = 0;

#(5*CLK_PERIOD)
	if (light != 24'hFFFFFF) begin 
	    		$display("***TEST FAILED! Light should be white when sel = 0");
             err=1;
	end


rst = 1;
button = 0;
sel = 1;

#(5*CLK_PERIOD)
	if (light != 24'h000000) begin 
	    		$display("***TEST FAILED! Light should reset when rst = 1 and sel = 1");
             err=1;
	end


light_prev = light;
rst = 0;


    	#(CLK_PERIOD)
   	 if (light!= light_prev) begin
	    $display("***TEST FAILED! If button = 0 lights shoudl not change ***");
        	err=1; 
   	 end



    forever begin
        light_prev = light;
        button = 1;

        #(CLK_PERIOD)
        if (light == light_prev) begin
            $display("***TEST FAILED! Light should change colour when button = 1 in rgb mode***");
            err = 1;
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


//Todo: Instantiate module
lights_selector top(
     .rst (rst),
     .clk (clk),
     .sel (sel),
     .button (button),
     .light (light)
     );
 
endmodule 
