	AREA	IntegerDisplay, CODE, READONLY
	IMPORT	main

	EXPORT	start
start
	LDR R0, =-123456			;load test value
	CMP R0, #0				;if(testvalue<0){
	BGT notNegative			;boolean isNegative=1;
	LDR R8, =1				;testvalue=testvalue*-1;
	NEG R0, R0				;}
notNegative	
	BL digitise				;digitise(testValue)
					


IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C

	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register
	
	
	
infiniteloop				;while(true){
	LDR R4, =DIGITS			;load start address of digits
	BL clearLED			;clearLED();
	BL delay			;delay();
	CMP R8, #1			;if(isNegative){
	BNE positive			;displayCode=1011;
	LDR R3, =0x000D0000		;}
	B negative			;else{
positive				;displayCode=1010;
	LDR R3, =0x00050000		;}
negative	
	STR R3, [R2]			;set LED display 
	BL delay			;delay();
digitLoop				;while(digit!=0xE){
	LDR R5, [R4], #4		;load digit and increment the address value by 4 (to go to next digit)
	CMP R5, #0xE			;
	BEQ endDigitL			;
	BL clearLED			;clearLED()
	LDR R10, =3			;inversionCount=3;
	LDR R6, =0			;invertedDigit=0;
invert					;while(inversionCount>0){
	LDR R9, =1			;mask=1;
	AND R9, R5, R9			;mask=digit & mask;
	ORR R6, R6, R9			;invertedValue=ivertedValue | mask;
	CMP R10, #0				
	BEQ endInvert
	MOV R5, R5, LSR#1		;digit=digit>>1;
	MOV R6, R6, LSL#1		;invertedValue=invertedValue<<1;
	SUB R10, R10, #1		;inversionCount--;
	B invert				
endInvert				;}
	MOV R6, R6, LSL#16
	STR R6, [R2]			;set LED display
	BL delay			;delay();
	B digitLoop
endDigitL				;}
	B infiniteloop			;}

stop	B	stop

clearLED
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =0x000F0000		;load diplayCode
	STR R4, [R1]			;clear LEDs
	LDMFD SP!, {R4, PC}		;load registers from stack

delay
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =20000000		;delaycount=20000000 
dloop					;while(delaycount>0){
	SUBS R4, R4, #1			;delaycount--;
	BNE dloop				;}
	LDMFD SP!, {R4, PC}		;load registers from stack
	
	
;Parameters
;R0:Numerator
;R1:Denominator
;Return values
;R2:Quotient 
;R3:Remainder
divide			
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R2, =0			;quotient=0;
	LDR R4, =REMAINDER		;load address of REMAINDER (needed for when dealing with large numbers)
	STR R0, [R4]			;Store Numerator in REMAINDER memory address
	LDR R3, [R4]			;Remainder=REMAINDER i.e. the numerator (we do this to take in to account large numbers
					;that cannot be MOVed)
while					;while(Numerator>=Denominator){
	CMP R0, R1				
	BLT endwh				
	SUB R3, R0, R1			;Remainder=Numerator-Denominator;
	STR R3, [R4]			;REMAINDER=Remainder
	LDR R0, [R4]			;Numerator=REMAINDER
	ADD R2, R2, #1			;Quotient++;
	B while
endwh					;}
	LDMFD SP!, {R4, PC}		;load registers from stack
	
;Parameters
;R0:Integer to be digitised
digitise
	STMFD SP!, {R4-R8, LR}		;save registers to stack
	LDR R4,=EXPONENTS		;load start memory address of EXPONENTS
	LDR R5, =DIGITS			;load start memory address of DIGITS
	LDR R6, =REMAINDER		;load start memory address of REMAINDER
	LDR R1, [R4]			;Denominator=currentExponent;
	LDR R7, =9			;exponentCount=9;
	LDR R8, =0			;	
whileDigitisable
	CMP R7, #0
	BLE endwhDigitisable
	BL divide
	CMP R2, #0
	BNE noConvert
	LDR R2, =0xF
noConvert	
	BEQ noNumber
	MOV R8, #1
noNumber	
	STR R3, [R6]
	LDR R0, [R6]
	CMP R8, #0
	BEQ noStore
	STR R2, [R5], #4
noStore	
	LDR R1, [R4, #4]!
	SUB R7, R7, #1
	B whileDigitisable
endwhDigitisable
	CMP R3, #0
	BNE notZero
	LDR R3, =0xF
notZero	
	STR R3, [R5], #4
	LDR R8, =0xE
	STR R8, [R5]
	LDMFD SP!, {R4-R8, PC}
	
	AREA	ProgramData, DATA, READWRITE
		
EXPONENTS DCD 1000000000,100000000,10000000,1000000,100000,10000,1000,100,10 
REMAINDER DCD 0
DIGITS DCD 0

	END