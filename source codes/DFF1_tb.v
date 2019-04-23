`timescale 1ns/1ps
module DFF1_tb;
	reg clk;
	wire q;
	DFF1 dff(clk, q);
	initial begin
		clk = 1'b0;
	end
	
	always 
	#10 clk = ~ clk;

endmodule 