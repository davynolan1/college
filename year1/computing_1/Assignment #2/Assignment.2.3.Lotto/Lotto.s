	AREA	Lotto, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =TICKET1
	LDR R2, =TICKET2
	LDR R3, =TICKET3
	LDR R4, =DRAW
	LDR R5, =6
	
	LDR R10, = '?'
while
	CMP R5, #0
	BEQ endwhile1
	LDR R6, [R1] ;Load start address of TICKET1
	LDR R7, [R2] ;Load start address of TICKET2
	LDR R8, [R3] ;Load start address of TICKET3
	LDR R9, [R4] ;Load start address of DRAW
	CMP R6, R9
	BNE endwhile2
	STR R10, [R1]
	STR R10, [R4]
	ADD R1, R1, #4
	SUB R5, R5, #1
	B while
	
stop	B	stop 



	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	3			; Number of Tickets
TICKET1	DCD	3, 8, 11, 21, 22, 31	; Tickets
TICKET2 DCD	7, 23, 25, 28, 29, 32
TICKET3 DCD	10, 11, 12, 22, 26, 30
	

DRAW	DCD	10, 11, 12, 22, 26, 30	; Lottery Draw

MATCH4	DCD	0
MATCH5	DCD	0
MATCH6	DCD	0

	END	
