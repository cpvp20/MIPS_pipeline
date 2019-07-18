# Authors: Luisa Flores Fernandez, Carolina Perez-Vargas Pinson
# Exp: is704339, is717170
# Date: 6/13/19
# Hanoi Towers
.data
.text
lui $sp, 0x1001
ori $sp, $sp, 0x03dc

addi $s1, $s1, 0x1001		# start out w part of address to later shift it to move to the high part
sll $s1, $s1, 16          		# initializa s1 to point to Tower A in 0x10010000
addi $s2, $s1, 0x20    	# initializa s2 to point to Tower B in 0x10010020
addi $s3, $s1, 0x40     	# initializa s3 to point to Tower C in 0x10010040

main:
	addi $s0, $zero, 3		#assign n number of disks  
	add $t7, $zero,  $s0	#int i = n (number of disks)

	while: # Fill tower A with all the disks starting from Dn to D1	
		sw $t7, 0($s1)	#add disk
		addi $t7, $t7, -1 # n--
		addi $s1, $s1, 4	#update top
		add $zero, $zero, $zero	#nop
		add $zero, $zero, $zero  #nop
	bne $t7, $zero, while #while n>0
	add $a0, $zero, $s0 #pass global vars to params for hanoi call
	add $a1, $zero, $s1
	add $a2, $zero, $s3
	add $a3, $zero, $s2		
	jal hanoi_function #initial call : hanoi(n,scr,dest,aux)
	j exit	

#args: n = $a0, src=$a1, dest=$a2, aux=$a3
hanoi_function:
	addi $sp, $sp, -4 #backup $ra
	sw $ra, 0($sp)
	beq $a0, 1, base_case # n==1 ? base case : recursive case
	
	recursive_case:
		addi $a0, $a0, -1 #n-1
		add $t7, $zero, $a2	#swap dest and aux towers for first recursive call 
		add $a2, $zero, $a3
		add $a3, $zero, $t7
		jal hanoi_function #first recursive call: hanoi(n - 1, src, aux, dest);
		add $t7, $zero, $a2	#swap back
		add $a2, $zero, $a3
		add $a3, $zero, $t7

		#pop from src tower ($a1)
		addi $a1, $a1, -4
		lw $t7, ($a1) # Get value of element at the top and store it temporarily in $t7 (disk_n) to push it later
		sw $zero, ($a1) # fill with zero the element that was taken off
		#push(disk_n) to dest tower($a2)	
		sw $t7, 0($a2) #load value at the top of stack
		addi $a2, $a2, 4 # Update top pointer

		addi $a0, $a0, -1 #n-1
		add $t7, $zero, $a1 #swap args for second recursive call 
		add $a1, $zero, $a3
		add $a3, $zero, $t7

		jal hanoi_function #second recursive call: hanoi(n - 1, aux, dest, src);

		add $t7, $zero, $a1 #swap all args back to their respective places: src=$a1, dest=$a3, aux=$a2
		add $a1, $zero, $a3 
		add $a3, $zero, $t7

		j exit_hanoi #end of recusive case
	base_case:  #move last disk from src to dest
		#pop disk_1
		addi $a1, $a1, -4
		lw $t7, ($a1) # Get value of element at the top and store it temporarily in $t7 (disk_1) to push it later
		sw $zero, ($a1) # fill with zero the element that was taken off
		#push(disk_1) to dest tower($a2)	
		sw $t7, 0($a2) #load value at the top of stack
		addi $a2, $a2, 4 # Update top pointer

	exit_hanoi: #restore values
		addi $a0, $a0, 1 #restore n
		lw $ra, 0($sp) #restore $ra
		add $zero, $zero, $zero  #nop
		add $zero, $zero, $zero  #nop
		addi $sp, $sp, 4
		jr $ra

exit:
