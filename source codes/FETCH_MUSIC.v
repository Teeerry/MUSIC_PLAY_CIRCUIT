// 从 ROM 读取乐谱
module FETCH_MUSIC(
	input ext_clk_25m,		// 25MHz 频率信号
	input ext_rst_n,			// 复位信号 
//	input[3:0] switch,		// 4个拨码开关输入	
	input[9:0] end_addr,		// ROM 终止地址
	input[9:0] start_addr,	// ROM 起始地址
	output clk_1m,				// 1MHz
	output[3:0] rom_code		// ROM 的乐谱码

);

//-----------------------------------------------------------			
wire clk_2k;					// 2KHz
wire clk_4;						// 4Hz
wire[3:0] code;				// 简谱码显示
wire[9:0] rom_addr;			// ROM 地址
wire[3:0] state;				// 当前状态
//-----------------------------------------------------------

PLL25	PLL25_inst (
	.areset ( !ext_rst_n ),
	.inclk0 ( ext_clk_25m ),
	.c0 ( clk_1m ),
	.c1 ( clk_2k )
	);

// 分频电路实例
FDIV FDIV_inst (
	.CLK ( clk_2k ),
	.PM ( clk_4 )
	);


// 乐曲长度控制计数器， 4Hz 控制音乐的节拍
CNT138T CNT138T_inst (
	.CLK ( clk_4 ),
	.STATE( state ),
	.end_addr( end_addr ),
	.start_addr( start_addr ),
	.CNT8 ( rom_addr )
	);	
	
// 乐谱码ROM
MUSIC	MUSIC_inst (
	.address ( rom_addr ),
	.clock ( clk_4 ),
	.q ( rom_code )
	);
	

endmodule 