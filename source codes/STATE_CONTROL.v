
module STATE_CONTROL (
	input clk,
	input rst_n,
	input [3:0] switch,
	output reg[3:0] cstate		// 当前状态
	);
	
	parameter K1 = 4'b1000;
	parameter K2 = 4'b0100;	
	parameter STATE1 = 4'b0001;	
	parameter STATE2 = 4'b0010;	
	parameter STATE3 = 4'b0011;	
	
	reg[3:0] nstate;
	
	// 状态切换
   always @ (posedge clk or negedge rst_n) begin
		if(!rst_n)	cstate <= STATE1;
		else			cstate <= nstate;
	end 
	//
	always @ (posedge clk or negedge rst_n) begin
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
	
endmodule 