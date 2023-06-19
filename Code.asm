# Mehmet Kadri Gofralýlar
# 180709005

.data
	numbers: .double 1.0,1.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
	breakCond : .double 150.0
	enter: .asciiz "\n"
	
.text
main:
	la $t1, numbers		#$t1 = numbers array
	l.d $f0, breakCond	#$f0 = 150.0
	
while:
	l.d $f2, ($t1)		#$f2 =numbers[index]		(index is initially 0)
	l.d $f4, 8($t1)		#$f4 =numbers[index+1]
	
	c.le.d $f0, $f4		#if numbers[index+1]>150.0
	bc1t equal		#go to equal branch
	
	add.d $f6, $f2, $f4	#$f6 = numbers[index] + numbers[index+1]
	sdc1 $f6, 16($t1)	#numbers[index+2] = $f6
	addi $t1, $t1, 8	#index = index+1
	j while
	
	
equal:
	la $t1, numbers		#$t1 = numbers array
	addi $t0, $zero, 0	#$t0 = 0 (for loop counter)
	
for:
	l.d $f0, ($t1)		#$f0 = numbers[index]
	
	li $v0, 3		#print $f0 (numbers[index])
	mov.d $f12, $f0		
	syscall
	
	li $v0, 4		#print "\n"
	la $a0, enter
	syscall
	
	addi $t1, $t1, 8	#index = index+1
	addi $t0, $t0, 1	#counter = counter+1

	ble $t0, 13, for	#if counter < 13, go to for loop
	li $v0, 10		#finish program
