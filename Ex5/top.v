//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name:Amelia Carse
// Date: 16/06/21
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module AC (
    input clk,
    input [4:0] temp,
    output heating,
    output cooling

    );

reg [1:0] state;
	
assign heating = (state == 2'b00);
assign cooling = (state == 2'b10);


always @ (posedge clk) begin

	case (state)
	default: state <= 1;
	0: state <= temp < 20? 0: 1;
	1: state <= temp >= 22? 2: temp <= 18? 0: 1; 
	2: state <= temp > 20? 2: 1;
	endcase

end
endmodule
       
