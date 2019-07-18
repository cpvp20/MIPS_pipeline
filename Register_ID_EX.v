module Register_ID_EX
(
	//classic
	input clk,
	input reset,
	input  [31:0] PC4_input,
	input  [31:0] ReadData1_input,
	input  [31:0] ReadData2_input,
	//control signals	
   input Jal_input,
	input RegDst_input,	
	input BranchEQ_input,
	input BranchNE_input,
	input MemRead_input,
	input MemToReg_input,
	input MemWrite_input,
	input ALUSrc_input,
	input RegWrite_input,
	input [3:0] ALUOp_input,
	input [5:0] funct_input, 
	//instruction
	input  [31:0] ImmediateExtend_input,
	input  [4:0] rs_input,
	input  [4:0] rt_input,
	input  [4:0] rd_input,
	input  [4:0] shamt_input,
	
	//classic
	output reg [31:0] PC4_output,
	output reg [31:0] ReadData1_output,
	output reg [31:0] ReadData2_output,
	//control signals	
   output reg Jal_output,
	output reg RegDst_output,	
	output reg BranchEQ_output,
	output reg BranchNE_output,
	output reg MemRead_output,
	output reg MemToReg_output,
	output reg MemWrite_output,
	output reg ALUSrc_output,
	output reg RegWrite_output,
	output reg [3:0]ALUOp_output,
	output reg [5:0] funct_output, 
	//instruction
	output reg [31:0] ImmediateExtend_output,
	output reg [4:0] rs_output,
	output reg [4:0] rt_output,
	output reg [4:0] rd_output,
	output reg [4:0] shamt_output

);

always@(negedge reset or posedge clk) begin
	if(reset==0)
		begin		
			PC4_output  <= 0;
			ReadData1_output <= 0;
			ReadData2_output <= 0;
			Jal_output <= 0;
			RegDst_output <= 0;	
			BranchEQ_output <= 0;
			BranchNE_output <= 0;
			MemRead_output <= 0;
			MemToReg_output <= 0;
			MemWrite_output <= 0;
			ALUSrc_output <= 0;
			RegWrite_output <= 0;
			ALUOp_output <= 0;
			funct_output <= 0; 
			ImmediateExtend_output <= 0;
			rs_output <= 0;
			rt_output <= 0;
			rd_output <= 0;
			shamt_output <= 0;
		end
	else 
		begin
			PC4_output  <= PC4_input;
			ReadData1_output <= ReadData1_input;
			ReadData2_output <= ReadData2_input;
			Jal_output <= Jal_input;
			RegDst_output <= RegDst_input;	
			BranchEQ_output <= BranchEQ_input;
			BranchNE_output <= BranchNE_input;
			MemRead_output <= MemRead_input;
			MemToReg_output <= MemToReg_input;
			MemWrite_output <= MemWrite_input;
			ALUSrc_output <= ALUSrc_input;
			RegWrite_output <= RegWrite_input;
			ALUOp_output <= ALUOp_input;
			funct_output <= funct_input; 
			ImmediateExtend_output <= ImmediateExtend_input;
			rs_output <= rs_input;
			rt_output <= rt_input;
			rd_output <= rd_input;
			shamt_output <= shamt_input;
		end
end

endmodule
//register//