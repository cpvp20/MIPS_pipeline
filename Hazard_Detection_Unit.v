//control hazard - fix: FLUSHING: an instruction in the pipeline is replaced with a NOP
//data hazard - 2 fixes: forwarding (in fwd unit) and STALLING for load-use data hazards...
//since we need to wait until the data is out from the data memory (RAM)
module Hazard_Detection_Unit
(
	input Branch,
	input Jump,
	input MemRead_signal_EX,
	input [4:0] rt_EX,
	input [4:0] rs_ID,
	input [4:0] rt_ID,

	output reg PCWrite,
	output reg IF_ID_RegWrite,
	output reg Flush,	
	output reg Stall	
);

	always@(*) 
		begin
			if (MemRead_signal_EX && ((rt_EX == rs_ID) || (rt_EX == rt_ID)))
			begin
				Stall <= 1;
				PCWrite <= 0;
				IF_ID_RegWrite <= 0;
			end
			else
			begin
				Stall <= 0;
				PCWrite <= 1;
				IF_ID_RegWrite <= 1;
			end
			Flush <= (Branch | Jump);	//omg control hazard
			
		end//always
	
endmodule
