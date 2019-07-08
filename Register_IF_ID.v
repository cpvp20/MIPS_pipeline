module Register_IF_ID
(
	input clk,
	input reset,
	//input enable,
	input  [31:0] PC4_input,
	input  [31:0] Instruction_input,
	
	output reg [31:0] PC4_output,
	output reg [31:0] Instruction_output
);

always@(negedge reset or posedge clk) begin
	if(reset==0)
		begin
			PC4_output <= 0;
			Instruction_output <= 0;
		end
	else
		begin
			PC4_output <= PC4_input;
			Instruction_output <= Instruction_input;
		end
end

endmodule
//register//