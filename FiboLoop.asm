.data

	number1: .word 0
	number2: .word 1
	count: .word 20
	input: .asciiz "Enter the sequence number:"
	before: .asciiz "F("
	after: .asciiz ")="
	
.text
	
	lw $t4, number1
	lw $t5, number2
	add $t0,$zero,$zero
	
	li $v0, 4
    	la $a0, input
    	syscall
	li $v0,5
	syscall
	add $s2, $v0, $zero
	
	loop:
	bge $t0, $s2, exit
	
	add $t6, $t4, $t5
	add $t4, $t5, $zero
	add $t5, $t6, $zero
	
	add $t0, $t0, 1
	j loop
	
	exit:
	li $v0, 4
	la $a0, before
	syscall
	li $v0, 1
	add $a0, $s2, $zero
	syscall
	li $v0, 4
	la $a0, after
	syscall
	li $v0, 1
	add $a0, $t4, $zero
	syscall
	
	
	
	