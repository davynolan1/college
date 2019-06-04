	AREA	Countdown, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =cdWord	; Load start address of word
	LDR	R2, =cdLetters	; Load start address of letters
	LDR R7, =cdLetterSize  ;Load amount of letters in cdletters
	LDR R8, =cdWordSize   ;Load amount of letters in word
	LDR R9, =0  ;count for common letters 
	LDR R10, =1  ;count for cdLetterSize
while
	LDR R3, [R1] 	 ;Load start address of word
	LDR R4, [R2] 	 ;Load start address of letters
	CMP R3, R4   	 ;if (1st letter of word = 1st letter of cdletters)
	BNE endwhile 	 ;{
equalLetters	
	ADD R9, R9, #1   ;count++}
	CMP R9, R8       	;if (letter count != size of word)
	BEQ correctLetters 	;{
endwhile
	ADD R4, R4, #1    	;move on to next letter in cdletters
	ADD R10, R10, #1  	;letterSizeCount++}
	CMP R10, R7    		;if(letterSizeCount != letterSize)
	BEQ nextLetter 		;{
compare
	CMP R3, R4     		;if(letter of word = letter of cdletters)
	BEQ equalLetters	; { repeat endwhile}
	B endwhile
nextLetter
	ADD R3, R3, #1   	;try next letter of word
	LDR R4, [R2]     	;go back to first letter of cdletters
	LDR R10, =1      	;reset letterSizeCount
	B compare
correctLetters
	LDR R0, =1       ;if the word can be created from letters
	                 ;in cdletters, then put 1 in R0
	
	
	
stop	B	stop



	AREA	TestData, DATA, READWRITE
	
cdWord
	DCB	"beets",0
cdWordSize	DCD 5
cdLetters
	DCB	"daetebzsb",0
cdLetterSize  DCD 9
	END	
