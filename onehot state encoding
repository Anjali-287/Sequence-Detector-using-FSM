`timescale 1ns / 1ps


module onehot_encoding(
	input in, clk, reset,
	output reg mealy_out
);

	parameter [3:0]MEALY_IDLE=0,
	MEALY_A=1,
	MEALY_B=2,
	MEALY_C=3;

	reg [3:0]mealy_ps,mealy_ns;

	//Sequential always block
	always @(posedge clk or negedge reset)
		if(!reset) begin
			mealy_ps <= 4'b0;
			mealy_ps[MEALY_IDLE] <= 1'b1;
			end
		else
			mealy_ps <= mealy_ns;	

	//Combinational always block-Mealy
	always @(mealy_ps,in)
		begin
		mealy_ns = 4'b0;   //crux-here we cant leave the else part coz we have to initilaize ns by 0000 or else 0011 will 
		mealy_out = 1'b0;                                           //also come in output
		case (1'b1)			
		   mealy_ps[MEALY_IDLE]: if(in)
			                      mealy_ns[MEALY_A] = 1'b1;
										 else
										 mealy_ns = mealy_ps;
			mealy_ps[MEALY_A]:    if(in)
			                      mealy_ns[MEALY_B] = 1'b1;
			                      else
			                      mealy_ns[MEALY_IDLE] = 1'b1;
			mealy_ps[MEALY_B]:    if(~in)
			                      mealy_ns[MEALY_C] = 1'b1;
										 else
										 mealy_ns = mealy_ps;
			mealy_ps[MEALY_C]:    if(in) 
			                      begin
			                      mealy_ns[MEALY_A] = 1'b1;
			                      mealy_out = 1'b1;
			                      end
			                      else
			                      mealy_ns[MEALY_IDLE] = 1'b1;
		endcase
		end

endmodule
