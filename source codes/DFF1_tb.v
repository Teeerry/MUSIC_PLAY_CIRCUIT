`timescale 1ns/1ps
module DFF1_TB;
	reg clk;
	reg d;
	wire q;
	DFF1 dff(clk, d, q);
	initial begin
		clk = 1'b0;
		d = 1'b0;
	end
	
	always 
	#10 clk = ~ clk;
	
	always 
	#40 d = ~ d;

endmodule 