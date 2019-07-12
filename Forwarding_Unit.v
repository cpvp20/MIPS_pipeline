/******************************************************************
* Description
*	This is the forwarding unit for pipeline.
******************************************************************/
module Forwarding_Unit 
(
  input RegWrite_MEM,
  input RegWrite_WB,
  input [4:0] rs_EX,
  input [4:0] rt_EX,
  input [4:0] rd_MEM,
  input [4:0] rd_WB,
  
  output reg [1:0] ForwardA,
  output reg [1:0] ForwardB
);

//1a. EX/MEM.RegisterRd = ID/EX.RegisterRs
//1b. EX/MEM.RegisterRd = ID/EX.RegisterRt
//2a. MEM/WB.RegisterRd = ID/EX.RegisterRs
//2b. MEM/WB.RegisterRd = ID/EX.RegisterRt

  always @(*)
  begin
    ForwardA <= 2'b00;
    ForwardB <= 2'b00;
    if(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs_EX))
    begin
      ForwardA <= 2'b10;
    end
    if(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rt_EX))
    begin
      ForwardB <= 2'b10;
    end
    if(RegWrite_WB && (rd_WB != 0) && (rd_MEM != rs_EX) && (rd_WB == rs_EX)) 
    begin
      ForwardA <= 2'b01;
    end
    if(RegWrite_WB && (rd_WB != 0) && (rd_MEM != rt_EX) && (rd_WB == rt_EX))
    begin
      ForwardB <= 2'b01;
    end
  end
  
endmodule  
