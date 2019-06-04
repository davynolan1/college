	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main



	EXPORT	start

start
	

IO1PIN	EQU 0xE0028010	;memory location of pin status register
IO1DIR	EQU	0xE0028018	
IO1SET	EQU	0xE0028014	
IO1CLR	EQU	0xE002801C	

	LDR R3,=IO1PIN		;load memory location of pin status register to R3
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]			;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]			;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register
	LDR R4, =0 	;num
	LDR R5, =0 	;result
	LDR R6, =0 	;state	(S0=begining, S1=sign input, S2=number input S3=clear op)
	LDR R11, =0	;sign	("1"="+"  "0"="-")
	
	
infiniteloop
	BL shortdelay	;calls short delay function, need a delay between inputs to avoid double clicks
	LDR R0, =0		;pressIndex=0
	BL checkPress	;checkPress(pressIndex)


	CMP R0, #20		;if(key pressed==20){	
	BNE skip2		
	CMP R6, #0		;checking if state==0
	BEQ state00
	CMP R6, #1		;checking if state==1
	BEQ state01
	CMP R6, #2		;checking if state==2
	BEQ state02
	CMP R6, #3		;checking if state==3
	BEQ infiniteloop
state00					;if (state==0){
	ADD R4, R4, #1		;num++
	B infiniteloop		;}
state01					;else if (state==1){
	BL clearLED			;clearLEDs
	ADD R4, R4, #1		;num++
	MOV R6, #2			;state=2
	B infiniteloop		;}
state02					;else if (state==2){
	ADD R4, R4, #1		;num++
	B infiniteloop		;}
						;}	
skip2
	CMP R0, #21			;if(key pressed==21){
	BNE skip3
	CMP R6, #0			;checking if state==0
	BEQ state10
	CMP R6, #1			;checking if state==1
	BEQ state11
	CMP R6, #2			;checking if state==2
	BEQ state12
	CMP R6, #3			;checking if state==3
	BEQ infiniteloop
state10					;if (state==0){
	SUB R4, R4, #1		;num--
	B infiniteloop		;}
state11					;else if (state==1){
	BL clearLED			;clearLEDs
	SUB R4, R4, #1		;num--
	MOV R6, #2			;state=2
	B infiniteloop		;}
state12					;else if (state==2){
	SUB R4, R4, #1		;num++
	B infiniteloop		;}
						;}
	
	
skip3					;if(key pressed==22){
	CMP R0, #22		
	BNE skip4
	CMP R6, #0
	BEQ state20
	CMP R6, #1
	BEQ infiniteloop
	CMP R6, #2
	BEQ state22
	CMP R6, #3
	BEQ state23
state20					;if (state==0){
	MOV R5, R4			;result=num
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	MOV R11, #1			;sign=+
	B infiniteloop		;}
state22					;else if (state==2){
	CMP R11, #1			;if (sign==-){
	BEQ additionA		
	SUB R5, R5, R4		;result=result-num
	B subtractionA		;}
additionA				;else{
	ADD R5, R5, R4		;result=result+num
subtractionA			;}
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	LDR R7, =4			;inversionCount=4;
	LDR R8, =0			;invertedDigit=0;
	MOV R9, R5			;tmp=result
invertA					;while(inversionCount>0){
	CMP R7, #0
	BEQ endInvertA
	MOVS R9, R9, LSR#1	;tmp=tmp>>1
	BCC nobitA			;if(carry flag set){
	ORR R8, R8, #1		;result || 1
nobitA					;}
	MOV R8, R8, LSL#1	;result=result<<1
	SUB R7, R7, #1		;inversionCount--;
	B invertA				
endInvertA				;}
	MOV R8, R8, LSL#15	;result=result<<15
	STR R8, [R2]		;set LED display
	MOV R11, #1			;sign=+
	B infiniteloop		;}
state23					;else if (state==3){
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	MOV R11, #1			;sign=+
	B infiniteloop		;}
						;}
	
skip4	
	CMP R0, #23			 
	BNE skip5
	CMP R6, #0
	BEQ state30
	CMP R6, #1
	BEQ infiniteloop
	CMP R6, #2
	BEQ state32
	CMP R6, #3
	BEQ state33	
state30					;if (state==0){
	MOV R5, R4			;result=num
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	MOV R11, #0			;sign=-
	B infiniteloop		;}
state32					;else if (state==2){
	CMP R11, #1			;if (sign==-){
	BEQ additionB
	SUB R5, R5, R4		;result=result-num
	B subtractionB		;}
additionB				;else{
	ADD R5, R5, R4		;result=result+num
subtractionB			;}
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	LDR R7, =4			;inversionCount=4;
	LDR R8, =0			;invertedDigit=0;
	MOV R9, R5			;tmp=result
invertB					;while(inversionCount>0){
	CMP R7, #0
	BEQ endInvertB
	MOVS R9, R9, LSR#1	;tmp=tmp>>1
	BCC nobitB			;if(carry flag set){
	ORR R8, R8, #1		;result || 1
nobitB					;}
	MOV R8, R8, LSL#1	;result=result<<1
	SUB R7, R7, #1		;inversionCount--;
	B invertB				
endInvertB				;}
	MOV R8, R8, LSL#15	;result=result<<15
	STR R8, [R2]		;set LED display
	MOV R11, #0			;sign=-
	B infiniteloop		;}
state33					;else if (state==3){
	MOV R4, #0			;num=0
	MOV R6, #1			;state=1
	MOV R11, #0			;sign=-
	B infiniteloop		;}
						;}
skip5	
	CMP R0, #-22
	BNE skip6
	BL flashLEDC
	CMP R6, #0
	BEQ state40
	CMP R6, #1
	BEQ state41
	CMP R6, #2
	BEQ state42
	CMP R6, #3
	BEQ infiniteloop
state40
	MOV R4, #0
	B infiniteloop
state41
	MOV R4, #0
	MOV R6, #3
	B infiniteloop
state42
	MOV R4, #0
	MOV R6, #3
	B infiniteloop
	
	
skip6	
	CMP R0, #-23
	BNE infiniteloop
	BL flashLEDCA
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV R11, #0
	B infiniteloop
	
stop	B	stop

flashLEDCA
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =0x000F0000		;load diplayCode
	STR R4, [R2]			;clear LEDs
	BL shortdelay
	BL clearLED
	LDMFD SP!, {R4, PC}		;load registers from stack
	
flashLEDC
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =0x000A0000		;load diplayCode
	STR R4, [R2]			;clear LEDs
	BL shortdelay
	BL clearLED
	LDMFD SP!, {R4, PC}		;load registers from stack


clearLED
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =0x000F0000		;load diplayCode
	STR R4, [R1]			;clear LEDs
	LDMFD SP!, {R4, PC}		;load registers from stack
	
shortdelay
	STMFD SP!, {R4, LR}		;save registers to stack
	LDR R4, =1000000		;delaycount=10000000 
dloopshort					    ;while(delaycount>0){
	SUBS R4, R4, #1			;delaycount--;
	BNE dloopshort				;}
	LDMFD SP!, {R4, PC}		;load registers from stack
	
	;parameters
	;R3: Pin Value Reg(p20-23)
	;return
	;R0: result
checkPress
	STMFD SP!, {R4-R10, LR}
	LDR R7, =0 					;isLong=false
	LDR R4, =0x00F00000 		;mask
	LDR R9, =0xFFFFFFFF
	LDR R10, [r3]	
	EOR R5, R10, R9
	AND R5, R5, R4
	CMP R5, #0
	BEQ endCheck
	CMP R5, #0x00800000
	BGT endCheck
	LDR R6, = 2000000 ;around 2 second timer
while
	LDR R9, =0xFFFFFFFF
	LDR R10, [r3]
	EOR R9, R10, R9
	AND R9, R9, R4
	SUB R6, R6, #1
	CMP R9, R5
	BNE endLoop
	B while
endLoop
	CMP R6, #0
	BGT endShort
	MOV R7, #1 ;isLong=true
endShort
	LDR R8, =0  ;count	
count
	MOVS R5, R5, LSR#1 
	BCS endCount
	ADD R8, R8, #1
	B count
endCount
	MOV R0, R8
	CMP R7, #0
	BEQ notLong
	NEG R0, R0
notLong	
endCheck
	LDMFD SP!, {R4-R10, PC}
	
	AREA	ProgramData, DATA, READWRITE

	END