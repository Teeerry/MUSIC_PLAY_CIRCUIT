// 电子琴实现模块
module ELECTRONIC_KEYBOARD(
	input ext_clk_25m,		 // 25MHz 频率信号
	input ext_rst_n,			 // 复位信号 
	input[3:0] key_v,			 // 4个列按键输入
	output[3:0] key_h,		 // 4个行按键输出
	output[15:0] keybord_code // 电子琴按键值
);


arykeyscan uut_arykeyscan(
	.clk(ext_clk_25m),
	.rst_n(ext_rst_n),
	.key_v(key_v),
	.key_h(key_h),						// (输出)
	.display_num(keybord_code)	// (输出)
);
endmodule 