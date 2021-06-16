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
    reg [1:0] vector = {heating, cooling};
    reg [1:0] vector_exp  = {heating_exp, cooling_exp};
    

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
       direction = heating_exp == 1? 1:0;

       forever begin
         #CLK_PERIOD;
	temp = temp <= 30? temp - 1: temp + 1;
	temp = temp <= 15? temp +1: temp - 1;

vector_exp = (temp <= 5'd18) | ((temp < 20) & direction) ? 2'b00 :(temp >= 5'd22) | ((temp > 20) & !direction) ? 2'b10:2'b01;
		
if(vector_exp != vector)
          		begin 
	    		$display("***TEST FAILED! colour tansition error when button on");
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


//Todo: Instantiate counter module
 AC top(
     .clk (clk),
     .temp (temp),
     .heating (heating),
     .cooling (cooling)
     );
 
endmodule 

