// 8-35 为 SPEAKER 模块提供决定所发音符的分频预置数
module F_CODE (INX, KEYVALUE, STATE, CODE, H, TO);
	input[3:0] INX;			// 从 ROM 获取的音符
	input[3:0] KEYVALUE;		//	电子琴矩阵输入
	input[3:0] STATE;			// 当前状态
	output[3:0] CODE;			// ROM 表示的音符所对应实际的音符 
	output H;					// H = 1， 表示高八度
	output[10:0] TO;			// 输入音符的对应频率
	
	reg[10:0] TO;
	reg[3:0] CODE;
	reg H;
	reg[3:0] INPUT_FOR_CODE;
	
	always @ (INX or KEYVALUE or STATE) begin 
		if (STATE == 4'b0011)	INPUT_FOR_CODE = KEYVALUE; // 从键盘获取数据
		else 							INPUT_FOR_CODE = INX;		// 从ROM读取数据
		case (INPUT_FOR_CODE)
			0  : begin TO <= 11'H7FF; CODE <= 0; H <= 0; end
			1  : begin TO <= 11'H305; CODE <= 1; H <= 0; end
			2  : begin TO <= 11'H390; CODE <= 2; H <= 0; end
			3  : begin TO <= 11'H40C; CODE <= 3; H <= 0; end
			4  : begin TO <= 11'H45C; CODE <= 4; H <= 0; end
			5  : begin TO <= 11'H4AD; CODE <= 5; H <= 0; end
			6  : begin TO <= 11'H50A; CODE <= 6; H <= 0; end
			7  : begin TO <= 11'H55C; CODE <= 7; H <= 0; end
			8  : begin TO <= 11'H582; CODE <= 1; H <= 1; end
			9  : begin TO <= 11'H5C8; CODE <= 2; H <= 1; end
			10 : begin TO <= 11'H606; CODE <= 3; H <= 1; end
			11 : begin TO <= 11'H640; CODE <= 4; H <= 1; end
			12 : begin TO <= 11'H656; CODE <= 5; H <= 1; end
			13 : begin TO <= 11'H684; CODE <= 6; H <= 1; end
			14 : begin TO <= 11'H69A; CODE <= 7; H <= 1; end
			15 : begin TO <= 11'H6C0; CODE <= 1; H <= 1; end
			default : begin TO <= 11'H6C0; CODE <= 1; H <= 1; end
		endcase
	end
endmodule 