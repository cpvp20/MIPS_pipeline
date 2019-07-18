onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider pc
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Program_Counter/NewPC
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Program_Counter/PCValue
add wave -noupdate -divider rom
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Instruction
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ROMProgramMemory/Address
add wave -noupdate -divider {var aux}
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_16
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_17
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_18
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_19
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_4
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/MUXRegister1/Data_29
add wave -noupdate -divider control
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/stall
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/OP
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/funct
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/ALUSrc
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/BranchEQ
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/BranchNE
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/Jal
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/Jr
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/ALUOp
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/RegDst
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/RegWrite
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/Jump
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/MemRead
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/MemToReg
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ControlUnit/MemWrite
add wave -noupdate -divider {reg file}
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/RegWrite
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/WriteRegister
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/ReadRegister1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/ReadRegister2
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/WriteData
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/ReadData1
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Reg_File/ReadData2
add wave -noupdate -divider {fwd unit}
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/rd_MEM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/rs_EX
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/rd_WB
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/RegWrite_MEM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/RegWrite_WB
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/rt_EX
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/ForwardA
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FWD_unit/ForwardB
add wave -noupdate -divider alu
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/A
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/B
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/ALUResult
add wave -noupdate -divider ram
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAM/Address
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAM/MemRead
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAM/ReadData
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAM/MemWrite
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAM/WriteData
add wave -noupdate -divider {TOWER A}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[5]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[4]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[3]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[2]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[1]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[0]}
add wave -noupdate -divider {TOWER B}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[13]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[12]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[11]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[10]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[9]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[8]}
add wave -noupdate -divider {TOWER C}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[21]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[20]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[19]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[18]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[17]}
add wave -noupdate -radix hexadecimal {/MIPS_Processor_TB/DUV/RAM/ram[16]}
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {879 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
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
WaveRestoreZoom {873 ps} {901 ps}
