//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:Amelia Carse
// Date:14/06/21
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
    reg clk;
    reg rst;
    reg change;
    reg on_off;
    reg err;
    wire [7:0] counter_out;
    reg[7:0] counter_out_prev;

//Todo: Clock generation
  initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
       rst=1;
       on_off=1;
       change=0;
       err=0;
       counter_out_prev = 0;

#(5*CLK_PERIOD);
      if (counter_out!= 0)
	begin $display ("***TEST FAILED! reset error");
	err = 1;
  end

rst = 0;
#(5*CLK_PERIOD);
 if (counter_out!= counter_out_prev)
	begin $display ("***TEST FAILED! indicator error");
	err = 1;
  end

change = 1;
       forever begin
         #CLK_PERIOD;
	counter_out_prev = on_off ? counter_out_prev + 1: counter_out_prev - 1;
	if(counter_out != counter_out_prev)
          begin 
	    $display("***TEST FAILED! on/off error");
             err=1;
	end

	 if (counter_out_prev == 10)
	on_off = ~on_off;

	
     end
end
		

	    
//Todo: Finish test, check for success
 initial begin
        #500
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


//Todo: Instantiate counter module
 monitor top(
     .rst (rst),
     .change (change),
     .clk (clk),
     .on_off (on_off),
     .counter_out (counter_out)
     );
 
endmodule 
