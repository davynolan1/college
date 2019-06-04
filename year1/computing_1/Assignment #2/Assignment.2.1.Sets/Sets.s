	AREA	Sets, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, =ASize  ;Load amount of elements in A 
	LDR R1, [R1]    ;Load start of address of ASize
	LDR R2, =AElems ;Load elements of A
	
	LDR R3, =BSize  ;Load amount of elements in B
	LDR R3, [R3]    ;Load start of address of BSize
	LDR R4, =BElems ;Load elements of B
	
	LDR R5, =CSize  ;Load amount of elements in C
	LDR R5, [R5]    ;Load start of address of CSize
	LDR R6, =CElems ;Load elements of C
	
	LDR R9, = '?'
	
while
	CMP R1, #0      ;if(ASize != 0)
	BEQ endwhile1   ;{
	LDR R7, [R2]    ;R7 = start address of AElems
	LDR R8, [R4]    ;R8 = start address of BElems}
	CMP R7, R8      ;if(1st element of A = 1st element of B)
	BNE endwhile2   ;{
	STR R9, [R2]    ;store start address of AElems in R9
	STR R9, [R4]    ;store start address of BElems in R9
	ADD R2, R2, #4  ;move on to next element of A
	SUB R1, R1, #1  ;ASize--}
	B while
endwhile2
	CMP R3, #0      ;if(amount of elements of B != 0)
	BEQ endwhile3   ;{
	ADD R4, R4, #4  ;move on to next element of B
	SUB R3, R3, #1  ;BSize--}
	B while
endwhile3
	STR R7, [R6]     ;store start address of CElems in R7
	ADD R6, R6, #4   ;move on to next element of C
	ADD R5, R5, #1   ;Csize--
	ADD R2, R2, #4   ;move on to next element of A
	SUB R1, R1, #1   ;ASize--
	LDR R4, = BElems ;Load again
	LDR R3, = BSize  ;Load again
	LDR R3, [R3]     ;Load start address
	B while
endwhile1
while2
	CMP R3, #0      ;if(amount of elements in B != 0)
	BEQ endwhile    ;{
	LDR R8, [R4]    ;Load start address of BElems into R8
	CMP R8, #'?'    ;if(element != '?')
	BEQ endwhile4   ;{
	STR R8, [R6]    ;store start address of CElems in R8
	ADD R5, R5, #1  ;CSize++
	ADD R6, R6, #4  ;move on to next element of C
	ADD R4, R4, #4  ;move on to next element of B
	SUB R3, R3, #1  ;BSize--}
	B while2
endwhile4
	ADD R4, R4, #4  ;move on to next element of B
	SUB R3, R3, #1  ;BSize--
	B while2
endwhile
	
stop	B	stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,9,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END	
