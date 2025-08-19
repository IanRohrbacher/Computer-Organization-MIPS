# Starter code for reversing the case of a 30 character input.
# Put in comments your name and date please.  You will be
# revising this code.
#
# Created by Dianne Foreback 
# Students should modify this code
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for input
# stores the user input into memory "varStr"
# then displays the users input that is stored in"varStr" 
#
# You will need to write code per the specs for 
# procedures main, revCase and function findMin.
#
# revCase will to reverse the case of the characters
# in varStr.  You must use a loop to do this.  Another buffer
# varStrRev is created to hold the reversed case string.
# 
# Please refer to the specs for this project, this is just starter code.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Ian Rohrbacher presenting revCaseMin.\n"
outpPrompt: .asciiz  "Please enter 30 characters (upper/lower case mixed):\n"
	    .align 2   #align next prompt on a word boundary 
outpStr:    .asciiz  "You entered the string: "
            .align 2   # align users input on a word boundary
varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 
                       # last two chars are \n\0  (a new line and null char)
                       # If user enters 31 characters then clicks "enter" or hits the
                       # enter key, the \n will not be inserted into the 21st element
                       # (the actual users character is placed in 31st element).  the 
                       # 32nd element will hold the \0 character.
                       # .byte 32 will also work instead of .space 32
            .align 2   # align next prompt on word boundary
outpStrRev: .asciiz   "Your string in reverse case is: "
            .align 2   # align the output on word boundary
varStrRev:  .space 32  # reserve 32 characters for the reverse case string
	    .align 2   # align  on a word boundary
outpStrMin: .asciiz    "\nMin ASCII character: "
outpStrMax: .asciiz    "Max ASCII character: "
outpStrDif: .asciiz    "Difference between max and min ASCII values: "
left:		.asciiz	"("
right:		.asciiz	")\n"
#
            .text      # code section begins
            .globl	main 
main:  
#
# system call to display the author of this code
#
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# system call to prompt user for input
#
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# system call to store user input into string thestring
#
	li $v0,8		# system call 8 for read string needs its call number 8 in $v0
        			# get return values
	la $a0,varStr    	# put the address of thestring buffer in $t0
	li $a1,32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        syscall
        #move $t0,$v0		# save string to address in $t0; i.e. into "thestring"
        jal strLen		# pass $ao as the user's string to return $a1 as its lengh
#
# system call to display "You entered the string: "
#
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
#
# system call to display user input that is saved in "varStr" buffer
#
	 la $a0,varStr  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# Your code to invoke revCase goes next	 
#
	jal revCase


# Exit gracefully from main()
         li   $v0, 10       # system call for exit
         syscall            # close file
         
         
################################################################
# revCase() procedure can go next
################################################################
#  Write code to reverse the case of the string.  The base address of the
# string should be in $a0 and placed there by main().  main() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that main() will use in its jal 
# instruction to invoke revCase, perhaps revCase:
#
revCase:
	la $a3, ($a0)			# $a3=$a0
	li $t2, 0			# make sure $t2=0 to use as a counter later
	la $t4, varStrRev		# $t4=revStr
revCaseFor:
	lbu $t1, 0($a3)			# store char in original at $a3
	xor $t1, $t1, 32		# xor char flips case
	sb $t1, 0($t4)			# 
	addi $t4, $t4, 1		# move revStr address up by one
	addi $a3, $a3, 1		# move original str address up by one
	beq $t2, $a1 revCaseForDone	# check if original is at the end
	addi $t2, $t2, 1		# increase counter 
	j revCaseFor
revCaseForDone:

#
# After reversing the string, you may print it with the following code.
# This is the system call to display "Your string in reverse case is: "
	 la $a0,outpStrRev 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
# system call to display the user input that is in reverse case saved in the varRevStr buffer
	 la $a0,varStrRev  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# Your code to invoke findMin() can go next
	la $t8 ($ra)
	jal findMin
	la $ra ($t8)
#
# Your code to invoke findMax() can go next
	la $t8 ($ra)
	jal findMax
	la $ra ($t8)
#
# Your code to invoke findMif() can go next
	la $t8 ($ra)
	jal findDif
	la $ra ($t8)
# Your code to return to the caller main() can go next
	jr $ra


################################################################
# findMin() function can go next
################################################################
#  Write code to find the minimum character in the string.  The base address of the
# string should be in $a0 and placed there by revCase.  revCase() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that revCase() will use in its jal 
# instruction to invoke revCase, perhaps findMin:
#
# 
findMin:
# write use a loop and find the minimum character
	la $a3, varStrRev		# load revStr
	li $t2, 0			# sets $t2 as a counter for a for loop
	li $t5, 0			# stores the smallest char address
	lbu $t3, 0($a3)			# starts the comparison at revStr[0]
minFor:
	lbu $t1, 0($a3)			# store char for comparison
	blt $t1, $t3, isLessThen	# compare $t1<$t3
	j endLessIf
isLessThen:
	move $t3, $t1			# loads new smallest char
	move $t5, $t2			# loads the lacation af the smallest char as a int
endLessIf:
	beq $t2, $a1 minForDone		# end if $t2==$a1
	addi $a3, $a3, 1		# move revStr address location up one
	addi $t2, $t2, 1		# move counter up one
	j minFor
minForDone:
# write code for the system call to print the the minimum character
	la $a0,outpStrMin 	# system call 4 for print string needs address of string in $a0
	li $v0,4		# system call 4 for print string needs 4 in $v0
	syscall
	 
	la $a3, varStrRev	# load revStr
	addu $a3, $a3, $t5	# move to address of min char($t5)
	lbu $a0, ($a3)		# stores as byte
	li $v0, 11		# print char
	syscall
	la $a0, left		# style
	li $v0, 4
	syscall
	la $a3, varStrRev	# load revStr
	addu $t5, $a3, $t5	# move to address of min char($t5)
	lbu $a0, ($t5)		# stores as byte
	li $v0, 1		# print int
	syscall
	la $a0, right		# style
	li $v0, 4
	syscall
	
	move $t5, $t3		# store number for difference

# write code to return to the caller revCase() can go next
	jr $ra



findMax:
# write use a loop and find the maximum character
	la $a3, varStrRev		# load revStr
	li $t2, 0			# sets $t2 as a counter for a for loop
	li $t6, 0			# stores the smallest char address
	lbu $t3, 0($a3)			# starts the comparison at revStr[0]
maxFor:
	lbu $t1, 0($a3)			# store char for comparison
	bgt $t1, $t3, isGreaterThen	# compare $t1>$t3
	j endGreaterIf
isGreaterThen:
	move $t3, $t1			# loads new smallest char
	move $t6, $t2			# loads the lacation af the smallest char as a int
endGreaterIf:
	beq $t2, $a1 maxForDone		# end if $t2==$a1
	addi $a3, $a3, 1		# move revStr address location up one
	addi $t2, $t2, 1		# move counter up one
	j maxFor
maxForDone:
# write code for the system call to print the the minimum character
	la $a0,outpStrMax 	# system call 4 for print string needs address of string in $a0
	li $v0,4		# system call 4 for print string needs 4 in $v0
	syscall
	 
	la $a3, varStrRev	# load revStr
	addu $a3, $a3, $t6	# move to address of min char($t5)
	lbu $a0, ($a3)		# stores as byte
	li $v0, 11		# print char
	syscall
	la $a0, left		# style
	li $v0, 4
	syscall
	la $a3, varStrRev	# load revStr
	addu $t6, $a3, $t6	# move to address of min char($t5)
	lbu $a0, ($t6)		# stores as byte
	li $v0, 1		# print int
	syscall
	la $a0, right		# style
	li $v0, 4
	syscall

	move $t6, $t3		# store number for difference
# write code to return to the caller revCase() can go next
	jr $ra



findDif:
# find the difference
	la $a0, outpStrDif 	# system call 4 for print string needs address of string in $a0
	li $v0,4		# system call 4 for print string needs 4 in $v0
	syscall

	sub $t7, $t6, $t5	# sub max and min for difference
	la $a0, ($t7)
	li $v0, 1		# system call 1 for print int
	syscall

# write code to return to the caller revCase() can go next
	jr $ra



# finds the lenth of the user's string in $a0 and stores it in $a1
strLen:
	li $t1, 0		# counter
	la $a3, ($a0)		# load in user's string to count
strLoop:
	lb $a2, 0($a3)		# load sigle char
	beqz $a2, strDone	# check is char is $zero
	addi $a3, $a3, 1	# move string address
	addi $t1, $t1, 1	# increase counter
	j strLoop
strDone:
	sub $a1, $t1, 2		# sub 2 for looping
	jr $ra
