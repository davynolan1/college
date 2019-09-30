.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
option casemap:none                ; case sensitive


.data ; start of a data section
public g ;export variable g
g DWORD 4 ;declare global variable g initialised to 4
.code ;start of a code section


public min 

min:    push ebp            ; save ebp
        mov ebp, esp        ; ebp -> new stack frame
        sub esp, 4          ; allocate space for local v
        push ebx

        ;parameters a @ [ebp+8], b @ [ebp+12], c @ [ebp+16]
        ;local v @ [ebp-4]

        mov eax, [ebp+8]    ;eax = a
        mov [ebp-4], eax    ;v = eax = a

        cmp [ebp+12], eax  ;if(b<v)
        jg minif 
        mov eax, [ebp+12]       ;eax = b
        mov [ebp-4], eax        ;v = eax = b
minif: 
        cmp [ebp+16], eax  ;if(c<v)  
        jg minelse                 
        mov eax, [ebp+16]       ;eax = c
        mov [ebp-4], eax        ;v = eax = c
minelse:
        mov eax, [ebp-4]        ;return v
        pop ebp
        ret 0


public p


p:      push ebp            ; save ebp
        mov ebp, esp        ; ebp -> new stack frame
        push ebx

        ;parameters i @ [ebp+8], j @ [ebp+12], k @ [ebp+16], l @ [ebp+20]

        push [ebp+12]
		push [ebp+8]
        push g
        call min    ;min(g,i,j)
        add esp, 12

        push [ebp+20]
		push [ebp+16]
		push eax
		call min    ;min(min(g,i,j),k,l)
		add	 esp, ebp
			
		mov	esp, ebp
		pop	ebp
		ret	0


public gcd

gcd:		push	ebp
			mov		ebp, esp
            push ebx

            ;parameters a @ [ebp+8], b @ [ebp+12]

			mov		eax, [ebp+12]   ;eax = b
			test	eax, eax        
			jne		gcdelse         ;if(b==0)

			mov		eax, [ebp+8]    ;eax = a i.e. return a 
			jmp		gcdret          ;jump to return a 

                                    ;else
gcdelse:	mov		eax, [ebp+8]    ;eax = a
			mov		ecx, [ebp+12]   ;ecx = b
			xor		edx, edx        
			idiv	ecx
			push	edx
			push	[ebp+12]
			call	gcd
			add		esp, 8

gcdret:		mov		esp, ebp
			pop		ebp
			ret		0
    
END


        

