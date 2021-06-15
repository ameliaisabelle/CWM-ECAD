//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Amelia Carse
// Date: 15/06/21
//
// Description: A testbench module to test Ex5 - Air Conditioning
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
    reg[4:0] temp;
    wire heating;
    wire cooling;
reg heating_exp;
reg cooling_exp;
   
    
reg [1:0] state;
	
assign heating = (state == 2'b00);
assign cooling = (state == 2'b10);

//Todo: Clock generation
  initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

//Todo: User logic
initial begin
       heating_exp = 1;
       cooling_exp= 0;
       err=0;
       temp = 5'd18;


       forever begin
         #CLK_PERIOD;
	temp = temp <= 30? temp - 1: temp + 1;
	temp = temp <= 15? temp +1: temp - 1;

		case (state)
		0: if ((temp < 20)&&(state != 0))begin 
	    					$display("***TEST FAILED!0.1");
             					err=1;
						end
		 else if ((temp >= 20)&&(state != 1))begin 
	    					$display("***TEST FAILED!0.2");
             					err=1;
						end
		1: if ((temp <= 18 )&&(state != 0))begin 
	    					$display("***TEST FAILED!1.1");
             					err=1;
						end
		   else if ((temp < 22)&&( temp > 18)&&(state != 1))begin 
	    					$display("***TEST FAILED!1.2");
             					err=1;
						end
		   else if ((temp >= 22)&&(state != 2))begin 
	    					$display("***TEST FAILED!1.3");
             					err=1;
						end
		2: if ((temp <= 20)&&(state != 1))begin 
	    					$display("***TEST FAILED!2.1");
             					err=1;
						end 
		   else if ((temp > 20)&&(state != 2))begin 
	    					$display("***TEST FAILED!2.2");
             					err=1;
						end
		endcase
	

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
 AC top(
     .clk (clk),
     .temp (temp),
     .heating (heating),
     .cooling (cooling)
     );
 
endmodule 

