// 顶层设计
module MUSIC_PLAY_CIRCUIT (
	input ext_clk_25m,		// 25MHz 频率信号
	input ext_rst_n,			// 复位信号 
	input[3:0] key_v,			// 4个列按键输入
	input[3:0] switch,		// 4个拨码开关输入	
//	output reg[7:0] led,	   // 高八度LED指示
	output[3:0] dtube_cs_n,	// 7段数码管位选信号
	output[7:0] dtube_data,	// 7段数码管段选信号
	output spk_kk,				//	蜂鸣器信号
	output[3:0] key_h			// 4个行按键输出
);

// ----------------------------------------------------------- 
wire[3:0] inx;
wire clk_1m;					// 1MHz
wire[3:0] state;
wire[3:0] rom_code;
wire[3:0] keybord_code;
assign inx = (state == 4'b0001)?rom_code:keybord_code;	// 根据当前状态选择乐谱来源(ROM/电子琴)

wire[9:0] end_addr;			// ROM 终止地址
wire[9:0] start_addr;		// ROM 起始地址

// ----------------------------------------------------------- 
// 从 ROM 读取乐谱
FETCH_MUSIC	FETCH_MUSIC_inst(
	.ext_clk_25m( ext_clk_25m ),		// 25MHz 频率信号
	.ext_rst_n( ext_rst_n ),			// 复位信号 
//	.switch( switch ),					// 4个拨码开关输入
	.end_addr( end_addr ),
	.start_addr( start_addr ),
	.clk_1m( clk_1m ),
	.rom_code( rom_code )				// ROM 的乐谱码

);

// ----------------------------------------------------------- 
ELECTRONIC_KEYBOARD	ELECTRONIC_KEYBOARD_inst(
	.ext_clk_25m( ext_clk_25m ),		// 25MHz 频率信号
	.ext_rst_n( ext_rst_n ),			// 复位信号 
	.key_v( key_v ),			 			// 4个列按键输入
	.key_h( key_h ),		 				// 4个行按键输出
	.keybord_code(keybord_code) 		// 电子琴按键值
);


// ----------------------------------------------------------- 
PLAYER PLAYER_inst(
	.ext_clk_25m( ext_clk_25m ),		// 25MHz 频率信号
	.ext_rst_n( ext_rst_n ),			// 复位信号 
//	.signal_select(  ),				   // 信号选择，0--选择ROM，1--选择电子琴	
	.clk_1m(clk_1m),						// 输入时钟
	.audio_code(inx), 					// 输入的音频编码
//	.led(),							// 高八度LED指示
	.dtube_cs_n( dtube_cs_n ),			// 7段数码管位选信号
	.dtube_data( dtube_data ),			// 7段数码管段选信号
	.beep(spk_kk)							//	蜂鸣器信号
);

// ----------------------------------------------------------- 
STATE_CONTROL STATE_CONTROL_inst(
	.clk(ext_clk_25m),			// 时钟信号
	.rst_n(ext_rst_n),			// 复位信号
	.switch(switch),				// 四个按键信号
	.cstate(state),				// 状态
	.end_addr( end_addr ),		// ROM 终止地址
	.start_addr( start_addr )	// ROM 起始地址
);
endmodule 