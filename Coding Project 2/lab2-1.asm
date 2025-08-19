            	.data      # data segment
	    	.align 2   # align the next string on a word boundary
outpPromptW: 	.asciiz  "Please Enter an Number for w: "
outpPromptX: 	.asciiz  "Please Enter an Number for x: "
outpPromptY: 	.asciiz  "Please Enter an Number for y: "
outpPromptZ: 	.asciiz  "Please Enter an Number for z: "
	    	.align 2   #align next prompt on a word boundary
outpStrW:    	.asciiz  "w: "
outpStrX:    	.asciiz  "x: "
outpStrY:    	.asciiz  "y: "
outpStrZ:   	.asciiz  "z: "
outpStrTemp: 	.asciiz  "temp: "
newLine:	.asciiz "\n"
            	.align 2   # align users input on a word boundary

# main begins
            	.text      # code section begins
            	.globl	main 
            	
            	
main:  
# system call to prompt user for input
	la $a0, outpPromptW	# OUTPUT string
	li $v0,4
	syscall	
	li $v0, 6		# INPUT float
	syscall
	mov.s $f2, $f0		# Stores input to $f2

	la $a0, outpPromptX	# OUTPUT string
	li $v0,4
	syscall
	li $v0, 6		# INPUT float
	syscall
	mov.s $f4, $f0		# Stores input to $f4

	la $a0, outpPromptY	# OUTPUT string
	li $v0,4
	syscall
	li $v0, 6		# INPUT float
	syscall
	mov.s $f6, $f0		# Stores input to $f6
	
	la $a0, outpPromptZ	# OUTPUT string
	li $v0,4
	syscall
	li $v0, 6		# INPUT float
	syscall
	mov.s $f8, $f0		# Stores input to $f10


# logic
	sub.s $f10, $f4, $f6	# (x - y) = $f10
	c.lt.s $f10,$f2		# if($f10 < w)
	bc1t numberLess		# if true goto numberLess
	bc1f numberGreaterEqual	# if false goto numberGreaterEqual
numberGreaterEqual:
	mov.s $f4, $f6		# x = Y
	j endIf
numberLess:
	mov.s $f4, $f8		# x = z
	j endIf
endIf:


# Outputs results

#	la $a0, outpStrW 	# system call 4 for print string needs address of string in $a0
#	li $v0, 4		# system call 4 for print string needs 4 in $v0
#	syscall  	
#	li $v0, 2		# Outputs the result of w
#	mov.s $f12, $f2		# Moves w to output
#	syscall

#	la $a0, newLine
#	li $v0, 4
#	syscall
	
	la $a0,outpStrX 	# system call 4 for print string needs address of string in $a0
	li $v0, 4		# system call 4 for print string needs 4 in $v0
	syscall 
	li $v0, 2		# Outputs the result of x
	mov.s $f12, $f4		# Moves x to output
	syscall

#	la $a0, newLine
#	li $v0, 4
#	syscall
	
#	la $a0, outpStrY 	# system call 4 for print string needs address of string in $a0
#	li $v0, 4		# system call 4 for print string needs 4 in $v0
#	syscall 
#	li $v0, 2		# Outputs the result of y
#	mov.s $f12, $f6		# Moves y to output
#	syscall

#	la $a0, newLine
#	li $v0, 4
#	syscall
	
#	la $a0, outpStrZ 	# system call 4 for print string needs address of string in $a0
#	li $v0, 4		# system call 4 for print string needs 4 in $v0
#	syscall 
#	li $v0, 2		# Outputs the result of z
#	mov.s $f12, $f8		# Moves z to output
#	syscall
	
#	la $a0, newLine
#	li $v0, 4
#	syscall

#	la $a0, outpStrTemp 	# system call 4 for print string needs address of string in $a0
#	li $v0, 4		# system call 4 for print string needs 4 in $v0
#	syscall 
#	li $v0, 2		# Outputs the result of $f10
#	mov.s $f12, $f10	# Moves $f10 to output
#	syscall


# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
