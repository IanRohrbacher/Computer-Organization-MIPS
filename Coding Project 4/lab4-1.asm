# Ian Rohrbacher
# 11/14/2024

###############################################################
# set up text to print
            	.data      	# data segment
outpPrompt: 	.asciiz  	"Enter Any Integer to Sum Together (0 to End): "
outpSum: 	.asciiz  	"Your Sum is: "
            	.align 2   	# align users input on a word boundary
            	
###############################################################
# main begins
            	.text      # code section begins
            	.globl	main 
main:
###############################################################
# make sure $t0 is empty
	li $t0, 0		# set $t0 = 0

###############################################################
# top of loop
topLoop:

###############################################################
# prompt user for int
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpPrompt 	# move stored string to print
	syscall			# OUTPUT
	li $v0, 5		# system call 5 to INPUT int
	syscall			# INPUT
	move $t1, $v0		# store int to add or end
	
###############################################################
# check for end
	beq $t1, $zero, endLoop	# if $t0==0 stop loop

###############################################################
# add number together
	add $t0, $t0, $t1	# $t0+=$t1
	j topLoop		# goto topLoop to keep looping

###############################################################
# print final sum
endLoop:
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpSum 	# move stored string to print
	syscall			# OUTPUT
	move $a0, $t0		# move calculated int into to print
	li $v0, 1		# system call 1 to OUTPUT int
	syscall			# OUTPUT

###############################################################
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
