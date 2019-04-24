`timescale 1ns/1ps
module CNT138T_tb;

reg clk_4;
reg[3:0] state;			// 当前状态
reg[9:0] end_addr;
reg[9:0] start_addr;

wire[9:0] rom_addr;		// ROM 地址

reg clk;

// 乐曲长度控制计数器， 4Hz 控制音乐的节拍
CNT138T CNT138T_inst (
	.CLK ( clk_4 ),
	.STATE( state ),
	.end_addr( end_addr ),
	.start_addr( start_addr ),
	.CNT8 ( rom_addr )
	);

	initial begin
		clk = 1'b0;				// 初始化时钟
		clk_4 = 1'b0;			// 初始化时钟
		state = 4'b0001;		// 初始化状态
		start_addr = 10'd0;	// 初始化起始地址
		end_addr = 10'd138;	// 初始化终止地址
	end
	
	always 
	#5 clk_4 = ~clk_4; 		//	计数节拍时钟
	
	always 
	#100 clk = ~clk; 			// 状态切换时钟
	
	// 同步更改状态和地址,测试状态 STATE1, STATE2
	always @ (posedge clk) begin
		if (state >= 4'd2) begin 
			state <= 4'd1;
			start_addr <= 10'd0;
			end_addr <= 10'd138;
			end 
		else begin
			state <= state + 1'b1;
			start_addr <= 10'd139;
			end_addr <= 10'd335;
			end 
	end 
	
endmodule 