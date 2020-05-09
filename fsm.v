`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sequence 1101 detector - Mealy and Moore
//////////////////////////////////////////////////////////////////////////////////

module sequence_detector(
	input in, clk, reset,
	output reg mealy_out, moore_out
);

	parameter MEALY_IDLE=2'b00,
	MEALY_A=2'b01,
	MEALY_B=2'b10,
	MEALY_C=2'b11;

	parameter MOORE_IDLE=3'b000,
	MOORE_A=3'b001,
	MOORE_B=3'b010,
	MOORE_C=3'b011,
	MOORE_D=3'b100;

	reg [1:0]mealy_ps,mealy_ns;
	reg [2:0]moore_ps,moore_ns;

	//Sequential always block
	always @(posedge clk or negedge reset)
		if(!reset)
			begin
			mealy_ps <= MEALY_IDLE;
			moore_ps <= MOORE_IDLE;
			end
		else
			begin
			mealy_ps <= mealy_ns;
			moore_ps <= moore_ns;
			end	

	//Combinational always block-Mealy
	always @(mealy_ps,in)
		begin
		mealy_ns = mealy_ps;
		mealy_out = 1'b0;
		case (mealy_ps)
			MEALY_IDLE: if(in)
			  mealy_ns = MEALY_A;
			MEALY_A:    if(in)
			  mealy_ns = MEALY_B;
			  else
			  mealy_ns = MEALY_IDLE;
			MEALY_B:    if(~in)
			  mealy_ns = MEALY_C;
			MEALY_C:    if(in) 
			  begin
			  mealy_ns = MEALY_A;
			  mealy_out = 1'b1;
			  end
			  else
			  mealy_ns = MEALY_IDLE;
		endcase
		end

	//Combinational always block-Moore	
	always @(moore_ps,in)
		begin
		moore_ns = moore_ps;
		case(moore_ps)
			MOORE_IDLE: if(in)
			  moore_ns = MOORE_A;
			MOORE_A: if(in)
			  moore_ns = MOORE_B;
			  else
			  moore_ns = MOORE_IDLE;
			MOORE_B: if(~in)
			  moore_ns = MOORE_C;
			MOORE_C: if(in)
			  moore_ns = MOORE_D;
			  else
			  moore_ns = MOORE_IDLE;
			MOORE_D: if(in)
			  moore_ns = MOORE_B;
			  else
		    moore_ns = MOORE_IDLE;
		endcase
		end

	// Moore output
	always @(moore_ps)
		begin
		moore_out = 1'b0;
		case(moore_ps)
			MOORE_IDLE,MOORE_A,MOORE_B,MOORE_C:;
			MOORE_D: moore_out =1'b1;
		endcase
		end

endmodule
