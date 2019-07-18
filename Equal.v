module Equal
(
  input [31:0] reg1,
  input [31:0] reg2,

  output reg Equal
);


always@(*)
	Equal = !(reg1 ^ reg2);  
	
endmodule
