# Ian Rohrbacher
# 11/7/2024

###############################################################
# set up text to print
            	.data      	# data segment
outpInt: 	.asciiz  	"How many numbers would you like to average?: "
outpFloat: 	.asciiz  	"Please Enter a 3 digit decimal d.dd: "
outpAverage: 	.asciiz  	"The average is: "
            	.align 2   	# align users input on a word boundary
            	
###############################################################
# main begins
            	.text      # code section begins
            	.globl	main 
main:  

###############################################################
# Ask user for amount to average
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpInt 	# move stored string to print
	syscall			# OUTPUT
	li $v0, 5		# system call 5 to INPUT int
	syscall			# INPUT
	move $t0, $v0		# store int for looping
	mtc1 $v0, $f4		# loads int for casting
	cvt.s.w $f4, $f4	# store int as a float for divition later

###############################################################
# stores int amount of floats together
	mtc1 $zero, $f2 		# set all zero in $f2
loopFloat:
	sub $t0, $t0, 1			# $t0--; for 

	li $v0, 4			# system call 4 to OUTPUT string
	la $a0, outpFloat 		# move stored string to print
	syscall				# OUTPUT
	
	li $v0, 6			# system call 6 to INPUT float
	syscall				# INPUT
	add.s $f2, $f2, $f0		# add INPUT to $f2	
	
	bne $t0, $zero, loopFloat	# while($t0 > 0) goto top of loop

###############################################################
# output the result of floats/int
	div.s $f2, $f2, $f4	# divides final float by int casted to float
	
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpAverage 	# move stored string to print
	syscall			# OUTPUT
	li $v0, 2		# system call 2 to OUTPUT float
	mov.s $f12, $f2 	# move stored float to print
	syscall			# OUTPUT

###############################################################
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
