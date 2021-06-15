//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:Amelia Carse
// Date: 15/06/21
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
    reg clk;
    reg rst;
    reg button;
    reg err;
    wire [2:0] colour;
    reg[2:0] colour_prev;

//Todo: Clock generation
  initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
       rst=1;
       button=0;
       err=0;
       colour_prev = 3'b000;

#(5*CLK_PERIOD);
      if (colour != 3'b000)
	begin $display ("***TEST FAILED! reset error");
	err = 1;
  end

rst = 0;
#(5*CLK_PERIOD);
 if (colour != 3'b001)
	begin $display ("***TEST FAILED! colour transition error when button off");
	err = 1;
  end

button = 1;
       forever begin
         #CLK_PERIOD;
	
	colour_prev = colour_prev < 3'b110 ? colour_prev + 3'b001: 3'b001;
		if(colour != colour_prev)
          		begin 
	    		$display("***TEST FAILED! colour tansition error when button on");
             err=1;
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
lights top(
     .rst (rst),
     .clk (clk),
     .button (button),
     .colour (colour)
     );
 
endmodule 
