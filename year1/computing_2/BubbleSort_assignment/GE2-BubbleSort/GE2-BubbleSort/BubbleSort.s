	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, =testarr
	LDR	R5, =N
	MOV R10, #1
	
	MOV R0, R4
	MOV R1, R5
	BL sort
	B stop
sort
	STMFD sp!, {r4-r12,lr}
	MOV R4, R0
	MOV R5, R1
sortloop
	CMP R10, #0
	BEQ sortfinished
	MOV R10, #0
	MOV R6, #1
for
	CMP R6, R5
	BEQ sortloop
	SUB R7, R6, #1
	LDR R8, [R4, R6, LSL #2]
	LDR R9, [R4, R7, LSL #2]
	CMP R9, R8
	MOV R0, R7
	MOV R1, R6
	BLLT swap
	ADD R6, R6, #1
	B for
sortfinished
	LDMFD sp!, {r4-r12,pc}
	BX LR
swap
	STMFD sp!, {r4-r12,lr}
	LDR R8, [R4, R0, LSL #2]
	LDR R9, [R4, R1, LSL #2]
	STR R8, [R4, R1, LSL #2]
	STR R9, [R4, R0, LSL #2]
	LDMFD sp!, {r4-r12,pc}
	MOV R10, #1
	BX LR
	

stop	B	stop


	AREA	TestData, DATA, READWRITE
N	EQU	10
testarr	DCD	3,9,2,1,8,0,7,4,9,6
	END
