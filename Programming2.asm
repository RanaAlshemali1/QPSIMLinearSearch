.data	 		# data section 
arr: .word 0, 8, 3, 6, 5, 2, 7, 4, 9, 1, 14, 11, 15, 18, 12, 19, 13, 10, 17, 16				# Array content 
input:	.word 4 											# Reserve 4 byte space in the memory for user input							# Space for the sum array of size 10
parr: .asciiz "\n\nArray = {0, 8, 3, 6, 5, 2, 7, 4, 9, 1, 14, 11, 15, 18, 12, 19, 13, 10, 17, 16}\n"	# First array content print statment
askinput: .asciiz "Please enter a number to search for:\n" 						# Ask for input message
pfound: .asciiz  " is found in index: "									# Found message
pnotfound: .asciiz  " is not found. Sorry!"								# Not ound message


.text 			# text section
.globl main 		# call main by SPIM

main: 
	la $s0, arr	# load address ‘arr’ into $s0
	li $t0, 0	# set counter to 0
	li $t1, 20	# max i value

	la $a0, parr  	# load address ‘parr’ into $a0 to print array
	li $v0, 4	# system call code for print_str
	syscall		# print the string

	la $a0, askinput  # load address 'askinput' into $a0 to print message
	li $v0, 4	  # system call code for print_str
	syscall		  # print the string

	la $a0, input	# load the address alocated for user input into $a0
	li $v0, 5 	# system call code for getting user integer into $v0
	syscall 	# get the integer

	move $s1, $v0
	move $a0, $s1	# move the value to be printed
	li $v0, 1	# system call code for int
	syscall		# print the integer
Loop: 
	beq $t0, $t1, notfound	# if (i == 20) branch to Done
	lw $t2, 0($s0) 		# load word 0(arr) into $t2
	beq $t2, $s1, Found	# branch when found
	addi $s0, 4		# move the pointer to the next element in arr
	addi $t0, 1		# increase i by 1
	j Loop			# jump to loop

notfound:
	la $a0, pnotfound	# load address ‘pnotfound’ into $a0 to print message
	li $v0, 4		# system call code for print_str
	syscall			# print the string
	j Done
Found:
	la $a0, pfound	# load address ‘pfound’ into $a0 to print message
	li $v0, 4	# system call code for print_str
	syscall		# print the string

	move $a0, $t0	# move the index to be printed
	li $v0, 1	# system call code for int
	syscall		# print the string
	
Done:  
	li	$v0, 10
	syscall

