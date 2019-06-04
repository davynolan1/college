AREA	ConsoleInput, CODE, readONLY
 	IMPORT	main
 	IMPORT	getkey
 	IMPORT	sendchar
 	EXPORT	start
	PRESERVE8
 
 ;Mutiplication code
 ;Subtraction code
 ;Addition code
 
 start
 	LDR R3, =0		;Determines whether second perand has been entered or not
 	LDR R4, =0 		;Temporary store for entered numbers
 	LDR R5, =0		;Store for numbers after calculation
 	LDR R6, =10		;Power
 	LDR R7, =1		;Power
	LDR R8, =0 		;R8= second operand
 	LDR R9, =0 		;R9= first operand
 	LDR R10, =0		;R10= operator codes
 	LDR R11, =10	;R11= Multiplier for number inputs
 	LDR R12, =0		;Temporary store for remainder in division
 readNextKey
 					;CONSOLE INPUT
  	BL	getkey		; read next key from console
 	CMP	R0, #0x51  	;
 	BEQ	programQuit	;
 	CMP	R0, #0x71  	;
 	BEQ	programQuit	;
 	CMP	R0, #0x0D  	;
 	BEQ	endRead		;
 	CMP R0, #0x3D	;
 	BEQ endRead		;
 	CMP R0, #0x2B	;
 	BEQ	addExp		;
 	CMP R0, #0x2D	;
	BEQ	subExp		;
 	CMP R0, #0x2A	;
 	BEQ mulExp		;
 	CMP R0, #0x5E	;
 	BEQ powExp		;
 	BL	sendchar	;   
 
 	SUB R0, #0x30	;Ascii >> Number
 	MUL R4, R11, R4
 	ADD R4, R0
 	
 	CMP R10, #0   	;Checks if first operand has been entered			
 	BHI secondOperand
 	MOV R9, R4
 	B readNextKey
 
 secondOperand
 	MOV R8, R4
 	MOV R3, #1
 	B readNextKey	
 	
 endRead
 	CMP R10, #1		
 	BEQ	addExp		
 	CMP R10, #2		
 	BEQ	subExp		
 	CMP R10, #3		
 	BEQ mulExp		
 	CMP R10, #4		
 	BEQ powExp		
 
 					;EXPRESSION EVALUTAION
 addExp
 	BL sendchar
 	LDR R4, =0
 	LDR R10, =1 	
 	CMP R3, #0		
 	BEQ readNextKey
 	ADD R5, R9, R8	
 	B	divFinder
 subExp
 	BL sendchar
 	LDR R4, =0
 	LDR R10, =2
 	CMP R3, #0
 	BEQ readNextKey
 	SUB R5, R9, R8
 	B divFinder
 mulExp
 	BL sendchar
 	LDR R4, =0
 	LDR R10, =3
 	CMP R3, #0
 	BEQ readNextKey
 	MUL R5, R9, R8
 	B	divFinder
 powExp
 	BL sendchar
 	LDR R4, =0
 	LDR R10, =4
 	CMP R3, #0
 	BEQ readNextKey
	MOV R2, R9
 power	
	CMP R8, #0
 	BEQ exponentialZero
 	CMP R8, #1
 	BEQ powerFinished
 	SUB R8, #1
 	MUL R9, R2 ,R9
 	B power
 powerFinished
 	MOV R5, R9
 	B divFinder
 exponentialZero
 	MOV R5, #1
 	B divFinder
 		
 					;Display Result
 divFinder
 	CMP R5, R6
 	BLS endDivFinder
 	ADD R7, #1
 	CMP R7, #9
 	BEQ numTooLarge
 	MUL R6, R11, R6
 	B divFinder
 endDivFinder
 
 nextDigit
 	SUB R7, #1
 	
 numTooLarge
 	MOV R2,  R7
 	LDR R6, =10
 
 divCreator
 	CMP R7, #0
 	BEQ lastDigit
 	CMP R7, #1
 	BEQ endDivCreator
 	CMP R2, #1
 	BEQ endDivCreator
 	MUL R6, R11, R6
 	SUB R2, #1
 	B divCreator
 endDivCreator
 	MOV R12, R5
 	LDR R0, =0

 nthDigit
 	CMP R12, R6
 	BLO endNthDigit
 	ADD R0, #1
	SUB R12, R6
	B nthDigit
 endNthDigit
 
 printDigit
 	ADD R0, #0x30
 	BL sendchar
 	MOV R5, R12
 	B nextDigit
 
 lastDigit
 	MOV R0, R5
 	ADD R0, #0x30
 	BL sendchar
 	B endProgram
 
 endProgram
 		LDR R0, =0x0A
 		BL sendchar
 		B start
 programQuit
 		BL sendchar
 stop	B	stop
 
 	END 