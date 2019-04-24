`timescale 1ns/1ps
module F_CODE_tb;

reg[3:0] inx;				// 从 ROM 获取的音符
reg[3:0] keyvalue;		//	电子琴矩阵输入
reg[3:0] state;			// 当前状态
wire[3:0] code;
wire[10:0] tn;

wire high;
reg clk1;
reg clk2;
 
F_CODE U1(
	.INX ( inx ),							// 从 ROM 获取的音符
	.KEYVALUE(keyvalue),					// 矩阵键盘输入.....
	.STATE(state),							// 当前状态.........
	.CODE ( code ),						// ROM 获取的音符
	.H ( high ),							// 高八度指示
	.TO ( tn )								// 音符对应的分频预置数
	);

initial begin
	inx = 4'b0000;
	clk1 = 1'b0;
	clk2 = 1'b0;
	state = 4'b0001;
	keyvalue = 4'b0000;
	end

always 
	#10 clk1 = ~ clk1;
always 
	#20 clk2 = ~ clk2;
	
always @ (posedge clk1)
	if (inx <= 4'b1111)  inx <= inx + 1'b1;
	else inx = 4'd0000;
	
always 
	#400 	state = 4'b0011;

always @ (posedge clk2 or state)
	if (state == 4'b0011 && keyvalue <= 4'b1111)  keyvalue <= keyvalue + 1'b1;
	else keyvalue = 4'd0000;
	
endmodule 