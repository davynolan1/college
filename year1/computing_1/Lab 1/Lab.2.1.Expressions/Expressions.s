;Part (a)___________________________________
	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start 
	LDR	R1, =5	; x = 5
	LDR	R2, =6	; y = 6
	LDR R3, =3  
	LDR R5, =5
	
	MUL R0, R1, R1 ; R0 = x squared
	MUL R0, R3, R0 ; RO = 3(x squared)
	
	MUL R4, R1, R5 ; R4 = 5x
	
	ADD R0, R4, R0 ; R0 = 3(x squared)+5x
	
	
stop	B	stop

	END	
	
;Part (b)____________________________________
	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start 
	LDR R1, =5  ; x = 5
	LDR R2, =6  ; y = 6
	LDR R6, =2 
	LDR R3, =3
	
	MUL R0, R1, R1 ; R0 = x squared
	MUL R0, R6, R0 ; R0 = 3(x squared)
	
	MUL R7, R1, R2 ; R7 = xy
	MUL R7, R2, R7 ; R7 = 6xy
	
	MUL R8, R2, R2 ; R8 = y squared
	MUL R8, R3, R8 ; R8 = 3(y squared)
	
	ADD R0, R7, R0 ; R0 = 3(x squared)+6xy
	ADD R0, R8, R0 ; RO = 3(x squared)+6xy+3(y squared)
		
stop	B	stop

	END
		
;Part (c)____________________________________
	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start 

	LDR R1, =5  ; x = 5
	LDR R2, =6  ; y = 6
	LDR R3, =3
	LDR R4, =4
	LDR R8, =8
	
	MUL R0, R1, R1
	MUL R0, R1, R0 ; R0 = x cubed
	
	MUL R5, R1, R1
	MUL R5, R4, R5 ; R5 = 4(x squared)
	
	MUL R6, R1, R3 ; R6 = 3x
	
	SUB R7, R0, R5
	ADD R6, R7, R6
	ADD R8, R6, R8 ; R8 = x cubed-4(x squared)+3x+8
	