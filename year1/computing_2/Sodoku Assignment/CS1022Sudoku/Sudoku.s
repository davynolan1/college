	AREA	Sudoku, CODE, READONLY
	IMPORT  sendchar
	EXPORT	start

start
	LDR	R4, =testSolutionThree
	LDR R6, =9 ;row/col size
	LDR R1, =0 ;row
	LDR R2, =0 ;col
	LDR R8, =rowSumArray
	LDR R9, =colSumArray
	LDR R10, =boxSumArray
	LDR R11, =0 ;rowSum = 0
	
	

	
	B extraMile
endExtraMile
	BL sudoku
	
	
;finished
	;BL	sudoku
	;
	; write tests for getSquare subroutine
	;

	;
	; write tests for setSquare subroutine
	;

	;
	; write tests for isValid subroutine
	;

	;
	; write tests for other subroutines
	;

	;
	; test sudoku subroutine
	;
	

stop	B	stop



; getSquare subroutine
getSquare
	MUL R7, R1, R6    ;temp = row*rowsize
	ADD R7, R7, R2    ;temp += col
	LDRB R0, [R4, R7] ;R0 = memory.byte[array base address + temp]
	
	BX R14


; setSquare subroutine
setSquare
	BL getSquare
	CMP R0, #0
	BNE setfinished 
	STRB R5, [R4, R7]
setfinished
	
	BX R14
		


; isValid subroutine
isValid
rWhile
	CMP R1, R6 ;   for(rowIndex = 0; rowIndex<9; rowIndex++) 
	BGE endrWhile ;{
rWhile2
	CMP R2, R6 ;   		for(colIndex = 0; colIndex<9; colIndex++)
	BGE endrWhile2 		;{
	BL getSquare		;get value in square at index R1,R2
	ADD R11, R11, R0    ;rowSum += value in current square
	ADD R2, R2, #1      ;}
	B rWhile2
endrWhile2
	STRB R11, [R8];memory.byte[rowSumArray] = rowSum
	ADD R8, R8, #1;rowSumArray address++
	MOV R11, #0   ;rowSum = 0 (reset)
	ADD R1, R1, #1;}
	MOV R2, #0
	B rWhile
endrWhile

	MOV R1, #0 ;reset rowIndex
	MOV R2, #0 ;reset colIndex
	
cWhile
	CMP R1, R6 ;   for(rowIndex = 0; rowIndex < 9; rowIndex++)
	BGE endcWhile ;{
cWhile2
	CMP R2, R6 ;  		 for(colIndex = 0; colIndex < 9; colIndex++)
	BGE endcWhile2 		;{
	MUL R7, R2, R6		
	ADD R7, R7, R1
	LDRB R0, [R4, R7]	;get value in square at index R2,R1
	ADD R11, R11, R0	;colSum += value in current square
	ADD R2, R2, #1		;}
	B cWhile2
endcWhile2
	STRB R11, [R9];memory.byte[colSumArray] = colSum
	ADD R9, R9, #1;colSumArray address++
	MOV R11, #0   ;colSum = 0 (reset)
	ADD R1, R1, #1;}
	MOV R2, #0
	B cWhile
endcWhile

	MOV R1, #0  ;reset rowIndex 
	MOV R2, #0  ;reset colIndex
	
bWhile
	CMP R1, R6 ;   for(rowIndex(i) = 0; rowIndex(i) < 9; rowIndex(i)++)
	BGE endbWhile ;{
bWhile2
	CMP R2, R6 ;   		for(colIndex(j) = 0;colIndex(j) < 9; colIndex(j)++)
	BGE endbWhile2 ;	{
if1
	CMP R1, #2				;if(i<=2&&j<=2)
	BHI if2					;{
	CMP R2, #2				;
	BHI if2					;
	BL getSquare			;get value in square at index R1,R2
	LDRB R5, [R10]          ;temp = mem.byte[boxSumArray]
	ADD R0, R0, R5          ;temp2 += temp
	STRB R0, [R10]          ;mem.byte[boxSumArray] = temp2
							;}
if2
	CMP R1, #2
	BHI if3
	CMP R2, #3
	BLO if3
	CMP R2, #5
	BHI if3
	BL getSquare
	LDRB R5, [R10, #1]
	ADD R0, R0, R5
	STRB R0, [R10, #1]
	
if3
	CMP R1, #2
	BHI if4
	CMP R2, #6
	BLO if4
	CMP R2, #8
	BHI if4
	BL getSquare
	LDRB R5, [R10, #2]
	ADD R0, R0, R5
	STRB R0, [R10, #2]
	
if4
	CMP R1, #3
	BLO if5
	CMP R1, #5
	BHI if5
	CMP R2, #2
	BHI if5
	BL getSquare
	LDRB R5, [R10, #3]
	ADD R0, R0, R5
	STRB R0, [R10, #3]
	
if5
	CMP R1, #3
	BLO if6
	CMP R1, #5
	BHI if6
	CMP R2, #3
	BLO if6
	CMP R2, #5
	BHI if6
	BL getSquare
	LDRB R5, [R10, #4]
	ADD R0, R0, R5
	STRB R0, [R10, #4]
	
if6
	CMP R1, #3
	BLO if7
	CMP R1, #5
	BHI if7
	CMP R2, #6
	BLO if7
	CMP R2, #8
	BHI if7
	BL getSquare
	LDRB R5, [R10, #5]
	ADD R0, R0, R5
	STRB R0, [R10, #5]
	
if7
	CMP R1, #6
	BLO if8
	CMP R2, #2
	BHI if8
	BL getSquare
	LDRB R5, [R10, #6]
	ADD R0, R0, R5
	STRB R0, [R10, #6]
	
if8
	CMP R1, #6
	BLO if9
	CMP R2, #3
	BLO if9
	CMP R2, #5
	BHI if9
	BL getSquare
	LDRB R5, [R10, #7]
	ADD R0, R0, R5
	STRB R0, [R10, #7]
	
if9
	CMP R1, #6
	BLO endif9
	CMP R2, #6
	BLO endif9
	BL getSquare
	LDRB R5, [R10, #8]
	ADD R0, R0, R5
	STRB R0, [R10, #8]
endif9
	ADD R2, R2, #1
	B bWhile2
endbWhile2
	ADD R1, R1, #1
	MOV R2, #0
	B bWhile
endbWhile
	
	;COMPARING ALL VALUES IN ROWS TO EACHOTHER TO SEE IF VALID
	MOV R0, #0 ;rowSq1
	MOV R1, #0 ;colSq1
	MOV R2, #0 ;rowSq2
	MOV R3, #0 ;colSq2
	LDR R11, =9 ;NUMBER OF ROWS/COLS
	MOV R12, #1 ;Boolean partially correct = true
rPartlyWh
	
	
	MUL R7, R2, R11
	ADD R7, R7, R3
	LDRB R7, [R4, R7]
	MOV R6, R7         ;get value in square2
	
	CMP R0, #9     ;while(rowSq1 < 9)
	BGE erParWh    ;{
rPartlyWh2
	CMP R1, #9         ;while(colSq1 < 9)
	BGE erParWh2       ;{
	MUL R7, R0, R11    
	ADD R7, R7, R1
	LDRB R7, [R4, R7] 
	MOV R5, R7         ;get value in square1
	CMP R0, R2         ;if(rowSq1 == rowSq2)
	BNE continue      ;{
	CMP R1, R3         ;    if(colSq1 == colSq2)
	BNE continue       ;    {   
	ADD R1, R1, #1     ;    colSq1++
	B rPartlyWh        ;    }
continue          ;}
	CMP R5, R6        ;if(valueSq1 != valueSq2)
	BEQ wrong         ;{ 
	ADD R1, R1, #1    ;colSq1++
	B rPartlyWh2      ;}
erParWh2        ;}
	ADD R3, R3, #1  ;colSq2++
	MOV R1, #0      ;colSq1 = 0
	CMP R3, #9      ;if(colSq2 == 9)
	BNE continue2   ;{
	ADD R2, R2, #1  ;rowSq2++
	MOV R3, #0      ;colSq2 = 0
	ADD R0, R0, #1  ;rowSq1++
	MOV R1, #0      ;colSq1 = 0
continue2       ;}
	
	B rPartlyWh
erParWh

	;COMPARING ALL VALUES IN COLUMNS TO SEE IF VALID
	MOV R0, #0 ;rowSq1
	MOV R1, #0 ;colSq1
	MOV R2, #0 ;rowSq2
	MOV R3, #0 ;colSq2
	LDR R11, =9 ;NUMBER OF ROWS/COLS
	MOV R12, #1
cPartlyWh
	
	
	MUL R7, R3, R11
	ADD R7, R7, R2
	LDRB R7, [R4, R7]
	MOV R6, R7         ;get value in square2
	
	CMP R0, #9     ;while(rowSq1 < 9)
	BGE ecParWh    ;{
cPartlyWh2
	CMP R1, #9         ;while(colSq1 < 9)
	BGE ecParWh2       ;{
	MUL R7, R1, R11    
	ADD R7, R7, R0
	LDRB R7, [R4, R7] 
	MOV R5, R7         ;get value in square1
	CMP R0, R2         ;if(rowSq1 == rowSq2)
	BNE continue3      ;{
	CMP R1, R3         ;    if(colSq1 == colSq2)
	BNE continue3      ;    {   
	ADD R1, R1, #1     ;    colSq1++
	B cPartlyWh        ;    }
continue3          ;}
	CMP R5, #0
	BNE checkifequal
	ADD R1, R1, #1
	B cPartlyWh2
	CMP R6, #0
	BNE checkifequal
	ADD R3, R3, #1
checkifequal	
	CMP R5, R6        ;if(valueSq1 != valueSq2)
	BEQ wrong         ;{ 
	ADD R1, R1, #1    ;colSq1++
	B cPartlyWh2      ;}
ecParWh2        ;}
	ADD R3, R3, #1  ;colSq2++
	MOV R1, #0      ;colSq1 = 0
	CMP R3, #9      ;if(colSq2 == 9)
	BNE continue4   ;{
	ADD R2, R2, #1  ;rowSq2++
	MOV R3, #0      ;colSq2 = 0
	ADD R0, R0, #1  ;rowSq1++
	MOV R1, #0      ;colSq1 = 0
continue4       ;}
	
	B cPartlyWh
ecParWh

	
	
	
	
	LDR R8, =rowSumArray
	LDR R9, =colSumArray  ;RESETTING ARRAY POINTERS
	
	LDR R11, =1 ;boolean sudokuStatus = true
	LDR R1, =0 ;count
vWhile
	CMP R1, R6 ;while(i < 9)
	BGE endvWhile
	
	LDRB R5, [R8, R1]
	CMP R5, #45  
	BNE false
	LDRB R5, [R9, R1]
	CMP R5, #45
	BNE false
	LDRB R5, [R10, R1]
	CMP R5, #45
	BEQ endifst
false	
	MOV R11, #0
	B endvWhile
endifst
	ADD R1, R1, #1
	B vWhile
endvWhile
	;BX R14
	

	B finished


wrong
	MOV R12, #0    ;boolean partial solution correct = false 
	MOV R11, #0    ;boolean sudoku status = false
	
finished
	BX R14



; sudoku subroutine
sudoku
	
	MOV R1, #0 ;row
	MOV R2, #0 ;col
	MOV R3, #0 ;boolean result = false
	
	ADD R2, R2, #1
	CMP R2, #8
	BLO ifend
	MOV R2, #0
	ADD R2, R2, #1
ifend
	
	BL getSquare
	CMP R0, #0
	BEQ ifelse
	
	CMP R1, #8
	BNE ififelse
	CMP R2, #8
	BNE ififelse
	MOV R3, #1
	B endSudoku
ififelse
	ADD R2, R2, #1
	B endSudoku

ifelse
tryWh
	MOV R5, #1 ;try = 1
	CMP R5, #9
	BHI eTryWh
	CMP R3, #0
	BNE eTryWh
	BL setSquare
	BL isValid
	CMP R12, #0
	BEQ tryWh
	CMP R1, #8
	BNE ififelse2
	CMP R2, #8
	BNE ififelse2
	MOV R3, #1
	B tryWh
ififelse2
	ADD R1, R1, #1
	B tryWh
eTryWh

	CMP R3, #0
	BNE endSudoku
	BL getSquare
	MOV R6, R5
	MOV R5, #0
	BL setSquare
	MOV R5, R6
endSudoku
	
	BX R14

extraMile
	MOV R6, #0
	MOV R2, #0
	MOV R3, #0x30
	MOV R5, #9
exWh
	CMP R6, #9
	BGE endExWh
	CMP R6, #3
	BEQ printHLine ;printing horizontal grid lines
	CMP R6, #6
	BNE exWh2
printHLine
	MOV R10, #0
loop
	ADD R10, #1
	CMP R10, #20
	BEQ endLoop
	MOV R0, 0x2D
	BL sendchar
	B loop
endLoop
	MOV R0, #0x0A
	BL sendchar
	
exWh2
	MOV R0, #0
	CMP R2, #9
	BGE endExWh2
	MUL R7, R6, R5
	ADD R7, R7, R2
	LDRB R0, [R4, R7] ;getting value in square 
	ADD R0, R0, R3
	BL sendchar       ;printing value in square
	MOV R0, #0x20 
	BL sendchar       ;printing space between values
	ADD R2, R2, #1
	CMP R2, #3
	BEQ printVLine
	CMP R2, #6
	BNE goOn
printVLine
	MOV R0, #0x7C
	BL sendchar      ;printing vertical grid lines
goOn
	CMP R2, #9
	BNE exWh2
	MOV R0, #0x0A    ;printing new line
	BL sendchar
	B exWh2
endExWh2
	ADD R6, R6, #1
	MOV R2, #0
	B exWh
endExWh
	
	
	B endExtraMile





	AREA	Grids, DATA, READWRITE
rowSumArray
		SPACE 10
colSumArray
		SPACE 10
boxSumArray
		SPACE 10
gridOne
		   ;0 1 2 3 4 5 6 7 8
		DCB	7,9,0,0,0,0,3,0,0 ;0
    	DCB	0,0,0,0,0,6,9,0,0 ;1
    	DCB	8,0,0,0,3,0,0,7,6 ;2
    	DCB	0,0,0,0,0,5,0,0,2 ;3
    	DCB	0,0,5,4,1,8,7,0,0 ;4
    	DCB	4,0,0,7,0,0,0,0,0 ;5
    	DCB	6,1,0,0,9,0,0,0,8 ;6
    	DCB	0,0,2,3,0,0,0,0,0 ;7
    	DCB	0,0,9,0,0,0,0,5,4 ;8
		
testSolutionThree
		DCB	1,2,7,9,8,6,4,5,3
		DCB	9,8,3,5,4,7,1,2,6
		DCB	5,4,6,2,1,3,7,8,9
		DCB	7,5,8,3,6,4,2,9,1
		DCB	2,3,4,1,9,5,8,6,7
		DCB	6,1,9,8,7,2,5,3,4
		DCB	8,6,5,4,3,1,9,7,2
		DCB	4,7,2,6,5,9,3,1,8
		DCB	3,9,1,7,2,8,6,4,5


	;
	; add other grids for test cases
	;

	END
