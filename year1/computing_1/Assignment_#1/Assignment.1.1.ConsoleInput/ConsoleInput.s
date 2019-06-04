	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R6, =10
	LDR R4, =0
read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console
	
	
	MUL R4, R6, R4     ;result = result x 10
	SUB R5, R0, #0x30  ;convert ascii to numeric
	ADD R4, R4, R5     ;result = result +value
	B	read		; }
	
endRead

stop	B	stop

	END	