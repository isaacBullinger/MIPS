# Isaac Bullinger
# isaac.bullinger@nwc.edu
# Homework 1
.data
	lengthm: .asciiz "Input road length in miles: "
	yds: .float 1760
	depthm: .asciiz "Input road depth in inches: "
	dyds: .float 36
	widthm: .asciiz "Input lane width in feet: "
	feet: .float 3
	lanesm: .asciiz "Input number of lanes: "
	concostm: .asciiz "Input concrete cost in dollars per cubic yard: "
	gravcostm: .asciiz "Input gravel cost in dollars per cubic yard: "
	claycostm: .asciiz "Input clay cost in dollars per cubic yard: "
	conpercentm: .asciiz "Input percent concrete out of 100 (ex:25): "
	gravpercentm: .asciiz "Input percent gravel out of 100 (ex:25): "
	claypercentm: .asciiz "Input percent clay out of 100 (ex:25): "
	onehundredf: .float 100
	onehundredw: .word 100
	errmsg1: .asciiz "Invalid input, number must be greater than 0! \n"
	errmsg2: .asciiz "Invalid input, number must be greater than 0 but less than 100! \n"
	errmsg3: .asciiz "Invalid inputs, total of percentages entered must be equal to 100! \n"
	road_cost: .asciiz "Road cost is estimated to be: $"
.text
length:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, lengthm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer to convert to t register.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorlength # Checks if number is > 0.
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, yds # Loads variable into f3.
	mul.s $f4, $f3, $f2 # Multiplies values and loads into f4.
depth:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, depthm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errordepth # Checks if number is > 0.
	lwc1 $f2 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, dyds # Loads variable into f3.
	div.s $f5, $f2, $f3 # Divides values and loads into f5.
width:	
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, widthm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorwidth # Checks if number is > 0.
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	lwc1 $f3, feet # Loads variable into f3.
	div.s $f6, $f2, $f3 # Multiplies values and loads into f6.
lanes:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, lanesm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorlanes # Checks if number is > 0.
	lwc1 $f2, 4($sp) # Loads from stack pointer into f2.
	mov.s $f3, $f6 # Loads f6 into f3.
	mul.s $f7, $f3, $f2 # Multiplies values and loads into f7.
concost:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, concostm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorcon # Checks if number is > 0.
	lwc1 $f8, 4($sp) # Loads from stack into f8.
gravcost:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, gravcostm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorgrav # Checks if number is > 0.
	lwc1 $f9, 4($sp) # Loads from stack into f9.
claycost:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, claycostm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Save length in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorclay # Checks if number is > 0.
	lwc1 $f10, 4($sp) # Loads from stack into f10.
conpercent:
	li  $v0, 4 # Tells program to get ready to print string.
	la $a0, conpercentm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Saves number in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorconp # Checks if number is > 0.
	lwc1 $f1, onehundredf # Load 100 into f1.
	cvt.w.s $f2, $f1 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t2, $t3, errorconp # Checks if number is > 100.
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f11, $f2, $f1 # Divides values and loads into f11.
gravpercent:
	li  $v0, 4 # Tells program to get ready to print string.
	la $a0, gravpercentm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Saves number in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorgravp # Checks if number is > 0.
	lwc1 $f1, onehundredf # Load 100 into f1.
	cvt.w.s $f2, $f1 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t2, $t3, errorgravp # Checks if number is > 100.
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f12, $f2, $f1 # Divides values and loads into f12.
claypercent:
	li  $v0, 4 # Tells program to get ready to print string.
	la $a0, claypercentm # Tells program to print message.
	syscall # Tells program to exexute.
	li $v0, 6 # Lets user input float.
	syscall # Tells program to exexute.
	swc1 $f0, 4($sp) # Saves number in stack.
	cvt.w.s $f1, $f0 # Convert to integer.
	swc1 $f1, 8($sp) # Save in stack pointer temporarily.
	lw $t2, 8($sp) # Load for check.
	blez $t2, errorclayp # Checks if number is > 0.
	lwc1 $f1, onehundredf # Load 100 into f1.
	cvt.w.s $f2, $f1 # Convert to integer.
	swc1 $f2, 12($sp) # Load f1 into stack.
	lw $t2, 8($sp) # Move from stack into t2.
	lw $t3, 12($sp) # Move from stack into t3.
	bgt $t2, $t3, errorclayp # Checks if number is > 100.
	lwc1 $f2, 4($sp) # Loads from stack.
	div.s $f13, $f2, $f1 # Divides values and loads into f13.
totalpercent:
	add.s $f14, $f11, $f12 # Adds values and puts it in f14.
	add.s $f15, $f14, $f13 # Adds values and puts it in f15.
	lwc1 $f14, onehundredf # Loads 100. into f14.
	mul.s $f16, $f14, $f15 # Multipiles values to convert to percent in integers.
	cvt.w.s $f20, $f16 # Converts to integer.
	swc1 $f20, 20($sp) # Loads into stack to convert to t register.
	lw $t3, 20($sp) # Loads from stack into t register.
	lw $t4, onehundredw # Loads 100 integer into register.
	bne $t3, $t4, errtotalpercent # Checks the total to see if it is 100%.
calculations:
	mul.s $f4, $f4, $f5 # Multiplies length and depth.
	mul.s $f4, $f4, $f7 # Multiplies length depth and width.
	mul.s $f5, $f4, $f11 # Multiplies concrete percentage by total cubic yards.
	mul.s $f6, $f4, $f12 # Miltiplies gravel percentage by total cubic yards.
	mul.s $f7, $f4, $f13 # Multiplies clay percentage by total cubic yards.
	mul.s $f5, $f5, $f8 # Multiplies cubic yards of concrete by cost per cubic yard.
	mul.s $f6, $f6, $f9 # Multiplies cubic yards of gravel by cost per cubic yard.
	mul.s $f7, $f7, $f10 # Multiplies cubic yards of clay by cost per cubic yard.
	add.s $f5, $f5, $f6 # Adds concrete cost to gravel cost.
	add.s $f5, $f5, $f7 # Adds clay cost to total.
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, road_cost #Tells program to print message.
	syscall # Execute
	cvt.w.s $f5, $f5
	swc1 $f5, 4($sp)
	lw $t0, 4($sp)
	li $v0, 1 # Tells program to get ready to print an integer.
	move $a0, $t0
	syscall # Execute
b end
errorlength:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to exexute.
	b length
errordepth:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to exexute.
	b depth
errorwidth:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to exexute.
	b width
errorlanes:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to exexute.
	b lanes
errorcon:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to execute.
	b concost
errorgrav:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to execute.
	b gravcost
errorclay:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg1 # Tells program to print message.
	syscall # Tells program to execute.
	b claycost
errorconp:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg2 # Tells program to print message.
	syscall # Tells program to execute.
	b conpercent
errorgravp:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg2 # Tells program to print message.
	syscall # Tells program to execute.
	b gravpercent
errorclayp:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg2 # Tells program to print message.
	syscall # Tells program to execute.
	b claypercent
errtotalpercent:
	li $v0, 4 # Tells program to get ready to print string.
	la $a0, errmsg3 # Tells program to print message.
	syscall # Tells program to execute.
	b conpercent
end:
li $v0, 10 # Tells program to end.
syscall # Tells program to execute.
	
