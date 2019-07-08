onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CONTROL
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/OP
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/Jump
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/RegDst
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/BranchEQ
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/BranchNE
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/MemRead
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/MemToReg
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/MemWrite
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/ALUSrc
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/RegWrite
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/ALUOp
add wave -noupdate -divider PC_OR_BRANCH_MUX
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForPCAndBranch/Selector
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForPCAndBranch/MUX_Data0
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForPCAndBranch/MUX_Data1
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForPCAndBranch/MUX_Output
add wave -noupdate -divider BRANCH_OR_JUMP_MUX
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForBranchAndJump/Selector
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForBranchAndJump/MUX_Data0
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForBranchAndJump/MUX_Data1
add wave -noupdate /MIPS_Processor_TB/DUV/MUX_ForBranchAndJump/MUX_Output
add wave -noupdate -divider PC
add wave -noupdate /MIPS_Processor_TB/DUV/Program_Counter/clk
add wave -noupdate /MIPS_Processor_TB/DUV/Program_Counter/PCValue
add wave -noupdate /MIPS_Processor_TB/DUV/Program_Counter/NewPC
add wave -noupdate -divider ALU
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/ALUOperation
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/A
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/B
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/Shamt
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/Zero
add wave -noupdate /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/ALUResult
add wave -noupdate -divider {Tower A}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[7]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[6]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[5]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[4]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[3]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[2]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[1]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[0]}
add wave -noupdate -divider {Tower B}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[15]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[14]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[13]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[12]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[11]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[10]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[9]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[8]}
add wave -noupdate -divider {Tower C}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[23]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[22]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[21]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[20]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[19]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[18]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[17]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAM/ram[16]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {62 ps} {188 ps}
