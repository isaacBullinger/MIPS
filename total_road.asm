# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 4
.data
	askMsg: .asciiz "Input operation to be performed (R for Roadway, E for Equipment, L for Labor, or T for Total): "
	flag: .word 1
	reset: .word 0
	rMsg: .asciiz "Executing roadway program: \n"
	eMsg: .asciiz "Executing equipment program: \n"
	lMsg: .asciiz "Executing labor program: \n"
	tMsg: .asciiz "Executing total program: \n"
	R: .word 82 # Value of the letter R
	E: .word 69 # Value of the letter E
	L: .word 76 # Value of the letter L
	T: .word 84 # Value of the letter T
	errMsg5: .asciiz "Invalid character, must input R, E, L, or T (case sensitive)! \n"
	totalMsg: .asciiz "The total cost of the operation is estimated to be: $"
################################################################################################
	lengthm: .asciiz "Input road length in miles: "
	yds: .float 1760
	depthm: .asciiz "Input road depth in inches: "
	dyds: .float 36
	widthm: .asciiz "Input lane width in feet: "
	feet: .float 3
	lanesm: .asciiz "Input number of lanes: "
	conCostm: .asciiz "Input concrete cost in dollars per cubic yard: "
	gravCostm: .asciiz "Input gravel cost in dollars per cubic yard: "
	clayCostm: .asciiz "Input clay cost in dollars per cubic yard: "
	conPercentm: .asciiz "Input percent concrete out of 100 (ex:25): "
	gravPercentm: .asciiz "Input percent gravel out of 100 (ex:25): "
	clayPercentm: .asciiz "Input percent clay out of 100 (ex:25): "
	oneHundredf: .float 100
	oneHundredw: .word 100
	errMsg1: .asciiz "Invalid input, number must be greater than 0! \n"
	errMsg2: .asciiz "Invalid input, number must be greater than 0 but less than 100! \n"
	errMsg3: .asciiz "Invalid inputs, total of percentages entered must be equal to 100! \n"
	roadCost: .asciiz "Road cost is estimated to be: $"
################################################################################################
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
	errMsg4: .asciiz "Invalid input, number must be greater than or equal to 0! \n"
	fuel_Cost: .asciiz "Cost of fuel is estimated to be: $"
	rentalCost: .asciiz "Cost of rentals is estimated to be: $"
	equipCost: .asciiz "Cost of equipment is estimated to be: $"
	return: .asciiz " \n"
################################################################################################
	year: .float 12
	manYear: .float 2080
	laborNum: .asciiz "Input number of laborers: "
	equipOperatorNum: .asciiz "Input number of operators: "
	ironworkerNum: .asciiz "Input number of ironworkers: "
	supervisorNum: .asciiz "Input number of supervisors: "
	laborerCos: .asciiz "Input pay of laborer in dollars per hour: "
	equipOperatorCos: .asciiz "Input pay of equipment operator in dollars per hour: "
	ironworkerCos: .asciiz "Input pay of ironworker in dollars per hour: "
	supervisorCos: .asciiz "Input pay of supervisor in dollars per hour: "
	labor_Cost: .asciiz "Cost of laborers is estimated to be: $"
	equipOperator_Cost: .asciiz "Cost of equipment operators is estimated to be: $"
	ironworker_Cost: .asciiz "Cost of ironworkers is estimated to be: $"
	supervisor_Cost: .asciiz "Cost of supervisors is estimated to be: $"
	laborCost: .asciiz "Cost of workers is estimated to be: $"
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
	move $a0, $t0 # Moves specified register into t0 for printing.
	syscall # Execute
	printString (return)
.end_macro
.macro error (%errMsg, %branch)
	printString (%errMsg)
	b %branch
.end_macro
.macro greaterNumCheck (%number, %branch)
	lwc1 $f1, %number # Load 100 into f1.
	cvt.w.s $f2, $f1 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t2, $t3, %branch # Checks if number is > %number.
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
.macro loadVar (%var)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, %var # Loads variable into f3.
.end_macro
.macro runFlag (%branch)
	lw $t1, 100($sp) # Load flag
	lw $t2, flag # Check to see if flag is set
	beq $t1, $t2, %branch # Flag set, branch to next.
.end_macro
.macro compareChar (%letter, %branch)
	lw $t1, 4($sp) # Load for compare
	lw $t2, %letter # Load variable for letter.
	beq $t1, $t2, %branch
.end_macro
.macro readChar
	li $v0, 12 # Tells program to get ready to read a character.
	syscall # Execute
	sw $v0, 4($sp) # Save character read onto stack
.end_macro
askOperation:
	lw $t1, reset
	sw $t1, 100($sp) # reset the flag 
	printString (askMsg)
	readChar
	compareChar (R, roadway)
	compareChar (E, equipment)
	compareChar (L, labor)
	lw $t2, T # check for letter T
	beq $t1, $t2, totalOp
	b errorChar
totalOp:
	printString (return)
	printString (tMsg)
	lw $t1, flag
	sw $t1, 100($sp) # set flag for total
	b roadway
total:
	lw $t4, 40($sp)
	lw $t5, 44($sp)
	lw $t6, 48($sp)
	add $t4, $t4, $t5
	add $t0, $t4, $t6
	printString (return)
	printString (totalMsg)
	printInt
b end
roadway:
	printString (return)
	printString (rMsg)
length:
	procedure1 (lengthm, errorLength)
	loadVar (yds)
	mul.s $f4, $f3, $f2 # Multiplies values and loads into f4.
depth:
	procedure1 (depthm, errorDepth)
	loadVar (dyds)
	div.s $f5, $f2, $f3 # Divides values and loads into f5.
width:	
	procedure1 (widthm, errorWidth)
	loadVar (feet)
	div.s $f6, $f2, $f3 # Multiplies values and loads into f6.
lanes:
	procedure1 (lanesm, errorLanes)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mov.s $f3, $f6 # Loads f6 into f3.
	mul.s $f7, $f3, $f2 # Multiplies values and loads into f7.
conCost:
	procedure1 (conCostm, errorCon)
	lwc1 $f8, 4($sp) # Loads from stack into f8.
gravCost:
	procedure1 (gravCostm, errorGrav)
	lwc1 $f9, 4($sp) # Loads from stack into f9.
clayCost:
	procedure1 (clayCostm, errorClay)
	lwc1 $f10, 4($sp) # Loads from stack into f10.
conPercent:
	procedure1 (conPercentm, errorConp)
	greaterNumCheck (oneHundredf, errorConp)
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f11, $f2, $f1 # Divides values and loads into f11.
gravPercent:
	procedure1 (gravPercentm, errorGravp)
	greaterNumCheck (oneHundredf, errorGravp)
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f12, $f2, $f1 # Divides values and loads into f12.
clayPercent:
	procedure1 (clayPercentm, errorClayp)
	greaterNumCheck (oneHundredf, errorClayp)
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f13, $f2, $f1 # Divides values and loads into f13.
totalPercent:
	add.s $f14, $f11, $f12 # Adds values and puts it in f14.
	add.s $f15, $f14, $f13 # Adds values and puts it in f15.
	lwc1 $f14, oneHundredf # Loads 100. into f14.
	mul.s $f16, $f14, $f15 # Multipiles values to convert to percent in integers.
	cvt.w.s $f20, $f16 # Converts to integer.
	swc1 $f20, 20($sp) # Loads into stack to convert to t register.
	lw $t3, 20($sp) # Loads from stack into t register.
	lw $t4, oneHundredw # Loads 100 integer into register.
	bne $t3, $t4, errTotalPercent # Checks the total to see if it is 100%.
calculationsRoad:
	mul.s $f4, $f4, $f5 # Multiplies length and depth.
	mul.s $f4, $f4, $f7 # Multiplies length depth and width.
	mul.s $f5, $f4, $f11 # Multiplies concrete percentage by total cubic yards.
	mul.s $f6, $f4, $f12 # Miltiplies gravel percentage by total cubic yards.
	mul.s $f7, $f4, $f13 # Multiplies clay percentage by total cubic yards.
	mul.s $f5, $f5, $f8 # Multiplies cubic yards of concrete by cost per cubic yard.
	mul.s $f6, $f6, $f9 # Multiplies cubic yards of gravel by cost per cubic yard.
	mul.s $f7, $f7, $f10 # Multiplies cubic yards of clay by cost per cubic yard.
	add.s $f5, $f5, $f6 # Adds concrete cost to gravel cost.
	add.s $f29, $f5, $f7 # Adds clay cost to total.
resultRoad:
	printString (return)
	printString (roadCost)
	cvt.w.s $f29, $f29
	swc1 $f29, 0($sp)
	lw $t0, 0($sp)
	printInt
	sw $t0, 40($sp)
	runFlag (equipment)
b end
equipment:
	printString (return)
	printString (eMsg)
contractLength:
	procedure1 (conLength, errorConLength)
	loadVar (weeks)
	mul.s $f4, $f3, $f2 # Multiplies values and loads into f4.
	mov.s $f20, $f2 # Moves f2 to f20.
equipUse:
	procedure1 (avgEquipUse, errorEquipUse)
	lwc1 $f2 4($sp) # Loads from stack pointer into f2.
	mul.s $f5, $f2, $f4 # Multiplies values and loads into f5.
fuelConsumption:
	procedure1 (fuelCons, errorFuelCons)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mul.s $f6, $f5, $f2 # Multiplies values and loads into f6.
fuelCost:
	procedure1 (fuelCos, errorFuelCost)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mul.s $f7, $f6, $f2 # Multiplies values and loads into f7.
dumpNumber:
	procedure2 (dumpNum, errorDumpNum)
	lwc1 $f8, 4($sp) # Loads from stack into f8.
bullNumber:
	procedure2 (bullNum, errorBullNum)
	lwc1 $f9, 4($sp) # Loads from stack into f9.
earthmoverNumber:
	procedure2 (earthNum, errorEarthNum)
	lwc1 $f10, 4($sp) # Loads from stack into f10.
compactorNumber:
	procedure2 (compactorNum, errorCompactNum)
	lwc1 $f11, 4($sp) # Loads from stack into f11.
graderNumber:
	procedure2 (graderNum, errorGraderNum)
	lwc1 $f12, 4($sp) # Loads from stack into f12.
dumpCost:
	procedure2 (dumpCos, errorDumpCost)
	lwc1 $f13, 4($sp) # Loads from stack into f13.
	mul.s $f13, $f8, $f13 # Multiplies number of vehicles by cost per month.
	mul.s $f13, $f13, $f20 # Multiplies total by number of months.
bulldozerCost:
	procedure2 (bullCos, errorBullCost)
	lwc1 $f14, 4($sp) # Loads from stack into f14.
	mul.s $f14, $f9, $f14 # Multiplies number of vehicles by cost per month.
	mul.s $f14, $f14, $f20 # Multiplies total by number of months.
earthmoverCost:
	procedure2 (earthCos, errorEarthCost)
	lwc1 $f15, 4($sp) # Loads from stack into f15.
	mul.s $f15, $f10, $f15 # Multiplies number of vehicles by cost per month.
	mul.s $f15, $f15, $f20 # Multiplies total by number of months.
compactorCost:
	procedure2 (compactorCos, errorCompactCost)
	lwc1 $f16, 4($sp) # Loads from stack into f16.
	mul.s $f16, $f11, $f16 # Multiplies number of vehicles by cost per month.
	mul.s $f16, $f16, $f20 # Multiplies total by number of months.
graderCost:
	procedure2 (graderCos, errorGraderCost)
	lwc1 $f17, 4($sp) # Loads from stack into f17.
	mul.s $f17, $f12, $f17 # Multiplies number of vehicles by cost per month.
	mul.s $f17, $f17, $f20 # Multiplies total by number of months.
calculationsEquip:
	add.s $f18, $f8, $f9 # Adds dump truck number to bulldozer number.
	add.s $f19, $f10, $f11 # Adds earthmover number to compactor number.
	add.s $f18, $f18, $f19 # Adds all four up.
	add.s $f18, $f18, $f12 # Adds grader number to total.
	mul.s $f18, $f18, $f7 # Multiplies number of equipment by fuel cost per vehicle.
	add.s $f13, $f13, $f14 # Adds dump truck total to bulldozer total.
	add.s $f15, $f15, $f16 # Adds earthmover total to compactor total.
	add.s $f13, $f13, $f15 # Adds all four up.
	add.s $f13, $f13, $f17 # Adds grader total to total cost.
	add.s $f30, $f18, $f13 # Adds rental cost to fuel cost.
resultEquip:
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
	printString (equipCost)
	cvt.w.s $f30, $f30
	swc1 $f30, 8($sp)
	lw $t0 8($sp)
	printInt
	sw $t0, 44($sp)
	runFlag (labor)
b end
labor:
	printString (return)
	printString (lMsg)
ContractLength:
	procedure1 (conLength, errorContractLength)
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, year # Loads variable into f3.
	div.s $f4, $f2, $f3 # Divides values and loads into f4.
	lwc1 $f3, manYear # Loads variable into f3.
	mul.s $f4, $f4, $f3 # Multiplies values and loads into f4.
laborerNumber:
	procedure1 (laborNum, errorLaborerNum)
	lwc1 $f5, 4($sp) # Loads from stack into f5.
equipmentOperatorNumber:
	procedure1 (equipOperatorNum, errorEquipOperatorNum)
	lwc1 $f6, 4($sp) # Loads from stack into f6.
ironworkerNumber:
	procedure1 (ironworkerNum, errorIronworkerNum)
	lwc1 $f7, 4($sp) # Loads from stack into f7.
supervisorNumber:
	procedure1 (supervisorNum, errorSupervisorNum)
	lwc1 $f8, 4($sp) # Loads from stack into f8.
laborerCost:
	procedure1 (laborerCos, errorLaborerCost)
	lwc1 $f9, 4($sp) # Loads from stack into f9.
	mul.s $f5, $f4, $f5 # Multiplies man years by years and number of workers.
	mul.s $f5, $f5, $f9 # Multiplies total by pay per hour.
equipmentOperatorCost:
	procedure1 (equipOperatorCos, errorEquipOperatorCost)
	lwc1 $f10, 4($sp) # Loads from stack into f10.
	mul.s $f6, $f4, $f6 # Multiplies man years by years and number of workers.
	mul.s $f6, $f6, $f10 # Multiplies total by pay per hour.
ironworkerCost:
	procedure1 (ironworkerCos, errorIronworkerCost)
	lwc1 $f11, 4($sp) # Loads from stack into f11.
	mul.s $f7, $f4, $f7 # Multiplies man years by years and number of workers.
	mul.s $f7, $f7, $f11 # Multiplies total by pay per hour.
supervisorCost:
	procedure1 (supervisorCos, errorSupervisorCost)
	lwc1 $f12, 4($sp) # Loads from stack into f12.
	mul.s $f8, $f4, $f8 # Multiplies man years by years and number of workers.
	mul.s $f8, $f8, $f12 # Multiplies total by pay per hour.
calculationsLabor:
	add.s $f9, $f5, $f6 # Adds laborers cost to equipment operator cost.
	add.s $f10, $f7, $f8 # Adds ironworker cost to supervisor cost
	add.s $f31, $f9, $f10 # Adds to total.
resultLabor:
	printString (return)
	printString (labor_Cost)
	cvt.w.s $f5, $f5
	swc1 $f5, 4($sp)
	lw $t0, 4($sp)
	printInt
	printString (equipOperator_Cost)
	cvt.w.s $f6, $f6
	swc1 $f6, 4($sp)
	lw $t0, 4($sp)
	printInt
	printString (ironworker_Cost)
	cvt.w.s $f7, $f7
	swc1 $f7, 4($sp)
	lw $t0, 4($sp)
	printInt
	printString (supervisor_Cost)
	cvt.w.s $f8, $f8
	swc1 $f8, 4($sp)
	lw $t0, 4($sp)
	printInt
	printString (laborCost)
	cvt.w.s $f31, $f31
	swc1 $f31, 4($sp)
	lw $t0, 4($sp)
	printInt
	sw $t0, 48($sp)
	runFlag (total)
b end
errorChar:
	printString (return)
	error (errMsg5, askOperation)
################################################	
errorLength:
	error (errMsg1, length)
errorDepth:
	error (errMsg1, depth)
errorWidth:
	error (errMsg1, width)
errorLanes:
	error (errMsg1, lanes)
errorCon:
	error (errMsg1, conCost)
errorGrav:
	error (errMsg1, gravCost)
errorClay:
	error (errMsg1, clayCost)
errorConp:
	error (errMsg2, conPercent)
errorGravp:
	error (errMsg2, gravPercent)
errorClayp:
	error (errMsg2, clayPercent)
errTotalPercent:
	error (errMsg3, conPercent)
################################################
errorConLength:
	error (errMsg1, contractLength)
errorEquipUse:
	error (errMsg1, equipUse)
errorFuelCons:
	error (errMsg1, fuelConsumption)
errorFuelCost:
	error (errMsg1, fuelCost)
errorDumpNum:
	error (errMsg2, dumpNumber)
errorBullNum:
	error (errMsg2, bullNumber)
errorEarthNum:
	error (errMsg2, earthmoverNumber)
errorCompactNum:
	error (errMsg2, compactorNumber)
errorGraderNum:
	error (errMsg2, graderNumber)
errorDumpCost:
	error (errMsg1, dumpCost)
errorBullCost:
	error (errMsg1, bulldozerCost)
errorEarthCost:
	error (errMsg1, earthmoverCost)
errorCompactCost:
	error (errMsg1, compactorCost)
errorGraderCost:
	error (errMsg1, graderCost)
################################################	
errorContractLength:
	error (errMsg1, ContractLength)
errorLaborerNum:
	error (errMsg1, laborerNumber)
errorEquipOperatorNum:
	error (errMsg1, equipmentOperatorNumber)
errorIronworkerNum:
	error (errMsg1, ironworkerNumber)
errorSupervisorNum:
	error (errMsg1, supervisorNumber)
errorLaborerCost:
	error (errMsg1, laborerCost)
errorEquipOperatorCost:
	error (errMsg1, equipmentOperatorCost)
errorIronworkerCost:
	error (errMsg1, ironworkerCost)
errorSupervisorCost:
	error (errMsg1, supervisorCost)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
