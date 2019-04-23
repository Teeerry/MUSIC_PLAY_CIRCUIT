`timescale 1ns/1ps
module SPKER_tb;

reg[3:0] inx;
wire[3:0] code;
wire[10:0] tn;
wire high;
reg clk;

reg clk_1m;
wire spks;

F_CODE U1(
	.INX ( inx ),				// 从 ROM 获取的音符
	.CODE ( code ),			// ROM 获取的音符
	.H ( high ),				// 高八度指示
	.TO ( tn )					// 音符对应的分频预置数
	);
 
SPKER U2(
	.CLK( clk_1m ),
	.TN ( tn ),
	.SPKS( spks )
	);

initial begin
	inx = 4'b0000;
	clk = 1'b0;
	clk_1m = 1'b0;
	end

always 
	#4000 clk = ~ clk;

always 
	#0.001 clk_1m = ~ clk_1m;
	
always @ (posedge clk)
	if (inx <= 4'b1111)  inx <= inx + 1'b1;
	else inx = 4'd0000;
	
endmodule 