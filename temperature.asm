# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 5
.data
	tempMsg: .asciiz "Input temperature scale to be used (C, F, K, or R): "
	inputMsg: .asciiz "Input temperature: "
	C: .word 67 # Value of the letter C
	F: .word 70 # Value of the letter F
	K: .word 75 # Value of the letter K
	R: .word 82 # Value of the letter R
	cMsg: .asciiz "Executing Celsius program: \n"
	fMsg: .asciiz "Executing Fahrenheit program: \n"
	kMsg: .asciiz "Executing Kelvin program: \n"
	rMsg: .asciiz "Executing Rankine program: \n"
	errMsg: .asciiz "Invalid character, must input C, F, K, or R (case sensitive)! \n"
	errCel: .asciiz "Invalid input, temperature in Celsius must be above -273.15! \n"
	errFahr:.asciiz "Invalid input, temperature in Fahrenheit must be above -459.67! \n"
	errKel: .asciiz "Invalid input, temperature in Kelvin must be above 0! \n"
	errRank: .asciiz "Invalid input, temperature in Rankine must be above 0! \n"
	return: .asciiz "\n"
	cVal: .asciiz "Celsius value is: "
	fVal: .asciiz "Fahrenheit value is: "
	kVal: .asciiz "Kelvin value is: "
	rVal: .asciiz "Rankine value is: "
	fiveNinths: .float .555555555
	twoSeventyThree: .float 273.15
	fourFiftyNine: .float 459.67
	onePointEight: .float 1.8
	thirtyTwo: .float 32
.text
.macro printString (%string)
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, %string # Tells program to print message.
	syscall # Tells program to exexute.
.end_macro
.macro inputFloat
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 12($sp) # Save length in stack.
.end_macro
.macro convertInt
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer to convert to t register.
.end_macro
.macro checkGreater0 (%error)
	lw $t2, 8($sp) # Load for check.
	blez $t2, %error # Checks if number is > 0.
.end_macro
.macro checkGreaterEqual0 (%error)
	lw $t2, 8($sp) # Load for check.
	bltz $t2, %error # Checks if number is >= 0.
.end_macro
.macro printInt
	li $v0, 1 # Tells program to get ready to print an integer.
	move $a0, $t0 # Moves specified register into a0 for printing.
	syscall # Execute
	printString (return)
.end_macro
.macro error (%errMsg, %branch)
	printString (%errMsg)
	b %branch
.end_macro
.macro greaterNumCheck (%number, %branch)
	lwc1 $f1, %number # Load into f1.
	cvt.w.s $f2, $f1 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t2, $t3, %branch # Checks if number is > number.
.end_macro
.macro procedure1 (%string, %branch)
	printString (%string)
	inputFloat
	convertInt
	checkGreater0 (%branch)
.end_macro
.macro procedure2 (%string, %branch)
	printString (%string)
	inputFloat
	convertInt
	checkGreaterEqual0 (%branch)
.end_macro
.macro printFloat (%freg)
	li $v0, 2 # Tells program to get ready to print a float.
	mov.s $f12, %freg
	syscall # Execute
	printString (return)
.end_macro
.macro loadVar (%var)
	lwc1 $f3, %var # Loads variable into f3.
.end_macro
.macro runFlag (%branch)
	lw $t1, 100($sp) # Load flag
	lw $t2, flag # Check to see if flag is set
	beq $t1, $t2, %branch # Flag set, branch to next.
.end_macro
.macro compareChar (%letter, %branch)
	lw $t1, 8($sp) # Load for compare
	lw $t2, %letter # Load variable for letter
	beq $t1, $t2, %branch
.end_macro
.macro readChar
	li $v0, 12 # Tells program to get ready to read a character.
	syscall # Execute
	sw $v0, 8($sp) # Save character read onto stack
.end_macro
.macro check (%freg1, %frge2, %treg, %branch)
	swc1 %freg1, 12($sp)
	cvt.w.s %frge2, %freg1
	swc1 %frge2, 40($sp)
	lw %treg, 40($sp)
	bltz %treg, %branch
	lwc1 %freg1, 12($sp) # restore f5 to K
.end_macro
askOperation:
	printString (tempMsg)
	readChar
	printString (return)
	compareChar (C, celsius)
	compareChar (F, fahrenheit)
	compareChar (K, kelvin)
	compareChar (R, rankine)
	b errorChar
celsius:
	printString (cMsg)
	printString (inputMsg)
	inputFloat
	printString (return)
	lwc1 $f2, 12($sp)
	loadVar (onePointEight)
	mul.s $f4, $f2, $f3
	loadVar (thirtyTwo)
	add.s $f4, $f4, $f3 # f4 has the Fahrenheit value.
	loadVar (twoSeventyThree)
	add.s $f5, $f3, $f2 # f5 has the Kelvin value.
	loadVar (fourFiftyNine)
	add.s $f6, $f3, $f4 # f6 has the Rankine value.
	check ($f5, $f7, $t1, errorCel)
b result
fahrenheit:
	printString (fMsg)
	printString (inputMsg)
	inputFloat
	printString (return)
	lwc1 $f4, 12($sp)
	loadVar (thirtyTwo)
	sub.s $f2, $f4, $f3
	lwc1 $f3, fiveNinths
	mul.s $f2, $f2, $f3 # f2 has the Celsius value.
	loadVar (twoSeventyThree)
	add.s $f5, $f3, $f2 # f5 has the Kelvin value.
	loadVar (fourFiftyNine)
	add.s $f6, $f3, $f4 # f6 has the Rankine value.
	check ($f5, $f7, $t1, errorFahr)
b result
kelvin:
	printString (kMsg)
	printString (inputMsg)
	inputFloat
	printString (return)
	lwc1 $f5, 12($sp)
	loadVar (twoSeventyThree)
	sub.s $f2, $f5, $f3 # f2 has the Celsius value.
	loadVar (onePointEight)
	mul.s $f6, $f3, $f5 # f6 has the Rankine value.
	loadVar (fourFiftyNine)
	sub.s $f4, $f6, $f3 # f4 has the Fahrenheit value.
	check ($f5, $f7, $t1, errorKel)
b result
rankine:
	printString(rMsg)
	printString (inputMsg)
	inputFloat
	printString (return)
	lwc1 $f6, 12($sp)
	loadVar (onePointEight)
	div.s $f5, $f6, $f3 # f5 has the Kelvin value.
	loadVar (twoSeventyThree)
	sub.s $f2, $f5, $f3 # f2 has the Celsius value.
	loadVar (fourFiftyNine)
	sub.s $f4, $f6, $f3 # f4 has the Fahrenheit value.
	check ($f6, $f7, $t1, errorRank)
b result
result:
	printString (cVal)
	printFloat ($f2)
	printString (fVal)
	printFloat ($f4)
	printString (kVal)
	printFloat ($f5)
	printString (rVal)
	printFloat ($f6)
b end
errorChar:
	error (errMsg, askOperation)
errorCel:
	error (errCel, askOperation)
errorFahr:
	error (errFahr, askOperation)
errorKel:
	error (errKel, askOperation)
errorRank:
	error (errRank, askOperation)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
