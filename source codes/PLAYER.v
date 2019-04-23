// 顶层设计
module PLAYER (
	input ext_clk_25m,		// 25MHz 频率信号
	input ext_rst_n,			// 复位信号 
	input[3:0] key_v,			// 4个列按键输入	
	output reg[7:0] led,	   // 高八度LED指示
	output[3:0] dtube_cs_n,	// 7段数码管位选信号
	output[7:0] dtube_data,	// 7段数码管段选信号
	output spk_kk,
	output[3:0] key_h,		// 4个行按键输出
);


wire clk_1m;					// 1MHz
wire clk_2k;					// 2KHz
wire clk_4;						// 4Hz
wire[3:0] code;				// 简谱码显示
wire[7:0] rom_addr;			// ROM 地址
wire[3:0] inx;					// ROM 获取的音符
wire[10:0] tn;					// 音符对应的分频预置数					
wire spks;
wire high;						// 高八度LED指示
reg d;

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
	.CNT8 ( rom_addr )
	);	
	
// 乐谱码
MUSIC	MUSIC_inst (
	.address ( rom_addr ),
	.clock ( clk_4 ),
	.q ( inx )
	);

F_CODE F_CODE_inst (
	.INX ( inx ),				// 从 ROM 获取的音符
	.CODE ( code ),			// ROM 获取的音符
	.H ( high ),				// 高八度指示
	.TO ( tn )					// 音符对应的分频预置数
	);
	

// 8-34 数控分频模块实例	
SPKER SPKER_inst (
	.CLK ( clk_1m ),
	.TN ( tn ),
	.SPKS( spks )
	);
	
// 蜂鸣器驱动电路
DFF1 DFF1_inst (
	.CLK ( spks ),
	.D ( d ),
	.Q ( spk_kk )
	);
	
always @ (spk_kk)
	d <= ~spk_kk;

//-----------------------------------------------------------
seg7 uut_seg7(
	.clk(ext_clk_25m),
	.rst_n(ext_rst_n),
	.display_num(code),
	.dtube_cs_n(dtube_cs_n),
	.dtube_data(dtube_data)
);
	
//-----------------------------------------------------------
always @ (high)
	if (high == 1'b0)		led <= 8'b0000_0000;
	else 						led <= 8'b1111_1111;

endmodule 