// 解码输入的音乐谱，并且通过蜂鸣器播放
// 音乐编码来源：ROM/电子琴

module PLAYER (
	input ext_clk_25m,		// 25MHz 频率信号
	input ext_rst_n,			// 复位信号 
//	input signal_select,		// 信号选择，0--选择ROM，1--选择电子琴	
	input clk_1m,				// 输入时钟
	input[3:0] audio_code, 	// 输入的音频编码
//	output reg[7:0] led,		// 高八度LED指示
	output[3:0] dtube_cs_n,	// 7段数码管位选信号
	output[7:0] dtube_data,	// 7段数码管段选信号
	output beep				//	蜂鸣器信号

);

// -------------------------------------------------------
wire[3:0] code;
wire[10:0] tn;					// 音符对应的分频预置数					
wire spks;						// 蜂鸣器驱动电路输入时钟
wire high;						// 高八度LED指示
reg d;							// 蜂鸣器输入信号
				
// -------------------------------------------------------

F_CODE F_CODE_inst (
	.INX ( audio_code ),					// 获取的音符数据(ROM/电子琴输入)
	.CODE ( code ),						// 音符所对应实际的音符(输出)
	.H ( high ),							// 高八度指示(输出)
	.TO ( tn )								// 音符对应的分频预置数(输出)
	);
	
// -------------------------------------------------------
// 数控分频模块实例	
SPKER SPKER_inst (
	.CLK ( clk_1m ),
	.TN ( tn ),
	.SPKS( spks )				// (输出)
	);
	
// 蜂鸣器驱动电路
DFF1 DFF1_inst (
	.CLK ( spks ),
	.D ( d ),
	.Q ( beep )					// (输出)
	);
	
always @ (beep)
	d <= ~beep;

// 数码管显示
seg7 uut_seg7(
	.clk(ext_clk_25m),
	.rst_n(ext_rst_n),
	.display_num(code),
	.dtube_cs_n(dtube_cs_n),		// (输出)
	.dtube_data(dtube_data)			// (输出)
);
	
//// 高八度 LED 指示(高八度则全亮)
//always @ (high)
//	if (high == 1'b0)		led <= 8'b0000_0000;
//	else 						led <= 8'b1111_1111;
endmodule 