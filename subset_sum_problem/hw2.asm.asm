.data
str1:	.asciiz "Enter the Array Size: "
str2:	.asciiz "Enter the sum: "
str3:	.asciiz "Possible"
str4:	.asciiz "Not Possible"
arr:	.word 100
.text
.globl main
#$t0=arr
#$t1=size
#$t2=sum
#$t3=iter
#$v0=return value
#$a0=sum
#$a1=address of array
#$a2=size
main:	
	la $t0,arr	#stores the address of arr in $t0
	
	li $v0,4	
	la $a0,str1
	syscall		#prints str1
	
	li $v0, 5
	syscall		#gets input from the user and stores it to $t1 
	move $t1, $v0
	
	li $v0,4	
	la $a0,str2
	syscall		#prints str2
	
	li $v0, 5
	syscall		#gets input from the user and stores it to $t2
	move $t2, $v0
	
	li $t3,0	#sets iterator to zero
	input:
		beq $t1,$t3,continue
		li $v0, 5
		syscall		#gets integer from the user 
		sw $v0, 0($t0)	#stores it in the address of arr.
		addi $t0,$t0,4	#increases the addres of word for storing other integers.
		addi $t3,$t3,1	#increases the iterator
		j input
	continue:
		move $s1,$t1		#$s1 is the temp size for checkSum procedure	
		
		move $a0,$t2		#num is assigned to a0
		la $a1,($t0)		#arrays last address is assigned to a1
		move $a2,$t1		#size is assigned to a2
		
		jal checkSum		#jumps checkSum function and stores the next command in the program counter.
		bne $zero,$v0,printTrue	#if $s0(returned value) is 1,then it is possible.
		beq $zero,$v0,printFalse#if $s0(returned value) is not 1,then it is 0. So sum is not possible.
		j terminate
## :(
checkSum:
	beq $a0,$zero,returnTrue	# $a0=sum value
	beq $a2,$zero,returnFalse	# $a2=size value
	addi $sp,$sp,-20		# creates a space in the stack 
	sw $ra, 0($sp)			# keeps the return adress in the 0($sp)
	sw $a0, 4($sp)			# keeps the sum number in the 4($sp)
	sw $a1, 8($sp)			# keeps the arr address in the 8($sp)
	sw $a2, 12($sp)			# keeps the size in the 12($sp)
	addi $a2,$a2,-1			# decrease the size
	jal checkSum			# jump (and link) to checkSum procedure
	sw $v0, 16($sp)			# keeps the return value of first function in the 16($sp)
	lw $a0, 4($sp)			# loads the first value 
	lw $a1, 8($sp)			# loads the first value
	lw $a2, 12($sp)			# loads the first value
	addi $a2,$a2,-1			# decrease the size
	lw $s7,-4($a1)			# loads the last element of array to $s7
	sub $a0,$a0,$s7			# number-lastelement
	lw $a1, -4($a1)			# changes the last element of array to 1 before
	jal checkSum			# calls itself again 
	lw $s6, 16($sp)			# loads the first v0 value to $s6 for or command
	or $v0,$v0,$s6			# "or"s them and assign the result value to $v0 (according to contracct) 
	lw $ra,0($sp)			# original ra value is called
	addi $sp,$sp,20			# stack is as same as before.
	jr $ra				#go back the line that PC keeps.
## :(
	returnTrue:	
		addi $v0,$zero,1	# assign v0 to 1
		jr $ra
	returnFalse:	
		add $v0,$zero,$zero	# assign v0 to 0
		jr $ra
printTrue:	
	li $v0,4	
	la $a0,str3
	syscall		#prints str3
	j terminate

printFalse:
	li $v0,4	
	la $a0,str4
	syscall		#prints str4
	j terminate
terminate:
	li $v0,10		
	syscall		#terminates the program