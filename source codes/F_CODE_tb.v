`timescale 1ns/1ps
module F_CODE_tb;

reg[3:0] inx;
wire[3:0] code;
wire[10:0] tn;

wire high;
reg clk;
 
F_CODE U1(
	.INX ( inx ),				// 从 ROM 获取的音符
	.CODE ( code ),			// ROM 获取的音符
	.H ( high ),				// 高八度指示
	.TO ( tn )					// 音符对应的分频预置数
	);

initial begin
	inx = 4'b0000;
	clk = 1'b0;
	end

always 
	#10 clk = ~ clk;
	
always @ (posedge clk)
	if (inx <= 4'b1111)  inx <= inx + 1'b1;
	else inx = 4'd0000;
	
endmodule 