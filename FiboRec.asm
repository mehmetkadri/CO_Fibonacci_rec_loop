.data

	number1: .word 0
	number2: .word 1
	count: .word 0
	result: .word 0
	input: .asciiz "Enter the sequence number:"
	before: .asciiz "F("
	after: .asciiz ")="
	
.text

li $v0, 4
la $a0, input
syscall
li $v0,5
syscall
sw $v0, count	

lw $a0,count	
jal baseCase
sw $v0, result	

li $v0, 4
la $a0, before
syscall							#prints before
li $v0, 1
lw $a0, count
syscall							#prints n
li $v0, 4
la $a0, after
syscall							#prints after
li $v0, 1
lw $a0, result						
syscall							#prints result
		
li $v0, 10						
syscall							#end program

baseCase:
bgt $a0, 1, recursion					# goto recursion if a0>1
move $v0, $a0						# v0=a0
jr $ra							# return

recursion:
add $sp, $sp, -12					# adjust stack for 3 items(one for return address, two for arguments)
sw $ra, 0($sp)						# save $ra
	
sw $a0, 4($sp)						# save n
add $a0, $a0, -1					# n-1
jal baseCase						# fibonacci(n-1)
lw $a0, 4($sp)						# restore n
sw $v0, 8($sp)
	
add $a0, $a0, -2					# n-2
jal baseCase						# fibonacci(n-2)
	
lw $t0, 8($sp)						# fibonacci(n-1)
add $v0, $t0, $v0					# v0=t0+v0

	
lw $ra, 0($sp)						# restore return address
add $sp, $sp, 12					# pop 3 items from stack
jr $ra							# return
