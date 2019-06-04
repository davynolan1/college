	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	LDR R6, =10  ;power value
	LDR R4, =0   
	LDR R8, =0   ;2nd operand
	LDR R9, =0   ;1st operand
	LDR R10, =0  ;operator codes
	LDR R3, =0   ;tells whethere 2nd operand has been entered or not
	LDR R5, =0   ;stores result from expressions
	LDR R7, =1   ;power value
	LDR R11, =10 
	LDR R12, =0  ;division remainder
read
	BL	getkey		   ;read key from console
	CMP	R0, #0x0D  	   ;while (key != CR)
	BEQ	endRead		   ;{
	CMP R0, #0x2B      ;compare read key to '+'
	BEQ addition       ;branch to addition if '+' is entered
	CMP R0, #0x2D      ;compare read key to '-'
	BEQ subtraction    ;branch to subtraction if '-' is entered
	CMP R0, #0x2A      ;compare read key to '*'
	BEQ multiplication ;branch to multiplication if '*' is entered
	BL	sendchar	   ;echo key back to console
	
	
	MUL R4, R6, R4    ;result = result x 10
	SUB R5, R0, #0x30 ;convert ascii to numeric
	ADD R4, R4, R5    ;result = result + value
	
	CMP R10, #0  ; while ( R10 < 0)
	BHI operand2 ; {
	MOV R9, R4   ; make R4 the first operand
	B	read	 ; }
	
operand2
	MOV R8, R4  ; make R4 the second operand
	MOV R3, #1  ; give R3 the value of 1
	B read
	
endRead
	CMP R10, #1          ; while (R10 != 1)
	BEQ addition         ; {
	CMP R10, #2          ;   while (R10 != 1)
	BEQ subtraction      ;   {
	CMP R10, #3          ;     while (R10 != 3)
	BEQ multiplication   ;     {
	
	
	
addition
	BL sendchar    ;echo key back to console
	LDR R4, =0     ;update R4 to 0
	LDR R10, =1    ;update R10 to 1
	CMP R3, #0     ;while (R3 != 0)
	BEQ read       ;{
	ADD R5, R9, R8 ;add 1st operand to 2nd operand and store result in R5
	B division1        ;}

subtraction
	BL sendchar    ;echo key back to console
	LDR R4, =0     ;update R4 to 0
	LDR R10, =2    ;update R10 to 2
	CMP R3, #0     ;while (R3 != 0)
	BEQ read       ;{
	SUB R5, R9, R8 ;subtract 1st operand from 2nd operand and store result in R5
	B division1        ;}

multiplication
	BL sendchar    ;echo key back to console
	LDR R4, =0     ;update R4 to 0
	LDR R10, =3    ;update R10 to 3
	CMP R3, #0     ;while (R3 != 0)
	BEQ read       ;{
	MUL R5, R9, R8 ;multiply 1st operand by 2nd operand and store result in R5
	B division1        ;}


	
division1
	CMP R5, R6        ;while (R5 >= 10)
	BLS endDivision1  ;{
	ADD R7, #1        
	CMP R7, #9        ; while( R7 != 9)
	BEQ largeNum      ; {
	MUL R6, R11, R6   
	B division1
endDivision1

nextDigit
	SUB R7, #1
	
largeNum
	MOV R2, R7
	LDR R6, =10
	
division2
	CMP R7, #0       ;while(R7 != 0)
	BEQ lastDigit    ;{
	CMP R7, #1       ; while(R7 != 1)
	BEQ endDivision2 ; {
	CMP R2, #1       ;  while(R2 != 1)
	BEQ endDivision2 ;  {
	MUL R6, R11, R6  ;   R6 = R11 * 10
	SUB R2, #1    
	B division2      ;}}}
endDivision2
	MOV R0, #0x0A    ; R0 = new line
	BL sendchar      ; print new line
	MOV R12, R5      
	LDR R0, =0
	
middleDigit            
	CMP R12, R6        ;while(R12 > R6)
	BLO endMiddleDigit ;{
	ADD R0, #1
	SUB R12, R6
	B middleDigit      ;}
endMiddleDigit
	
printDigit
	ADD R0, #0x30  ; R0 =quotient + character '0'
	BL sendchar    ; print
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