	AREA	StringLength, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =str1
	MOV R2, #-1
loop
	ADD R2, R2, #1
	LDRB R3, [R1], #1
	CMP R3, #0
	
	BNE loop
	
	MOV R0, R2
	SWI &11
	
	
	AREA	TestData, DATA, READWRITE

str1	DCB	"Friday",0

	END	
