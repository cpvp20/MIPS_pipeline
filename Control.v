/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0] OP,
	input [5:0] funct, 
	
   output Jr,
   output Jal,
   output Jump,
	output RegDst,	
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemToReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [3:0]ALUOp
);

localparam R_Type      = 0;
localparam I_Type_ADDI = 6'h8;
localparam I_Type_ORI  = 6'hd;
localparam I_Type_LUI  = 6'hf;
localparam I_Type_ANDI = 6'hc;
localparam I_Type_LW   = 6'h23;
localparam I_Type_SW   = 6'h2b;
localparam I_Type_BEQ  = 6'h4;
localparam I_Type_BNE  = 6'h5;
localparam J_Type_J    = 6'h2;
localparam J_Type_JAL  = 6'h3;


reg [14:0] ControlValues;	//15 control values

always@(OP or funct) begin
	casex(OP)
	
      R_Type     : ControlValues = (funct == 6'h8) ?
											  15'b1_011_001_00_00_0111 :	//jr 
											  15'b0_001_001_00_00_0111;	//or just r 
      I_Type_ADDI: ControlValues = 15'b0_000_101_00_00_0100;
      I_Type_ANDI: ControlValues = 15'b0_000_101_00_00_0101;
      I_Type_ORI : ControlValues = 15'b0_000_101_00_00_0110;
      I_Type_LUI : ControlValues = 15'b0_000_101_00_00_0011;
      I_Type_BEQ : ControlValues = 15'b0_000_000_00_01_1000;
      I_Type_BNE : ControlValues = 15'b0_000_000_00_10_1001;
      I_Type_LW  : ControlValues = 15'b0_000_111_10_00_1010;
      I_Type_SW  : ControlValues = 15'b0_000_100_01_00_1011;
      J_Type_J   : ControlValues = 15'b0_010_000_00_00_0001;
      J_Type_JAL : ControlValues = 15'b0_110_001_00_00_0010;
		
		default:
			ControlValues= 15'b0;
		endcase
end	


  assign Jr       = ControlValues[14];  
  assign Jal      = ControlValues[13];  
  assign Jump     = ControlValues[12]; 
  assign RegDst   = ControlValues[11];  
  assign ALUSrc   = ControlValues[10]; 
  assign MemToReg = ControlValues[9];  
  assign RegWrite = ControlValues[8];   
  assign MemRead  = ControlValues[7];   
  assign MemWrite = ControlValues[6];   
  assign BranchNE = ControlValues[5];   
  assign BranchEQ = ControlValues[4];  
  assign ALUOp    = ControlValues[3:0];

endmodule
//control//

