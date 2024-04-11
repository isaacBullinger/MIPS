# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 3
.data
	conLength: .asciiz "Input contract length in months: "
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
	errmsg1: .asciiz "Invalid input, number must be greater than 0! \n"
	errmsg2: .asciiz "Invalid input, number must be greater than or equal to 0! \n"
	errmsg3: .asciiz "Invalid input, number must be whole! \n"
	labor_Cost: .asciiz "Cost of laborers is estimated to be: $"
	equipOperator_Cost: .asciiz "Cost of equipment operators is estimated to be: $"
	ironworker_Cost: .asciiz "Cost of ironworkers is estimated to be: $"
	supervisor_Cost: .asciiz "Cost of supervisors is estimated to be: $"
	totalCost: .asciiz "Total cost of workers is estimated to be: $"
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
	lwc1 $f3, year # Loads variable into f3.
	div.s $f4, $f2, $f3 # Divides values and loads into f4.
	lwc1 $f3, manYear # Loads variable into f3.
	mul.s $f4, $f4, $f3 # Multiplies values and loads into f4.
laborerNumber:
	printString (laborNum)
	inputFloat
	convertInt
	checkGreater0 (errorLaborerNum)
	lwc1 $f5, 4($sp) # Loads from stack into f5.
equipmentOperatorNumber:
	printString (equipOperatorNum)
	inputFloat
	convertInt
	checkGreater0 (errorEquipOperatorNum)
	lwc1 $f6, 4($sp) # Loads from stack into f6.
ironworkerNumber:
	printString (ironworkerNum)
	inputFloat
	convertInt
	checkGreater0 (errorIronworkerNum)
	lwc1 $f7, 4($sp) # Loads from stack into f7.
supervisorNumber:
	printString (supervisorNum)
	inputFloat
	convertInt
	checkGreater0 (errorSupervisorNum)
	lwc1 $f8, 4($sp) # Loads from stack into f8.
laborerCost:
	printString (laborerCos)
	inputFloat
	convertInt
	checkGreater0 (errorLaborerCost)
	lwc1 $f9, 4($sp) # Loads from stack into f9.
	mul.s $f5, $f4, $f5 # Multiplies man years by years and number of workers.
	mul.s $f5, $f5, $f9 # Multiplies total by pay per hour.
equipmentOperatorCost:
	printString (equipOperatorCos)
	inputFloat
	convertInt
	checkGreater0 (errorEquipOperatorCost)
	lwc1 $f10, 4($sp) # Loads from stack into f10.
	mul.s $f6, $f4, $f6 # Multiplies man years by years and number of workers.
	mul.s $f6, $f6, $f10 # Multiplies total by pay per hour.
ironworkerCost:
	printString (ironworkerCos)
	inputFloat
	convertInt
	checkGreater0 (errorIronworkerCost)
	lwc1 $f11, 4($sp) # Loads from stack into f11.
	mul.s $f7, $f4, $f7 # Multiplies man years by years and number of workers.
	mul.s $f7, $f7, $f11 # Multiplies total by pay per hour.
supervisorCost:
	printString (supervisorCos)
	inputFloat
	convertInt
	checkGreater0 (errorSupervisorCost)
	lwc1 $f12, 4($sp) # Loads from stack into f12.
	mul.s $f8, $f4, $f8 # Multiplies man years by years and number of workers.
	mul.s $f8, $f8, $f12 # Multiplies total by pay per hour.
calculations:
	add.s $f9, $f5, $f6 # Adds laborers cost to equipment operator cost.
	add.s $f10, $f7, $f8 # Adds ironworker cost to supervisor cost
	add.s $f9, $f9, $f10 # Adds to total.
result:
	printString (return)
	printString (labor_Cost)
	cvt.w.s $f5, $f5
	swc1 $f5, 0($sp)
	lw $t0, 0($sp)
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
	printString (totalCost)
	cvt.w.s $f9, $f9
	swc1 $f9, 8($sp)
	lw $t0 8($sp)
	printInt
b end
errorConLength:
	error (errmsg1, contractLength)
errorLaborerNum:
	error (errmsg1, laborerNumber)
errorEquipOperatorNum:
	error (errmsg1, equipmentOperatorNumber)
errorIronworkerNum:
	error (errmsg1, ironworkerNumber)
errorSupervisorNum:
	error (errmsg1, supervisorNumber)
errorLaborerCost:
	error (errmsg1, laborerCost)
errorEquipOperatorCost:
	error (errmsg1, equipmentOperatorCost)
errorIronworkerCost:
	error (errmsg1, ironworkerCost)
errorSupervisorCost:
	error (errmsg1, supervisorCost)
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
	
