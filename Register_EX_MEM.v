module Register_EX_MEM
(
	//classic
	input clk,
	input reset,
	input  [31:0] ReadData2_input,
	input  [4:0] WriteRegister_input,
	input  [31:0] PC_input,
	input  [31:0] ALUResult_input,
	input zero_input,
	//control signals	
   input Jr_input,
   input Jal_input,
   input Jump_input,
	input BranchEQ_input,
	input BranchNE_input,
	input MemRead_input,
	input MemToReg_input,
	input MemWrite_input,
	input RegWrite_input,
	
	//classic
	output reg  [31:0] PC_output,
	output reg  [31:0] ReadData2_output,
	output reg  [4:0] WriteRegister_output,
	output reg  [31:0] ALUResult_output,
	output reg zero_output,
	//control signals	
   output reg Jr_output,
   output reg Jal_output,
   output reg Jump_output,
	output reg BranchEQ_output,
	output reg BranchNE_output,
	output reg MemRead_output,
	output reg MemToReg_output,
	output reg MemWrite_output,
	output reg RegWrite_output
);

always@(negedge reset or posedge clk) begin
	if(reset==0)
		begin		
			PC_output  <= 0;
			ReadData2_output <= 0;
			WriteRegister_output <= 0;
			ALUResult_output <= 0;
			zero_output <= 0;
			Jr_output <= 0;
			Jal_output <= 0;
			Jump_output <= 0;
			BranchEQ_output <= 0;
			BranchNE_output <= 0;
			MemRead_output <= 0;
			MemToReg_output <= 0;
			MemWrite_output <= 0;
			RegWrite_output <= 0;
		end
	else 
		begin
			PC_output  <= PC_input;
			WriteRegister_output <= WriteRegister_input;
			ALUResult_output <= ALUResult_input;
			zero_output <= zero_input;
			Jr_output <= Jr_input;
			Jal_output <= Jal_input;
			Jump_output <= Jump_input;
			BranchEQ_output <= BranchEQ_input;
			BranchNE_output <= BranchNE_input;
			MemRead_output <= MemRead_input;
			MemToReg_output <= MemToReg_input;
			MemWrite_output <= MemWrite_input;
			RegWrite_output <= RegWrite_input;

		end
end

endmodule
//register//