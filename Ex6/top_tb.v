//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Amelia Carse
// Date: 17/06/21
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
    reg clk;
    reg err;
    reg [2:0] colour;
    wire [23:0] rgb;
    reg enable;

//Todo: Clock generation
  initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
       enable=0;
       err=0;
       colour = 3'b000;
       #(5*CLK_PERIOD);
       
	if(rgb != 24'h0) begin
		   $display("***TEST FAILED! RGB must be 0 when enable is 0***");
		   err=1;
	end

 end


initial begin
enable = 1;
#CLK_PERIOD;
       forever begin
         #CLK_PERIOD;

	err<=(((colour[0])==(&rgb[7:0]))&((colour[1])==(&rgb[15:8]))&((colour[2])==(&rgb[23:16])))?0: 1;
		if(err == 1)
          		begin 
	    		$display("***TEST FAILED! RGB and colour do not match");
            
		end
	colour = colour+ 3'b001; 
            
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
RGB_converter top(
     .enable (enable),
     .clk (clk),
     .rgb (rgb),
     .colour (colour)
     );
 
endmodule 
