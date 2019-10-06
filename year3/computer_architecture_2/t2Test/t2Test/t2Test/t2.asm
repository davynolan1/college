option casemap:none                ; case sensitive

includelib legacy_stdio_definitions.lib
extrn printf:near
.data
public g
g QWORD 4

.code

public min

;_int64 min(int a, int b, int c) {
;	int v = a;
;	if (b < v)
;		v = b;
;	if (c < v)
;		v = c;
;	return v;
;}

;parameters a @ [rcx], b @ [rdx], c @ [r8]
;local v @ [rax]

min:
	mov		rax,		rcx		; eax = a 
	mov		rbx,		rax		; v = a
	mov		rax,		rdx		; eax = b 
	cmp		rax,		rbx  	; if(b < v)
	jge		minExit				; {
	mov		rbx,		rax		;	v = b
minExit:						; }
	mov		rax,		r8		; eax = c 
	cmp		rax,		rbx		; if(c < v)
	jge		minExit2			; {
	mov		rbx,	rax	    	;	v = c
minExit2:						; }
	mov		rax,		rbx		; 
	ret							; return             


public		p

;int p(int i, int j, int k, int l) {
;	return min(min(g, i, j), k, l);
;}

;parameters i @ [rcx], j @ [rdx], k @ [r8], l @ [r9]

p:
	sub		rsp,		32		; Allocating 32 bits shadow space
	mov		rax,		rdx		; tmp = j
	mov		rbx,		r8		; tmp2 = k
	mov		r10,		rcx		; tmp3 = i
	mov		rcx,		g		; param1 = g
	mov		rdx,		r10		; param2 = i
	mov		r8,			rax		; param3 = j
	push	rbx					; save rbx
	call	min					; min(g, i, j)

	pop		rbx					; restore rbx
	mov		rcx,		rax		; param1 = min(g, i, j)
	mov		rdx,		rbx		; param2 = k
	mov		r8,			r9		; param3 = l
	call	min					; min(min(g, i, j), k, l)
	add		rsp,		32		; Deallocating 32 bits shadow space

	ret

public		gcd

;int gcd(int a, int b) {
;	if (b == 0) {
;		return a;
;	} else {
;		return gcd(b, a % b);
;	}
;}

;parameters a @ [rcx], b @ [rdx]

gcd:
	add		rsp,		32		; Allocating 32 bits shadow space
	mov		r8,			rdx		; temp = b
	xor		rax,		rax		; rax = 0	
	cmp		rax,		rdx		; if(b == 0) {
	je		gcdExit1			; jump to return a}
	mov		rax,		rcx		; rax = a
	mov		rbx,		rdx		; rbx = b
	xor		rdx,		rdx		; zero rdx since div uses 64 bit edx:eax
	idiv	rbx					; divides eax by ecx
	mov		rcx,		r8		; param1 = b
	mov		rdx,		rdx		; param2 = a%b 
	call	gcd					; gcd(b, a%b)
	jmp		gcdExit2			; jump to exit

gcdExit1:
	mov		rax,		rcx		; returns a

gcdExit2:
	sub		rsp,		32		; Deallocating 32 bits shadow space
	ret
    
public		q

;_int64 q(_int64 a, _int64 b, _int64 c, _int64 d, _int64 e){
	;_int64 sum = a + b + c + d + e;
	;printf("a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n", a, b, c, d, e, sum);
	;return sum;}
;}

;parameters a @ [rcx], b @ [rdx], c @ [r8], d @ [r9], e @ [rbp-16]
;local sum @ [rax]

sums db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H ; ASCII format string

q:
	xor		rax,		rax		; rax = 0
	add		rax,		rcx		; rax += a
	add		rax,		rdx		; rax += b
	add		rax,		r8		; rax += c
	add		rax,		r9		; rax += d
	add		rax,		[rbp-16]; rax += e
	mov		r10,		rax		; r10 = sum
	push	r10					; push sum on stack to preserve 

	sub		rsp,		32		; Allocating shadow space
	sub		rsp,		24		; Allocating 24 bits stack space for extra parameters
	mov		rax,		rcx		; temp = a
	mov		rbx,		rdx		; temp1 = b
	lea		rcx,		testS	; param1 = format string
	mov		rdx,		rax		; param2 = a
	mov		rax,		r8		; temp = c
	mov		r8,			rbx		; param3 = b
	mov		rbx,		r9		; temp2 = d
	mov		r9,			rax		; param4 = c
	mov		[rsp+32],	rbx		; param5 = d
	mov		rbx,		[rbp-16]; temp2 = e
	mov		[rsp+40],	rbx		; param6 = e
	mov		[rsp+48],	r10		; param7 = sum

	call	printf				; printf(formatString, a, b, c, d, e, sum)
	add		rsp,		32		; Deallocating shadow space
	add		rsp,		24		; Deallocating extra stack space
	pop		r10					; restoring sum
	mov		rax,		r10		; result = sum
	ret							; return

end


public qns						; export function name

testString db 'qns\n', 0AH, 00H		; Format string
qns:
	sub		rsp,		32		; Allocating shadow space
	lea		rcx,		testString	; param1 = format string
	call	printf				; printf("Hello world!")
	add		rsp,		32		; Deallocating shadow space

	lea		rcx,		testS2	; param1 = format string
	call	printf				; printf("Hello world!") // No shadow space
	
	; The following error occurs when shadow space is not allocated:
	; "Unhandled exception at 0x00007FF6A8E1BC6F in t2Test.exe: 0xC0000096: Privileged instruction."
	; This is because the printf function writes over the memory we are preserving as we allocated no shadow space.

	xor		rax,		rax		
	ret

end