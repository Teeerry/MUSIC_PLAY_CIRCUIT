// 8-37
/*module CNT138T (CLK, STATE, CNT8);
	input CLK;
	input[3:0] STATE;			// 当前状态
	output[9:0] CNT8;
	
	reg[9:0] CNT;
	wire LD;
	wire[9:0] end_addr;
	wire[9:0] start_addr;

	always @ (posedge CLK or posedge LD) begin
		if      (LD) CNT <= start_addr;
		else 	  CNT <= CNT + 1'b1;
	end
	assign end_addr   = (STATE==4'b0001)? 10'd138 : 10'd335;
	assign start_addr = (STATE==4'b0001)? 10'd0 : 10'd139;
	assign CNT8 = CNT;
	assign LD = (CNT == end_addr);
	
endmodule */

module CNT138T (CLK, STATE, CNT8);
	input CLK;
   input[3:0] STATE;			// 当前状态
	output[9:0] CNT8;
	reg[9:0] CNT;

	always @ (posedge CLK) begin
		if      (STATE==4'd1 && CNT==10'd138) begin CNT <= 10'd0; end
		else if (STATE==4'd2 && CNT==10'd335) begin CNT <= 10'd139; end
		else begin CNT <= CNT + 1'b1; end
	end

	assign CNT8 = CNT;

endmodule 