            	.data      	# data segment
outpPromptA: 	.asciiz  	"Please 0:Integer: 1:Float 2:String : "
outpPromptIY: 	.asciiz  	"Please Enter a Integer for y: "
outpPromptIX: 	.asciiz  	"Please Enter a Integer for x: "
outpPromptFY: 	.asciiz  	"Please Enter a Float for y: "
outpPromptFX: 	.asciiz  	"Please Enter a Float for x: "
outpPromptSY: 	.asciiz  	"Please Enter a String for y: "
outpPromptSX: 	.asciiz  	"Please Enter a String for x: "
outpPromptY: 	.asciiz  	"Please Enter Anything for y: "
outpStrX:    	.asciiz  	"x: "
outpStrY:    	.asciiz  	"\ny: "
            	.align 2   	# align users input on a word boundary
input1:		.space 81
input2:		.space 81
inputSize:    	.word 81

# main begins
            	.text      # code section begins
            	.globl	main 
main:  
# system call to prompt user for input
	lw $a1, inputSize
	
	la $a0, outpPromptA	# OUTPUT text
	li $v0 , 4
	syscall
	li $v0, 5		# INPUT int
	syscall
	
	beq $v0, 0, integerOption	# if input is 0 run integer code
	beq $v0, 1, floatOption		# if input is 1 run float code
	beq $v0, 2, stringOption	# if input is 2 run string code
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file

integerOption:
	la $a0, outpPromptIX	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 5		# INPUT int
	syscall
	move $t7, $v0		

	la $a0, outpPromptIY	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 5		# INPUT int
	syscall
	move $t8, $v0		
	
# logic
	move $t9, $t7  		# $t9 = $t7
	move $t7, $t8		# $t7 = $t8
	move $t8, $t9		# $t8 = $t9

# Outputs result
	li $v0, 4
	la $a0, outpStrX 	# system call 4 for print string needs address of string in $a0
	syscall
	li $v0, 1
        move $a0, $t7		# moves $t7 to $a0 for output
	syscall
	
	li $v0, 4	
	la $a0, outpStrY 	# system call 4 for print string needs address of string in $a0
	syscall
	li $v0, 1
        move $a0, $t8		# moves $t8 to $a0 for output
	syscall
	
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
	
	
	
floatOption:
	la $a0, outpPromptFX	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 6		# INPUT float
	syscall
	mov.s $f2, $f0		# Stores input to $f2

	la $a0, outpPromptFY	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 6		# INPUT float
	syscall
	mov.s $f4, $f0		# Stores input to $f4
	
# logic
	mov.s $f6, $f4  	# $f6 = $f4
	mov.s $f4, $f2		# $f4 = $f2
	mov.s $f2, $f6		# $f2 = $f6

# Outputs result
	li $v0, 4
	la $a0, outpStrX 	# system call 4 for print string needs address of string in $a0
	syscall
	li $v0, 2
        mov.s $f12, $f2		# moves $t7 to $a0 for output
	syscall
	
	li $v0, 4	
	la $a0, outpStrY 	# system call 4 for print string needs address of string in $a0
	syscall
	li $v0, 2
        mov.s $f12, $f4		# moves $t8 to $a0 for output
	syscall
	
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
	
	
	
stringOption:	
	la $a0, outpPromptSX	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 8		# INPUT string
	la $a0, input1		# load byte space into address
	syscall

	la $a0, outpPromptSY	# OUTPUT text
	li $v0, 4
	syscall
	li $v0, 8		# INPUT string
	la $a0, input2		# load byte space into address
	syscall
	
# logic
	li $s1, 0
swap1:				# swaps input1 into inputT
	lb $t4, input1($s1)  	# $t4 = input1[$s1]
	lb $t5, input2($s1)	# $t5 = input2[$s1]
	beq $t4, $t5, checkEnd	# if $t4 == $t5
goBack:
	sb $t4, input2($s1)	# input2[$s1] = $t4
	sb $t5, input1($s1)	# input1[$s1] = $t5
	addi $s1, $s1, 1 	# increment the address
	j swap1      		# finally loop 
checkEnd:
	bne $t5, $zero, goBack	# if $t5 != 0

# Outputs result
	li $v0, 4		# system call 4 for print string needs 4 in $v0
	
	la $a0, outpStrX 	# system call 4 for print string needs address of string in $a0
	syscall
        la $a0, input1 		# reload byte space to primary address
	syscall
		
	la $a0, outpStrY 	# system call 4 for print string needs address of string in $a0
	syscall
        la $a0, input2 		# reload byte space to primary address
	syscall
	
# Exit gracefully
         li $v0, 10		# system call for exit
         syscall		# close file
