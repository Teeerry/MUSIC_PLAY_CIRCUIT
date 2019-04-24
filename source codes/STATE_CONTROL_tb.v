`timescale 1ns/1ps
module STATE_CONTROL_tb;

	reg clk;
	reg rst_n;
	reg [3:0] switch;
	wire[3:0] cstate;			// 当前状态
	wire[9:0] end_addr;		// ROM 终止地址
	wire[9:0] start_addr;	// ROM 起始地址
	
	STATE_CONTROL U1(
	.clk(clk),
	.rst_n(rst_n),		// 复位信号
	.switch(switch),	// 四个按键信号
	.cstate(cstate),	// 状态
	.end_addr( end_addr ),		// ROM 终止地址
	.start_addr( start_addr )	// ROM 起始地址
);
	initial begin
		clk = 1'b0;
		switch = 4'b0000;	
		rst_n = 1'b0;
		#10 rst_n = 1'b1;
	end 
	
	always 
		#10 clk = ~clk;
		
	always @ (posedge clk) begin
		if (switch <= 4'b1111)  switch <= switch + 1'b1;
		else switch = 4'd0000;
	end
endmodule
	