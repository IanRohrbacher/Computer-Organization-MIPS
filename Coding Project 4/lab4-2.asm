# Ian Rohrbacher
# 11/14/2024

###############################################################
# set up text to print
            	.data      	# data segment
outpInt: 	.asciiz  	"Please Enter Three Integers:\n"
outpBig: 	.asciiz  	"The Biggest Two Integers Sumed is: "
            	.align 2   	# align users input on a word boundary
            	
###############################################################
# main begins
            	.text      # code section begins
            	.globl	main 
main:
###############################################################
# make sure $t9 is empty
	li $t9, 0		# set $t9 = 0
	
###############################################################
# Ask user for three integers and stores them
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpInt 	# move stored string to print
	syscall			# OUTPUT
	li $v0, 5		# system call 5 to INPUT int
	syscall			# INPUT
	move $t0, $v0		# store int for looping
	li $v0, 5		# system call 5 to INPUT int
	syscall			# INPUT
	move $t1, $v0		# store int for looping
	li $v0, 5		# system call 5 to INPUT int
	syscall			# INPUT
	move $t2, $v0		# store int for looping

###############################################################
# find smallest int
	move $t3, $t0			# move first int to print adress
	bgt $t3, $t1, secondSmallest	# if $t3>$t1 goto secondSmallest
	j secondLess			# skip moving smaller int
secondSmallest:
	move $t3, $t1			# move second larger int to print adress
	li $t9, 1			# set $t9 = 2
secondLess:
	bgt $t3, $t2, thirdSmallest	# if $t3>$t2 togo thirdSmallest
	j thirdLess
thirdSmallest:				# skip moving smaller int
	move $t3, $t2			# move third larger int to print adress
	li $t9, 2			# set $t9 = 3
thirdLess:

###############################################################
# add two largest ints
	beq $t9, 0, firstIF	# if $t9==0
	j first
firstIF:			# if result
	add $t3, $t1, $t2	# $t3=$t1+$t2
first:				# end if
	beq $t9, 1, secondIF	# if $t9==1
	j second
secondIF:			# if result
	add $t3, $t0, $t2	# $t3=$t0+$t2
second:				# end if
	beq $t9, 2, thirdIF	# if $t9==2
	j third
thirdIF:			# if result
	add $t3, $t0, $t1	# $t3=$t0+$t1
third:				# end if

###############################################################
# output the result
	li $v0, 4		# system call 4 to OUTPUT string
	la $a0, outpBig 	# move stored string to print
	syscall			# OUTPUT
	move $a0, $t3		# move calculated int into to print
	li $v0, 1		# system call 1 to OUTPUT int
	syscall			# OUTPUT

###############################################################
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
