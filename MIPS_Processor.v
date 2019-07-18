/******************************************************************
* Description
* This is the top-level of a MIPS processor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
******************************************************************/

module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 64
)
(
	input clk,
	input reset,
	input [7:0] PortIn,

	output [31:0] ALUResultOut,
	output [31:0] PortOut
);

assign  PortOut = 0;


//**********************		  CONTROL WIRES		********************************************/
wire Jr_signal;
wire Jal_signal;
wire Jump_signal;
wire RegDst_signal;
wire BranchNE_signal;
wire BranchEQ_signal;
wire MemWrite_signal;
wire MemToReg_signal;
wire ALUSrc_signal;
wire RegWrite_signal;
wire MemRead_signal;
wire [3:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [31:0] ALUResult_wire;


//**********************		    MISC WIRES		********************************************/
wire [31:0] BranchAddress_wire;
wire [31:0] PC4PlusBranchAddr_result_wire;
wire [4:0]  WriteRegister_wire;
wire [4:0]  MUX_WriteRegister_output_wire;
wire [31:0] DataOut_wire;
wire [31:0] DataOutOrALUResult_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] ImmediateExtend_wire;
wire [31:0] ReadData2OrImmediate_wire;
wire [31:0] WriteDataOrReturnAddr_wire;
wire [1:0] ForwardA_wire; //sel mux
wire [1:0] ForwardB_wire; //sel mux
integer ALUStatus;
wire [31:0] ReadData1OrForwardA;
wire [31:0] ReadData2OrForwardB;

//**********************   HAZARD UNIT WIRES		************************************/
wire PCWrite_wire;
wire Flush_wire;
wire Stall_wire;

//**********************	   PC MUXES WIRES		************************************/
wire [31:0] PC_wire;
wire [31:0] NextPC_wire;
wire [31:0] PCOrBranch_wire;//for jump mux output
wire [31:0] BranchOrJump_wire;	//for branch mux output which connects directly to the PC register
wire [31:0] PCOrJump_wire;
wire BranchSel_wire; //for PC branch mux
wire Equal_wire;
wire NotEqual_and_BNE_wire;
wire Equal_and_BEQ_wire;

//**********************	IF_ID REGISTER WIRES 	************************************/
wire [31:0] PC4_wire;
wire [31:0] PC4_wire_ID;
wire [31:0] Instruction_wire;
wire [31:0] Instruction_wire_ID;
wire IF_ID_RegWrite_wire;
	
//**********************	ID_EX REGISTER WIRES 	************************************/
wire Jr_signal_EX;
wire Jal_signal_EX;
wire Jump_signal_EX;
wire RegDst_signal_EX;
wire BranchNE_signal_EX;
wire BranchEQ_signal_EX;
wire MemWrite_signal_EX;
wire MemToReg_signal_EX;
wire ALUSrc_signal_EX;
wire RegWrite_signal_EX;
wire MemRead_signal_EX;
wire [3:0] ALUOp_wire_EX;
wire [5:0] funct_wire_EX;
wire [31:0] PC4_wire_EX;
wire [31:0] ReadData1_wire_EX;
wire [31:0] ReadData2_wire_EX;
wire [31:0] ImmediateExtend_wire_EX;
wire [4:0]  rs_wire_EX;
wire [4:0]  rt_wire_EX;
wire [4:0]  rd_wire_EX;
wire [4:0]  Shamt_wire_EX;

//**********************	EX_MEM REGISTER WIRES 	************************************/	
wire [31:0] PC4_wire_MEM;
wire [31:0] ReadData2_wire_MEM;
wire [4:0] WriteRegister_wire_MEM;
wire [31:0] ALUResult_wire_MEM;
wire Jr_signal_MEM;
wire Jal_signal_MEM;
wire Jump_signal_MEM;
wire BranchEQ_signal_MEM;
wire BranchNE_signal_MEM;
wire MemRead_signal_MEM;
wire MemToReg_signal_MEM;
wire MemWrite_signal_MEM;
wire RegWrite_signal_MEM;

//**********************	MEM_WB REGISTER WIRES ************************************/
wire  [31:0] DataOut_wire_WB;
wire  [4:0] WriteRegister_wire_WB;
wire  [31:0] ALUResult_wire_WB;
wire  [31:0] PC_wire_WB;
wire Jr_signal_WB;
wire Jal_signal_WB;
wire Jump_signal_WB;
wire MemToReg_signal_WB;
wire RegWrite_signal_WB;


DataMemory 
RAM
(
	.WriteData(ReadData2_wire_MEM),
	.Address((ALUResult_wire_MEM-'h10010000)>>2),
	.MemWrite(MemWrite_signal_MEM),
	.MemRead(MemRead_signal_MEM),
	.clk(clk),
	
	.ReadData(DataOut_wire)
);

Control
ControlUnit
(
	.OP(Instruction_wire_ID[31:26]),
	.funct(Instruction_wire_ID[5:0]),
	.stall(Stall_wire),
	
	.Jr(Jr_signal),
	.Jal(Jal_signal),
	.Jump(Jump_signal),
	.RegDst(RegDst_signal),
	.BranchNE(BranchNE_signal),
	.BranchEQ(BranchEQ_signal),
	.MemWrite(MemWrite_signal),
	.MemToReg(MemToReg_signal),
	.MemRead(MemRead_signal),
	.ALUSrc(ALUSrc_signal),
	.RegWrite(RegWrite_signal),
	.ALUOp(ALUOp_wire)

);

//**********************		    BRANCH		********************************************/
Equal
eq
(
  .reg1(ReadData1_wire),
  .reg2(ReadData2_wire),
  .Equal(Equal_wire)
);
ANDGate
NotEqualAndBNE
(
	.A(BranchNE_signal),
	.B(~Equal_wire),
	.C(NotEqual_and_BNE_wire)
);
ANDGate
EqualAndBEQ
(
	.A(BranchEQ_signal),
	.B(Equal_wire),
	.C(Equal_and_BEQ_wire)
);
assign BranchSel_wire = (NotEqual_and_BNE_wire || Equal_and_BEQ_wire);

ShiftLeft2 
ShiftLeft2ForBranchAddr
(   
	.DataInput(ImmediateExtend_wire),
   .DataOutput(BranchAddress_wire)

);

Adder32bits
#
(
	.NBits(32)
)
AdderForBranchAddress
(
	.Data0(PC4_wire_ID), //before PC4_wire_EX, but we moved it up in stages to get it earlier on
	.Data1(BranchAddress_wire),
	
	.Result(PC4PlusBranchAddr_result_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForPCAndBranch
(
	.Selector(BranchSel_wire),
	.MUX_Data0(PC4_wire),
	.MUX_Data1(PC4PlusBranchAddr_result_wire),
	
	.MUX_Output(PCOrBranch_wire)

);


//**********************		    JUMP		********************************************/

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForPCAndJump
(
	.Selector(Jump_signal),
	.MUX_Data0(PCOrBranch_wire),
	.MUX_Data1({PC4_wire_ID[31:28], Instruction_wire_ID[27:0]<<2}), //the upper 4 bits of currPC+4 (31:28) , immediate field of the j instr, 00
	
	.MUX_Output(PCOrJump_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForPCAndJr
(
	.Selector(Jr_signal),
	.MUX_Data0(PCOrJump_wire),
	.MUX_Data1(ReadData1_wire), 
	
	.MUX_Output(NextPC_wire)
);



PC_Register
#(
	.N(32)
)
Program_Counter
(
	.clk(clk),
	.reset(reset),
	.PCValue(PC_wire),
	.enable(PCWrite_wire),

	.NewPC(NextPC_wire)	
);


Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC4_wire)
);	
	
	
ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire-'h00400000),
	.Instruction(Instruction_wire)
);
	

//****************************		R & I TYPE INSTRUCTIONS		**************************************/

Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_signal_EX),
	.MUX_Data0(rt_wire_EX),
	.MUX_Data1(rd_wire_EX),  
	
	.MUX_Output(WriteRegister_wire)
);


SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire_ID[15:0]),
	
   .SignExtendOutput(ImmediateExtend_wire)
);



Multiplexer3to1
#(
  .NBits(32)
)
MUX_ForwardA
(
  .Selector(ForwardA_wire),
  .MUX_Data0(ReadData1_wire_EX),
  .MUX_Data1(WriteDataOrReturnAddr_wire),
  .MUX_Data2(ALUResult_wire_MEM),	//WB?????????????????????????
  .MUX_Output(ReadData1OrForwardA)  // A ENTRY ALU
);


Multiplexer3to1
#(
  .NBits(32)
)
MUX_ForwardB
(
  .Selector(ForwardB_wire),
  .MUX_Data0(ReadData2_wire_EX),
  .MUX_Data1(WriteDataOrReturnAddr_wire),		//write this data in the register
  .MUX_Data2(ALUResult_wire_MEM),	//WB?????????????????????????
  .MUX_Output(ReadData2OrForwardB)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_signal_EX), 
	.MUX_Data0(ReadData2OrForwardB),//////////
	.MUX_Data1(ImmediateExtend_wire_EX),
	
	.MUX_Output(ReadData2OrImmediate_wire)///////////////B ENTRY ALU
);



//**********************		    ALU		********************************************/

ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire_EX),
	.ALUFunction(funct_wire_EX), 
	.ALUOperation(ALUOperation_wire)
);

ALU
Arithmetic_Logic_Unit 
(
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1OrForwardA), 
	.B(ReadData2OrImmediate_wire),
	.Shamt(Shamt_wire_EX),
	
	.ALUResult(ALUResult_wire)
);
assign ALUResultOut = ALUResult_wire;

//**********************		  MISC MUXS		********************************************/

Multiplexer2to1

#(
 .NBits(32)
)
MUX_DataOutAndALUResult
(
  .Selector(MemToReg_signal_WB), 
  .MUX_Data0(ALUResult_wire_WB),
  .MUX_Data1(DataOut_wire_WB),
  .MUX_Output(DataOutOrALUResult_wire)
);


Multiplexer2to1
#(
  .NBits(32)
)
MUX_WriteDataAndReturnAddr
(
  .Selector(Jal_signal_WB), 
  .MUX_Data0(DataOutOrALUResult_wire),
  .MUX_Data1(PC_wire_WB),

  .MUX_Output(WriteDataOrReturnAddr_wire)
);

Multiplexer2to1
#(
  .NBits(5)
)
MUX_WriteRegister	//write in reg 31 or in other reg
(
  .Selector(Jal_signal_WB), 
  .MUX_Data0(WriteRegister_wire_WB), 
  .MUX_Data1(31),	//the register $ra(register 31)

  .MUX_Output(MUX_WriteRegister_output_wire)
);

Hazard_Detection_Unit
HazardUnit
(
  .Branch(BranchSel_wire),
  .Jump(Jump_signal | Jr_signal),
  .MemRead_signal_EX(MemRead_signal_EX),
  .rt_EX(rt_wire_EX),
  .rs_ID(Instruction_wire_ID[25:21]),
  .rt_ID(Instruction_wire_ID[20:16]),

  .PCWrite(PCWrite_wire),
  .IF_ID_RegWrite(IF_ID_RegWrite_wire),
  .Flush(Flush_wire), 
  .Stall(Stall_wire)  
);

Register_IF_ID
Reg_IF_ID
(
	.clk(clk),
	.reset(reset),
	.enable(IF_ID_RegWrite_wire),
	.flush(Flush_wire),
	.PC4_input(PC4_wire),
	.Instruction_input(Instruction_wire),
	
	.PC4_output(PC4_wire_ID),
	.Instruction_output(Instruction_wire_ID)
);


RegisterFile
Reg_File
(
	.PC(0),
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_signal_WB),
	.WriteRegister(MUX_WriteRegister_output_wire), 
	.ReadRegister1(Instruction_wire_ID[25:21]),
	.ReadRegister2(Instruction_wire_ID[20:16]),
	.WriteData(WriteDataOrReturnAddr_wire),	//before just DataOutOrALUResult_wire
	
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)
);



Register_ID_EX
Reg_ID_EX
(
	//classic
	.clk(clk),
	.reset(reset),
	.PC4_input(PC4_wire_ID),
	.ReadData1_input(ReadData1_wire),
	.ReadData2_input(ReadData2_wire),
	//control signals	
   .Jal_input(Jal_signal),
	.RegDst_input(RegDst_signal),	
	.BranchEQ_input(BranchEQ_signal),
	.BranchNE_input(BranchNE_signal),
	.MemRead_input(MemRead_signal),
	.MemToReg_input(MemToReg_signal),
	.MemWrite_input(MemWrite_signal),
	.ALUSrc_input(ALUSrc_signal),
	.RegWrite_input(RegWrite_signal),
	.ALUOp_input(ALUOp_wire),
	.funct_input(Instruction_wire_ID[5:0]), 
	//instruction
	.ImmediateExtend_input(ImmediateExtend_wire),
	.rs_input(Instruction_wire_ID[25:21]),
	.rt_input(Instruction_wire_ID[20:16]),
	.rd_input(Instruction_wire_ID[15:11]),
	.shamt_input(Instruction_wire_ID[10:6]),
	
	.PC4_output(PC4_wire_EX),
	.ReadData1_output(ReadData1_wire_EX),
	.ReadData2_output(ReadData2_wire_EX),
	//control signals	
	.Jal_output(Jal_signal_EX),
	.RegDst_output(RegDst_signal_EX),	
	.BranchEQ_output(BranchEQ_signal_EX),
	.BranchNE_output(BranchNE_signal_EX),
	.MemRead_output(MemRead_signal_EX),
	.MemToReg_output(MemToReg_signal_EX),
	.MemWrite_output(MemWrite_signal_EX),
	.ALUSrc_output(ALUSrc_signal_EX),
	.RegWrite_output(RegWrite_signal_EX),
	.ALUOp_output(ALUOp_wire_EX),
	.funct_output(funct_wire_EX), 
	//instruction
	.ImmediateExtend_output(ImmediateExtend_wire_EX),
	.rs_output(rs_wire_EX),
	.rt_output(rt_wire_EX),
	.rd_output(rd_wire_EX),
	.shamt_output(Shamt_wire_EX)

);

Forwarding_Unit 
FWD_unit
(
  .RegWrite_MEM(RegWrite_signal_MEM),
  .RegWrite_WB(RegWrite_signal_WB),
  .rs_EX(rs_wire_EX),
  .rt_EX(rt_wire_EX),
  .rd_MEM(WriteRegister_wire_MEM),
  .rd_WB(MUX_WriteRegister_output_wire),
  
  .ForwardA(ForwardA_wire),
  .ForwardB(ForwardB_wire)
);

Register_EX_MEM
Reg_EX_MEM
(
	.clk(clk),
	.reset(reset),
	.ReadData2_input(ReadData2OrForwardB),
	.ALUResult_input(ALUResult_wire),
	.WriteRegister_input(WriteRegister_wire),
	.PC_input(PC4_wire_EX),
	//control signals	
   .Jal_input(Jal_signal_EX),
	.MemRead_input(MemRead_signal_EX),
	.MemToReg_input(MemToReg_signal_EX),
	.MemWrite_input(MemWrite_signal_EX),
	.RegWrite_input(RegWrite_signal_EX),
		
	.WriteRegister_output(WriteRegister_wire_MEM),
	.PC_output(PC4_wire_MEM),
	.ReadData2_output(ReadData2_wire_MEM),
	.ALUResult_output(ALUResult_wire_MEM),
	//control signals	
	.Jal_output(Jal_signal_MEM),
	.MemRead_output(MemRead_signal_MEM),
	.MemToReg_output(MemToReg_signal_MEM),
	.MemWrite_output(MemWrite_signal_MEM),
	.RegWrite_output(RegWrite_signal_MEM)
);


Register_MEM_WB
Reg_MEM_WB
(
	.clk(clk),
	.reset(reset),
	.ReadData_input(DataOut_wire),
	.ALUResult_input(ALUResult_wire_MEM),
	.WriteRegister_input(WriteRegister_wire_MEM),
	.PC_input(PC4_wire_MEM),
   .Jal_input(Jal_signal_MEM),
	.MemToReg_input(MemToReg_signal_MEM),
	.RegWrite_input(RegWrite_signal_MEM),
	
	.ReadData_output(DataOut_wire_WB),
	.ALUResult_output(ALUResult_wire_WB),
	.WriteRegister_output(WriteRegister_wire_WB),
	.PC_output(PC_wire_WB),
   .Jal_output(Jal_signal_WB),
	.MemToReg_output(MemToReg_signal_WB),
	.RegWrite_output(RegWrite_signal_WB)
);


endmodule

