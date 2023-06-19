# Mehmet Kadri Gofralýlar
# 180709005
.data
	values: .word 13, 16, 16, 7, 7
	size: .word 5
	equal: .asciiz "There is no second smallest...\n"
	secondSmallest: .asciiz "Second smallest number is "
.text
	main:
	la $t5 values					#t5=values array's first element's address
	lw $t6, 0($t5)					#t6=values array's first element's value
	lw $s1, size					#s1=size of array
	
	addi $t2, $zero,0				#loop counter			(Initialized as zero)
	lw $t0, 0($t5)					#smallest value			(Initialized as the first element of array)
	lw $t1, 0($t5)					#second smallest value		(Also initialized as the first element of array)

	
	loop:
	add $t2, $t2, 1 				#increase loop counter
	ble $s1, $t2, exit				#if we've reached the end of the array, finish loop
	addi $t5, $t5, 4				#increase the address of values array's element
	lw $t6, 0($t5)					#t6=value of the element in the increased address
	blt $t6, $t0, condition1			#if the next element in the array is smaller than t0, which is supposed to hold smallest element
	blt $t6, $t1, condition2			#if the next element in the array is smaller than t1, which is supposed to hold 2nd smallest element
	bgt $t6, $t1, secSmallest			#if the next element in the array is bigger than t1
	j loop						#repeat this branch
	
	condition1:
	add $t1, $t0, $zero				#t1=t0+0
	add $t0, $t6, $zero				#t0=values[t2]+0
	j loop						#go to loop branch
	
	condition2:
	beq $t6, $t0, loop				#if next element in the array is equal to smallest element, don't change t1's value to t6's value. Go back to loop branch
	add $t1,$zero, $t6				#t1=values[t2]+0
	j loop
	
	secSmallest:
	beq $t0,$t1,condition2				#if t1=t0, which means t6 is currently second smallest element, therefore change t1's value to t6's value in condition 2 branch
	j loop						#go to loop branch
	
	exit:
	beq $t0, $t1, allEqual				#if smallest and second smallest elements are equal, go to allEqual branch
	
	li $v0, 4					#if not, then print "secondSmallest" string
	la $a0, secondSmallest
	syscall
	
	li $v0, 1					#and print the second smallest integer next to it
	add $a0, $zero, $t1
	syscall
	
	li $v0, 10					#end the program
	syscall
	
	allEqual:
	li $v0, 4					#print the "equal" string
	la $a0, equal
	syscall
	
	li $v0, 10					#end the program
	syscall
	
	
