# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 2
.data
	conLength: .asciiz "Input contract length in months: "
	avgMonth: .float 30.436875
	avgEquipUse: .asciiz "Input average equipment use in hours per week: "
	fuelCons: .asciiz "Input fuel consumption average in gallons per hour: "
	weeks: .float 4.345
	fuelCos: .asciiz "Input fuel cost in dollars per gallon: "
	dumpNum: .asciiz "Input number of dump trucks used: "
	bullNum: .asciiz "Input number of bulldozers used: "
	earthNum: .asciiz "Input number of earthmovers used: "
	compactorNum: .asciiz "Input number of compactors used: "
	graderNum: .asciiz "Input number of graders used: "
	dumpCos: .asciiz "Input cost of dump truck rental in dollars per month: "
	bullCos: .asciiz "Input cost of bulldozer rental in dollars per month: "
	earthCos: .asciiz "Input cost of earthmover rental in dollars per month: "
	compactorCos: .asciiz "Input cost of compactor rental in dollars per month: "
	graderCos: .asciiz "Input cost of grader rental in dollars per month: "
	errmsg1: .asciiz "Invalid input, number must be greater than 0! \n"
	errmsg2: .asciiz "Invalid input, number must be greater than or equal to 0! \n"
	errmsg3: .asciiz "Invalid input, number must be whole! \n"
	fuel_Cost: .asciiz "Cost of fuel is estimated to be: $"
	rentalCost: .asciiz "Cost of rentals is estimated to be: $"
	totalCost: .asciiz "Total cost of operation is estimated to be: $"
	return: .asciiz " \n"
.text
.macro printString (%string)
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, %string # Tells program to print message.
	syscall # Tells program to exexute.
.end_macro
.macro inputFloat
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
.end_macro
.macro convertInt
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer to convert to t register.
.end_macro
.macro checkGreater0 (%error1)
	lw $t2, 8($sp) # Load for check.
	blez $t2, %error1 # Checks if number is > 0.
.end_macro
.macro checkGreaterEqual0 (%error2)
	lw $t2, 8($sp) # Load for check.
	bltz $t2, %error2 # Checks if number is >= 0.
.end_macro
.macro printInt
	li $v0, 1 # Tells program to get ready to print an integer.
	move $a0, $t0 # Moves specified register into t0 for printing.
	syscall # Execute
	printString (return)
.end_macro
.macro error (%errmsg, %branch)
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, %errmsg # Tells program to print message.
	syscall # Tells program to exexute.
	b %branch
.end_macro
contractLength:
	printString (conLength)
	inputFloat
	convertInt
	checkGreater0 (errorConLength)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, weeks # Loads variable into f3.
	mul.s $f4, $f3, $f2 # Multiplies values and loads into f4.
	mov.s $f20, $f2 # Moves f2 to f20.
equipUse:
	printString (avgEquipUse)
	inputFloat
	convertInt
	checkGreater0 (errorEquipUse)
	lwc1 $f2 4($sp) # Loads from stack pointer into f2.
	mul.s $f5, $f2, $f4 # Multiplies values and loads into f5.
fuelConsumption:
	printString (fuelCons)
	inputFloat
	convertInt
	checkGreater0 (errorFuelCons)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mul.s $f6, $f5, $f2 # Multiplies values and loads into f6.
fuelCost:
	printString (fuelCos)
	inputFloat
	convertInt
	checkGreater0 (errorFuelCost)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mul.s $f7, $f6, $f2 # Multiplies values and loads into f7.
dumpNumber:
	printString (dumpNum)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorDumpNum)
	lwc1 $f8, 4($sp) # Loads from stack into f8.
bullNumber:
	printString (bullNum)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorBullNum)
	lwc1 $f9, 4($sp) # Loads from stack into f9.
earthmoverNumber:
	printString (earthNum)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorEarthNum)
	lwc1 $f10, 4($sp) # Loads from stack into f10.
compactorNumber:
	printString (compactorNum)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorCompactNum)
	lwc1 $f11, 4($sp) # Loads from stack into f11.
graderNumber:
	printString (graderNum)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorGraderNum)
	lwc1 $f12, 4($sp) # Loads from stack into f12.
dumpCost:
	printString (dumpCos)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorDumpCost)
	lwc1 $f13, 4($sp) # Loads from stack into f13.
	mul.s $f13, $f8, $f13 # Multiplies number of vehicles by cost per month.
	mul.s $f13, $f13, $f20 # Multiplies total by number of months.
bulldozerCost:
	printString (bullCos)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorBullCost)
	lwc1 $f14, 4($sp) # Loads from stack into f14.
	mul.s $f14, $f9, $f14 # Multiplies number of vehicles by cost per month.
	mul.s $f14, $f14, $f20 # Multiplies total by number of months.
earthmoverCost:
	printString (earthCos)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorEarthCost)
	lwc1 $f15, 4($sp) # Loads from stack into f15.
	mul.s $f15, $f10, $f15 # Multiplies number of vehicles by cost per month.
	mul.s $f15, $f15, $f20 # Multiplies total by number of months.
compactorCost:
	printString (compactorCos)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorCompactCost)
	lwc1 $f16, 4($sp) # Loads from stack into f16.
	mul.s $f16, $f11, $f16 # Multiplies number of vehicles by cost per month.
	mul.s $f16, $f16, $f20 # Multiplies total by number of months.
graderCost:
	printString (graderCos)
	inputFloat
	convertInt
	checkGreaterEqual0 (errorGraderCost)
	lwc1 $f17, 4($sp) # Loads from stack into f17.
	mul.s $f17, $f12, $f17 # Multiplies number of vehicles by cost per month.
	mul.s $f17, $f17, $f20 # Multiplies total by number of months.
calculations:
	add.s $f18, $f8, $f9 # Adds dump truck number to bulldozer number.
	add.s $f19, $f10, $f11 # Adds earthmover number to compactor number.
	add.s $f18, $f18, $f19 # Adds all four up.
	add.s $f18, $f18, $f12 # Adds grader number to total.
	mul.s $f18, $f18, $f7 # Multiplies number of equipment by fuel cost per vehicle.
	add.s $f13, $f13, $f14 # Adds dump truck total to bulldozer total.
	add.s $f15, $f15, $f16 # Adds earthmover total to compactor total.
	add.s $f13, $f13, $f15 # Adds all four up.
	add.s $f13, $f13, $f17 # Adds grader total to total cost.
	add.s $f14, $f18, $f13 # Adds rental cost to fuel cost.
result:
	printString (return)
	printString (fuel_Cost)
	cvt.w.s $f18, $f18
	swc1 $f18, 0($sp)
	lw $t0, 0($sp)
	printInt
	printString (rentalCost)
	cvt.w.s $f13, $f13
	swc1 $f13, 4($sp)
	lw $t0, 4($sp)
	printInt
	printString (totalCost)
	cvt.w.s $f14, $f14
	swc1 $f14, 8($sp)
	lw $t0 8($sp)
	printInt
b end
errorConLength:
	error (errmsg1, contractLength)
errorEquipUse:
	error (errmsg1, equipUse)
errorFuelCons:
	error (errmsg1, fuelConsumption)
errorFuelCost:
	error (errmsg1, fuelCost)
errorDumpNum:
	error (errmsg2, dumpNumber)
errorBullNum:
	error (errmsg2, bullNumber)
errorEarthNum:
	error (errmsg2, earthmoverNumber)
errorCompactNum:
	error (errmsg2, compactorNumber)
errorGraderNum:
	error (errmsg2, graderNumber)
errorDumpCost:
	error (errmsg1, dumpCost)
errorBullCost:
	error (errmsg1, bulldozerCost)
errorEarthCost:
	error (errmsg1, earthmoverCost)
errorCompactCost:
	error (errmsg1, compactorCost)
errorGraderCost:
	error (errmsg1, graderCost)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
	
