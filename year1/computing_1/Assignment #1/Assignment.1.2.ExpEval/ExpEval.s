	AREA	ExpEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10
	LDR R4, =0
	LDR R8, =0   ;2nd operand
	LDR R9, =0   ;1st operand
	LDR R10, =0  ;operator codes
	LDR R3, =0
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
	B read         ;}

subtraction
	BL sendchar    ;echo key back to console
	LDR R4, =0     ;update R4 to 0
	LDR R10, =2    ;update R10 to 2
	CMP R3, #0     ;while (R3 != 0)
	BEQ read       ;{
	SUB R5, R9, R8 ;subtract 1st operand from 2nd operand and store result in R5
	B read         ;}

multiplication
	BL sendchar    ;echo key back to console
	LDR R4, =0     ;update R4 to 0
	LDR R10, =3    ;update R10 to 3
	CMP R3, #0     ;while (R3 != 0)
	BEQ read       ;{
	MUL R5, R9, R8 ;multiply 1st operand by 2nd operand and store result in R5
	B read         ;}

stop	B	stop

	END	
