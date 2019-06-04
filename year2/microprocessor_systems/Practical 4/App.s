; Definitions  -- references to 'UM' are to the User Manual.

; Timer Stuff -- UM, Table 173

T0	equ	0xE0004000		; Timer 0 Base Address
T1	equ	0xE0008000

IR	equ	0			; Add this to a timer's base address to get actual register address
TCR	equ	4
MCR	equ	0x14
MR0	equ	0x18

TimerCommandReset		equ	2
TimerCommandRun			equ	1
TimerModeResetAndInterrupt	equ	3
TimerResetTimer0Interrupt	equ	1
TimerResetAllInterrupts		equ	0xFF

; VIC Stuff -- UM, Table 41
VIC		equ	0xFFFFF000		; VIC Base Address
IntEnable	equ	0x10
VectAddr	equ	0x30
VectAddr0	equ	0x100
VectCtrl0	equ	0x200

Timer0ChannelNumber	equ	4			; UM, Table 63
Timer0Mask		equ	1<<Timer0ChannelNumber	; UM, Table 63
IRQslot_en		equ	5			; UM, Table 58

	AREA	InitialisationAndMain, CODE, READONLY
	IMPORT	main

; (c) Mike Brady, 2014 -- 2019.

	EXPORT	start
start
; initialisation code

; Initialise the VIC
	ldr	r0,=VIC			; looking at you, VIC!

	ldr	r1,=irqhan
	str	r1,[r0,#VectAddr0] 	; associate our interrupt handler with Vectored Interrupt 0

	mov	r1,#Timer0ChannelNumber+(1<<IRQslot_en)
	str	r1,[r0,#VectCtrl0] 	; make Timer 0 interrupts the source of Vectored Interrupt 0

	mov	r1,#Timer0Mask
	str	r1,[r0,#IntEnable]	; enable Timer 0 interrupts to be recognised by the VIC

	mov	r1,#0
	str	r1,[r0,#VectAddr]   	; remove any pending interrupt (may not be needed)

; Initialise Timer 0
	ldr	r0,=T0			; looking at you, Timer 0!

	mov	r1,#TimerCommandReset
	str	r1,[r0,#TCR]

	mov	r1,#TimerResetAllInterrupts
	str	r1,[r0,#IR]

	ldr	r1,=(14745600/200)-1	 ; 5 ms = 1/200 second
	str	r1,[r0,#MR0]

	mov	r1,#TimerModeResetAndInterrupt
	str	r1,[r0,#MCR]

	mov	r1,#TimerCommandRun
	str	r1,[r0,#TCR]

;from here, initialisation is finished, so it should be the main body of the main program
	
IO0DIR	EQU	0xE0028008	
IO0SET	EQU	0xE0028004	
IO0CLR	EQU	0xE002800C
	
	
	LDR R1, =IO0DIR
	LDR R2, =0x00260000		;rgb pins
	str r2,[r1]			;make them outputs
	ldr r1,=IO0SET
	str r2,[r1]			;set them to turn the LEDs off
	ldr r2,=IO0CLR
	
	LDR R4, =0 ;second counter
	LDR R5, = 0x00260000 ;for clearing purposes
	LDR R6, = 0x00020000 ;red
	LDR R7, = 0x00040000 ;blue
	LDR R8, = 0x00200000 ;green
	LDR R9, =0 ;color reg
wloop	
	CMP R4, #200	;if counter is 200 i.e. 1 second
	BNE wloop	
	MOV R4, #0	;reset counter
	STR R5, [R1]	;clear LED
	CMP R9, #0	;check if red
	BNE notRED
	STR R6, [R2]	;set red
	MOV R9, #1	;next will be blue
	B wloop
notRED
	CMP R9, #1	;check if blue
	BNE notBLUE
	STR R7, [R2]	;set blue
	MOV R9, #2	;next will be green
	B wloop	
notBLUE
	STR R8, [R2]	;set green
	MOV R9, #0	;next will be red
	b	wloop  		; branch always
;main program execution will never drop below the statement above.

	AREA	InterruptStuff, CODE, READONLY
irqhan	sub	lr,lr,#4
	stmfd	sp!,{r0-r1,lr}	; the lr will be restored to the pc

;this is the body of the interrupt handler

;here you'd put the unique part of your interrupt handler
;all the other stuff is "housekeeping" to save registers and acknowledge interrupts
	

;this is where we stop the timer from making the interrupt request to the VIC
;i.e. we 'acknowledge' the interrupt
	ldr	r0,=T0
	mov	r1,#TimerResetTimer0Interrupt
	str	r1,[r0,#IR]	   	; remove MR0 interrupt request from timer


	ADD R4, R4, #1	;5ms counter ++
	
	
;here we stop the VIC from making the interrupt request to the CPU:
	ldr	r0,=VIC
	mov	r1,#0
	str	r1,[r0,#VectAddr]	; reset VIC

	ldmfd	sp!,{r0-r1,pc}^	; return from interrupt, restoring pc from lr
				; and also restoring the CPSR

	END