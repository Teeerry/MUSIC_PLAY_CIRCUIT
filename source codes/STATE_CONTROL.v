// 状态控制模块
module STATE_CONTROL (
	input clk,						//	时钟信号
	input rst_n,					// 复位信号
	input [3:0] switch,			// 分别对应{SW6，SW5，SW4，SW3}
	output reg[3:0] cstate,		// 当前状态
	output reg[9:0] end_addr,		// ROM 终止地址
	output reg[9:0] start_addr		// ROM 起始地址
	);
	
	parameter K1 = 4'b0001;//1 排列顺序与板子上位置相反 SW3
	parameter K2 = 4'b0010;//2		SW4
	parameter STATE1 = 4'b0001;	//
	parameter STATE2 = 4'b0010;	//
	parameter STATE3 = 4'b0011;	//
	
	reg[3:0] nstate;					// 下一个状态
	
	// 状态切换
   always @ (posedge clk or negedge rst_n) begin
		if(!rst_n)	cstate <= STATE1;
		else			cstate <= nstate;
	end 
	//	状态转换
	always @ (cstate or switch) begin
		case(cstate)
			STATE1: if 	(switch == K1)  nstate <= STATE3;
				 else if(switch == K2)	 nstate <= STATE2;
				 else nstate <= STATE1;
			STATE2: if  (switch == K2)  nstate <= STATE1;
				 else if (switch == K1)  nstate <= STATE3;
				 else nstate <= STATE2;
			STATE3:if  (switch == K1)   nstate <= STATE1;
				 else if (switch == K2)  nstate <= STATE2;
				 else nstate <= STATE3;
			default: nstate <= STATE1;
		endcase
	end
	//	不同状态的输出
	always @ (cstate or switch) begin
		case(cstate)
			STATE1: begin end_addr = 10'd138; start_addr = 10'd0;		end
			STATE2: begin end_addr = 10'd335; start_addr = 10'd139;	end
			STATE3: begin end_addr = 10'd138; start_addr = 10'd0;		end //.......
			default: begin end_addr = 10'd138; start_addr = 10'd0;	end //.......
		endcase	
	end
	
endmodule 