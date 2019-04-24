// 8-37 计数器产生ROM地址
module CNT138T (CLK, STATE, end_addr, start_addr, CNT8);
	input CLK;
	input[3:0] STATE;			// 当前状态
	input[9:0] end_addr;		//	ROM 终止地址
	input[9:0] start_addr;	// ROM 起始地址
	output[9:0] CNT8;			// 输出计数器产生的地址

	// ---------------------------------------------------------
	reg[9:0] CNT;						 // 计数器
	reg LD = 1'b1;						 // 更新起始地址的标志
	reg[3:0] pre_state = 4'b0001;	 // 前一个状态，默认为STATE1
	
	// ---------------------------------------------------------
	// 计数器加一
	always @ (posedge CLK or posedge LD) begin
		if( LD )	CNT <= start_addr;							// 更新为新的状态的起始地址
		else if ( CNT >= end_addr ) CNT <= start_addr;	// 更新为当前状态的起始地址
		else 	  CNT <= CNT + 1'b1;								// ROM 地址加一
	end
	
	
	// 设置更新地址标志
	always @ (STATE or CLK or start_addr or end_addr or pre_state) begin
		if (pre_state != STATE) begin 	//	如果状态发生改变，则加载新地址
			LD <=  1'b1;
			pre_state <= STATE;				//	更新状态
			end 
		else 	LD <=  1'b0;					// 否则，输出地址加一
	end 
	
	assign CNT8 = CNT;
endmodule 