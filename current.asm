# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 6
.data
	wireMsg: .asciiz "Input wire material to be used (A for aluminum, C for copper, G for Gold, or S for silver): "
	lengthMsg: .asciiz "Input wire length in meters: "
	diameterMsg: .asciiz "Input wire diameter in centimeters: "
	voltMsg: .asciiz "Input voltage in volts: "
	aluminumMsg: .asciiz "Executing aluminum program: \n"
	copperMsg: .asciiz "Executing copper program: \n"
	goldMsg: .asciiz "Executing gold program: \n"
	silverMsg: .asciiz "Executing silver program: \n"
	errMsg: .asciiz "Invalid character, must input A, C, G, or S (case sensitive)! \n"
	aMsg: .asciiz "Aluinum wire's current carrying capability is: "
	cMsg: .asciiz "Copper wire's current carrying capability is: "
	gMsg: .asciiz "Gold wire's current carrying capability is: "
	sMsg: .asciiz "Silver wire's current carrying capability is: "
	ampMsg: .asciiz " amps."
	errLength: .asciiz "Length must be greater than 0! \n"
	errDiameter: .asciiz "Diameter must be greater than 0! \n"
	errVoltage: .asciiz "Voltage must be greater than 0! \n"
	tenNegativeEight: .float .00000001
	oneHalf: .float .5
	cmCvt: .float .01
	aResist: .float 2.75
	cResist: .float 1.72
	gResist: .float 2.44
	sResist: .float 1.59
	return: .asciiz "\n"
	A: .word 65
	C: .word 67
	G: .word 71
	S: .word 83
	pi: .float 3.141592654
.text
.macro printString (%string)
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, %string # Tells program to print message.
	syscall # Tells program to exexute.
.end_macro
.macro printFloat (%freg)
	li $v0, 2 # Tells program to get ready to print a float.
	mov.s $f12, %freg
	syscall # Execute
.end_macro
.macro inputFloat (%num)
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, %num($sp) # Save length in stack.
.end_macro
.macro error (%errMsg, %branch)
	printString (%errMsg)
	b %branch
.end_macro
.macro compareChar (%letter, %branch)
	lw $t1, 4($sp) # Load for compare
	lw $t2, %letter # Load variable for letter
	beq $t1, $t2, %branch
.end_macro
.macro readChar (%num)
	li $v0, 12 # Tells program to get ready to read a character.
	syscall # Execute
	sw $v0, %num($sp) # Save character read onto stack.
.end_macro
.macro convertInt
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer to convert to t register.
.end_macro
.macro checkGreater0 (%error)
	lw $t2, 8($sp) # Load for check.
	blez $t2, %error # Checks if number is > 0.
.end_macro
.macro area
	lwc1 $f1, 108($sp) # Loads diameter from stack.
	lwc1 $f3, cmCvt # Loads centimeter conversion into f3.
	mul.s $f2, $f1, $f3 # Converts diameter to meters. 
	lwc1 $f3, oneHalf # Loads .5 into f3.
	mul.s $f2, $f2, $f3 # Finds radius.
	mul.s $f2, $f2, $f2 # Squares radius.
	lwc1 $f3, pi # Loads pi into f3.
	mul.s $f4, $f2, $f3 # Finds circumfrence
.end_macro
.macro resistance (%rho, %freg)
	lwc1 $f2, %rho # Loads specified resistivity into f3.
	lwc1 $f3, tenNegativeEight
	mul.s $f2, $f2, $f3 # Multiplies product by 10^-8.
	lwc1 $f3, 104($sp) # Loads length from stack
	mul.s $f1, $f2, $f3 # Multiplies length by rho.
	div.s %freg, $f1, $f4 # Finds resistance and stores it in specified register.
.end_macro
.macro current (%freg)
	lwc1 $f2, 112($sp) # Loads voltage from stack.
	div.s %freg, $f2, %freg
.end_macro
.macro checkGreaterEqual0 (%error)
	lw $t2, 8($sp) # Load for check.
	bltz $t2, %error # Checks if number is >= 0.
.end_macro
hubOperation:
	printString (wireMsg)
	readChar (4)
	printString (return)
	compareChar (A, aluminum)
	compareChar (C, copper)
	compareChar (G, gold)
	compareChar (S, silver)
	b errorChar
aluminum:
	printString (aluminumMsg)
aLength:
	printString (lengthMsg)
	inputFloat (104) # Save onto 104 of stack.
	convertInt
	checkGreater0 (errorAluLength)
aDiameter:
	printString (diameterMsg)
	inputFloat (108) # Save onto 108 of stack.
	convertInt
	checkGreaterEqual0 (errorAluDiameter)
aVoltage:
	printString (voltMsg)
	inputFloat (112) # Save onto 112 of stack.
	convertInt
	checkGreater0 (errorAluVoltage)
	area
	resistance (aResist, $f5) # f5 contains aluminum resistivity value.
	current ($f5) # f5 contains value for aluminum.
	printString (aMsg)
	printFloat ($f5)
	printString (ampMsg)
b end
copper:
	printString (copperMsg)
cLength:
	printString (lengthMsg)
	inputFloat (104) # Save onto 104 of stack.
	convertInt
	checkGreater0 (errorCopLength)
cDiameter:
	printString (diameterMsg)
	inputFloat (108) # Save onto 108 of stack.
	convertInt
	checkGreaterEqual0 (errorCopDiameter)
cVoltage:
	printString (voltMsg)
	inputFloat (112) # Save onto 112 of stack.
	convertInt
	checkGreater0 (errorCopVoltage)
	area
	resistance (cResist, $f6) # f6 contains copper resistivity value.
	current ($f6) # f6 contains value for copper.
	printString (cMsg)
	printFloat ($f6)
	printString (ampMsg)
b end
gold:
	printString (goldMsg)
gLength:
	printString (lengthMsg)
	inputFloat (104) # Save onto 104 of stack.
	convertInt
	checkGreater0 (errorGolLength)
gDiameter:
	printString (diameterMsg)
	inputFloat (108) # Save onto 108 of stack.
	convertInt
	checkGreaterEqual0 (errorGolDiameter)
gVoltage:
	printString (voltMsg)
	inputFloat (112) # Save onto 112 of stack.
	convertInt
	checkGreater0 (errorGolVoltage)
	area
	resistance (gResist, $f7) # f7 contains gold resistivity value.
	current ($f7) # f7 contains value for gold.
	printString (gMsg)
	printFloat ($f7)
	printString (ampMsg)
b end
silver:
	printString (silverMsg)	
sLength:
	printString (lengthMsg)
	inputFloat (104) # Save onto 104 of stack.
	convertInt
	checkGreater0 (errorSilLength)
sDiameter:
	printString (diameterMsg)
	inputFloat (108) # Save onto 108 of stack.
	convertInt
	checkGreater0 (errorSilDiameter)
sVoltage:
	printString (voltMsg)
	inputFloat (112) # Save onto 112 of stack.
	convertInt
	checkGreater0 (errorSilVoltage)
	area
	resistance (sResist, $f8) # f8 contains silver resistivity value.
	current ($f8) # f8 contains value for silver.
	printString (sMsg)
	printFloat ($f8)
b end
errorAluLength:
	error (errLength, aLength)
errorAluDiameter:
	error (errDiameter, aDiameter)
errorAluVoltage:
	error (errVoltage, aVoltage)
errorCopLength:
	error (errLength, cLength)
errorCopDiameter:
	error (errDiameter, cDiameter)
errorCopVoltage:
	error (errVoltage, cVoltage)
errorGolLength:
	error (errLength, gLength)
errorGolDiameter:
	error (errDiameter, gDiameter)
errorGolVoltage:
	error (errVoltage, gVoltage)
errorSilLength:
	error (errLength, sLength)
errorSilDiameter:
	error (errDiameter, sDiameter)
errorSilVoltage:
	error (errVoltage, sVoltage)
errorChar:
	error (errMsg, hubOperation)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
