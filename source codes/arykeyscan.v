/**
该模块实现矩阵按钮的检测
输入4个按键接口信号key_v和key_h
输出键值display_num
*/
module arykeyscan(
	input clk,								// 外部输入时钟信号
	input rst_n,							// 外部复位信号，低电平有效
	input[3:0] key_v,						// 4个列按键输入
	output reg[3:0] key_h,				// 4个行按键输出
	output reg[15:0] display_num	 	// 数码管显示数据
//	output keep_press						// 矩阵按钮长按标志
);
//-----------------------------------------------------------
wire[3:0] keyv_value;		// 列按键按下键值,高电平有效
wire keydown ;			//有按键被按下			
wire keyup ;			//有按键被释放

sigkeyscan uut_sigkeyscan(
	.clk(clk),
	.rst_n(rst_n),
	.key_v(key_v),
	.keyv_value(keyv_value),
	.key_neg(keydown),
	.key_pos(keyup)
);

//-----------------------------------------------------------
reg[3:0] nstate, cstate;
parameter K_IDLE  = 4'd0;		// 空闲等待
parameter K_H1OL  = 4'd1;		// Key_h[0]拉低
parameter K_H2OL  = 4'd2;		// Key_h[1]拉低
parameter K_H3OL  = 4'd3;		// Key_h[2]拉低
parameter K_H4OL  = 4'd4;		// Key_h[3]拉低
parameter K_CHCK  = 4'd5;

// 状态切换
always @ (posedge clk or negedge rst_n)
	if(!rst_n)	cstate <= K_IDLE;
	else			cstate <= nstate;

always @ (posedge clk or negedge rst_n)
	case(cstate)
		K_IDLE:	if(keyv_value != 4'b0000)	nstate <= K_H1OL;
					else 	nstate <= K_IDLE;
		K_H1OL:	nstate <= K_H2OL;
		K_H2OL:	if(key_v!= 4'b1111)	nstate <= K_IDLE;
					else 	nstate <= K_H3OL;
		K_H3OL:	if(key_v!= 4'b1111)	nstate <= K_IDLE;
					else 	nstate <= K_H4OL;
		K_H4OL:	if(key_v!= 4'b1111)	nstate <= K_IDLE;
					else 	nstate <= K_CHCK;
		K_CHCK:	nstate <= K_IDLE;
		default: ;
	endcase

//----------------------------------------------------------------
// 采样键值
reg[3:0] new_value;		// 新采样的数据
reg new_rdy = 1'b0;		// 采样数据有效标志

always @ (posedge clk or negedge rst_n)
	if(!rst_n) begin
		key_h <= 4'b0000;
		new_value <= 4'd0;
		new_rdy <= 1'b0;
	end
	else begin
		case(cstate)
			K_IDLE:	begin	
					key_h <= 4'b0000;
					new_value <= 4'd0;
					new_rdy <= 1'b0;
				end	
			K_H1OL:	begin	
					key_h <= 4'b1110;
					new_value <= 4'd0;
					new_rdy <= 1'b0;
				end
			K_H2OL:	begin 
					case(key_v)
						4'b1110:  begin
								key_h <= 4'b0000;
								new_value <= 4'd0;
								new_rdy <= 1'b1;
							end
						4'b1101:  begin
								key_h <= 4'b0000;
								new_value <= 4'd1;
								new_rdy <= 1'b1;
							end
						4'b1011:  begin
								key_h <= 4'b0000;
								new_value <= 4'd2;
								new_rdy <= 1'b1;
							end
						4'b0111:  begin
								key_h <= 4'b0000;
								new_value <= 4'd3;
								new_rdy <= 1'b1;
							end
						default:  begin
								key_h <= 4'b1101;
								new_value <= 4'd0;
								new_rdy <= 1'b0;
							end
					endcase
				end
			K_H3OL:	begin 
					case(key_v)
						4'b1110:  begin
								key_h <= 4'b0000;
								new_value <= 4'd4;
								new_rdy <= 1'b1;
							end
						4'b1101:  begin
								key_h <= 4'b0000;
								new_value <= 4'd5;
								new_rdy <= 1'b1;
							end
						4'b1011:  begin
								key_h <= 4'b0000;
								new_value <= 4'd6;
								new_rdy <= 1'b1;
							end
						4'b0111:  begin
								key_h <= 4'b0000;
								new_value <= 4'd7;
								new_rdy <= 1'b1;
							end
						default:  begin
								key_h <= 4'b1011;
								new_value <= 4'd0;
								new_rdy <= 1'b0;
							end
					endcase
				end
			K_H4OL:	begin 
					case(key_v)
						4'b1110:  begin
								key_h <= 4'b0000;
								new_value <= 4'd8;
								new_rdy <= 1'b1;
							end
						4'b1101:  begin
								key_h <= 4'b0000;
								new_value <= 4'd9;
								new_rdy <= 1'b1;
							end
						4'b1011:  begin
								key_h <= 4'b0000;
								new_value <= 4'd10;
								new_rdy <= 1'b1;
							end
						4'b0111:  begin
								key_h <= 4'b0000;
								new_value <= 4'd11;
								new_rdy <= 1'b1;
							end
						default:  begin
								key_h <= 4'b0111;
								new_value <= 4'd0;
								new_rdy <= 1'b0;
							end
					endcase
				end
			K_CHCK:	begin 
					case(key_v)
						4'b1110:  begin
								key_h <= 4'b0000;
								new_value <= 4'd12;
								new_rdy <= 1'b1;
							end
						4'b1101:  begin
								key_h <= 4'b0000;
								new_value <= 4'd13;
								new_rdy <= 1'b1;
							end
						4'b1011:  begin
								key_h <= 4'b0000;
								new_value <= 4'd14;
								new_rdy <= 1'b1;
							end
						4'b0111:  begin
								key_h <= 4'b0000;
								new_value <= 4'd15;
								new_rdy <= 1'b1;
							end
						default:  begin
								key_h <= 4'b0000;
								new_value <= 4'd0;
								new_rdy <= 1'b0;
							end
					endcase
				end
			default: ;
		endcase
	end
		
//------------------------------------------------------------
// 产生新的键值
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n)	display_num <= 16'h0000;
	else if(new_rdy)	// 按下按键，更新键值
		begin
			display_num <= {display_num[11:0],new_value};
//			new_rdy = 1'b0;
		end	
//	if (rst_n && keyup)
//		new_rdy = 1'b0;
	end
endmodule
	
				
					