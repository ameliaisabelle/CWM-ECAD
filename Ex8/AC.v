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
    output reg heating,
    output reg cooling

    );

reg [1:0] state = 2'b00;


always @ (posedge clk) begin

	case (state)
	default: state <= 2'b00;
	0: begin
			if (temp >= 5'd22) begin 
				heating = 0;
				cooling = 1;
				state = 2'b01;
			end

	        else if(temp <= 5'd18) begin
				heating = 1;
				cooling = 0;
				state = 2'b10;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = 2'b00;
			end
			end
	1: begin	
			if(temp > 5'd20) begin
				heating = 0;
				cooling = 1;
				state = 2'b01;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = 2'b00;
			end
			end
	2: begin	
			if(temp < 5'd20) begin
				heating = 1;
				cooling = 0;
				state = 2'b10;
			end
			else begin
				heating = 0;
				cooling = 0;
				state = 2'b00;
			end
			end
	   endcase
	end
endmodule
