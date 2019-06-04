	AREA	FpAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	;
	; Part 1 - decode
	;

	LDR	r0, =0x3F000000		; fpval1 = 0.5
	LDR	r1, =0x3EE00000		; fpval2 = 0.4375

	BL	fpadd

stop	B	stop

; fpadd subroutine
; Adds two IEEE754 single precision floating point values
; Parameters:
;   R0: first floating point value
;   R1: second floating point value
; Return value:
;   R0: floating point result
;
fpadd
	STMFD sp!, {R4-R12, lr}
	MOVS R4, R0, LSR #31
	MOVS R3, R0, LSR #23
	LDR R12, =0x000000FF
	AND R5, R3, R12
	SUB R5, R5, #127
	AND R6, R0, =0x007FFFFF
	
	
	MOVS R7, R1, LSR #31
	MOVS R3, R1, LSR #23
	LDR R12, =0x000000FF
	AND R8, R3, R12
	SUB R8, R8, #127
	AND R9, R0, 
	
	CMP R5, R8
	SUBHI R3, R5, R8
	SUBLO R3, R8, R5
	MOV
	ORRLO R6, R6, 
	MOVLO R6, R6, LSR R3
	MOVHI R9, R9, LSR R3
	
	
	LDMFD sp!, {R4-R12, pc}
	END
