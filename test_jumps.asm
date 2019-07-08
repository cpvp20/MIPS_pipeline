.text
addi $t1,$zero,10
jal label
addi $t1,$zero,20

j exit


label:
	addi $t0,$zero,7
	jr $ra

exit:
#end