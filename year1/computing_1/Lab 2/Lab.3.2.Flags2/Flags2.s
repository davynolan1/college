	AREA	Flags2, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
;(i)	
	LDR R0, =0x1
	
	ADDS R0, R0, R0
	
;(ii)
	LDR R0, =0xB0
	
	ADDS R1, R0, R0
	
;(iii)
	LDR R0, =0xC0000000
	LDR R1, =0x70000000
	ADDS R0, R0, R1
	
;(viii)
	LDR R0, =0x9
	LDR R1, =0x8
	
	ADDS R0, R0, R1
	
	



stop	B	stop

	END	