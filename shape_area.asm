# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 7
.data
	sidesMsg: .asciiz "Input number of sides of polygon: "
	lengthMsg: .asciiz "Input length of sides of polygon in units: "
	errSidesMsg: .asciiz "Sides must be greater than 2! \n"
	errLengthMsg: .asciiz "Length must be greater than 0! \n"
	areaMsg: .asciiz "Area of polygon is: "
	unitMsg: .asciiz " square units."
	return: .asciiz "\n"
	oneEighty: .float 180
	one: .float 1
	four: .float 4
	pi: .float 3.141592654
	twoFactorial: .float 2
	threeFactorial: .float 6
	fourFactorial: .float 24
	fiveFactorial: .float 120
	sixFactorial: .float 720
	sevenFactorial: .float 5040
	eightFactorial: .float 40320
	nineFactorial: .float 362880
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
.macro convertInt
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer to convert to t register.
.end_macro
.macro checkGreater0 (%error)
	lw $t2, 8($sp) # Load for check.
	blez $t2, %error # Checks if number is > 0.
.end_macro
.macro greaterNumCheck (%number, %branch)
	lwc1 $f2, %number # Load number into f1.
	cvt.w.s $f2, $f2 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t3, $t2, %branch # Checks if number is > %number.
.end_macro
.macro error (%errMsg, %branch)
	printString (%errMsg)
	b %branch
.end_macro
.macro findAngle
	lwc1 $f2, 100($sp)
	lwc1 $f1, oneEighty
	div.s $f2, $f1, $f2 # f4 contains the angle that the tangent needs to be taken.
	swc1 $f2, 108($sp)
.end_macro
.macro convertRadian
	lwc1 $f4, pi
	lwc1 $f5, oneEighty
	div.s $f4, $f4, $f5
	lwc1 $f3, 108($sp)
	mul.s $f3, $f3, $f4
	swc1 $f3, 108($sp)
.end_macro
.macro sin (%freg)
	findAngle
	convertRadian
	lwc1 $f1, 108($sp)
	mul.s $f2, $f1, $f1 # f2 contains the 2 exponent.
	mul.s $f3, $f2, $f1 # f3 contains the 3 exponent.
	mul.s $f4, $f3, $f1 # f4 contains the 4 exponent.
	mul.s $f5, $f4, $f1 # f5 contains the 5 exponent.
	mul.s $f6, $f5, $f1 # f6 contains the 6 exponent.
	mul.s $f7, $f6, $f1 # f7 contains the 7 exponent.
	mul.s $f8, $f7, $f1 # f8 contains the 8 exponent.
	mul.s $f9, $f8, $f1 # f9 contains the 9 exponent.
	lwc1 $f13, threeFactorial
	div.s $f13, $f3, $f13 # f13 contains second term.
	sub.s $f13, $f1, $f13
	lwc1 $f14, fiveFactorial
	div.s $f14, $f5, $f14
	add.s $f13, $f13, $f14
	lwc1 $f14, sevenFactorial
	div.s $f14, $f7, $f14
	sub.s $f13, $f13, $f14
	lwc1, $f14, nineFactorial
	div.s $f14, $f9, $f14
	add.s $f13, $f13, $f14
	mov.s $f13, %freg
.end_macro
.macro cos (%freg)
	findAngle
	convertRadian
	lwc1 $f1, 108($sp)
	mul.s $f2, $f1, $f1 # f2 contains the 2 exponent.
	mul.s $f3, $f2, $f1 # f3 contains the 3 exponent.
	mul.s $f4, $f3, $f1 # f4 contains the 4 exponent.
	mul.s $f5, $f4, $f1 # f5 contains the 5 exponent.
	mul.s $f6, $f5, $f1 # f6 contains the 6 exponent.
	mul.s $f7, $f6, $f1 # f7 contains the 7 exponent.
	mul.s $f8, $f7, $f1 # f8 contains the 8 exponent.
	mul.s $f9, $f8, $f1 # f9 contains the 9 exponent.
	lwc1 $f10, twoFactorial
	div.s $f10, $f2, $f10 # f10 contains second term.
	lwc1 $f11, one
	sub.s $f10, $f11, $f10
	lwc1 $f11, fourFactorial
	div.s $f11, $f4, $f11
	add.s $f10, $f10, $f11
	lwc1 $f11, sixFactorial
	div.s $f11, $f6, $f11
	sub.s $f10, $f10, $f11
	lwc1 $f11, eightFactorial
	div.s $f11, $f8, $f11
	add.s $f10, $f10, $f11
	mov.s $f10, %freg
.end_macro 
askSides:
	printString (sidesMsg)
	inputFloat (100)
	convertInt
	greaterNumCheck (twoFactorial, errorSides)
askLength:
	printString (lengthMsg)
	inputFloat (104)
	convertInt
	checkGreater0 (errorLength)
area:
	cos ($f10)
	sin ($f13)
	div.s $f14, $f13, $f10 # f14 contains the tangent value.
	lwc1 $f15, 104($sp) # Loads length.
	lwc1 $f16, 100($sp) # Loads sides.
	mul.s $f15, $f15, $f15 # Squares length.
	mul.s $f15, $f15, $f16 # Multiplies the square of length by side number.
	lwc1 $f17, four # Loads 4 into f17
	mul.s $f17, $f17, $f14 # Mulitplies 4 by the tangent.
	div.s $f14, $f15, $f17 # Finds the area.
	printString (areaMsg)
	printFloat ($f14)
	printString (unitMsg)
	b end
errorSides:
	error (errSidesMsg, askSides)
errorLength:
	error (errLengthMsg, askLength)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
