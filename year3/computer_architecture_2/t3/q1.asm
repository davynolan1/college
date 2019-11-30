
add r0, #4, r9 ;int g = 4

// int min(int a, int b, int c) { 
// int v = a;
// if (b < v)
// v = b;
// if (c < v)
// v = c;
// return v; ; use r1 for result, r25 for return address
// }

// Parameters a@r26, b@r27, c:@28

min:    add r26, r0, r1 
        sub r27, r1, r0 {C} 
        jge min0 
        xor r0, r0, r0 
        add r27, r0, r1 

min0:   sub r28, r1, r0 {C} 
        jge min1 
        xor r0, r0, r0 
        add r28, r0, r1 
        min1: ret r25, 0 
        xor r0, r0, r0 

min1:   ret r25, 0 
        xor r0, r0, r0 


// int p(int I, int j, int k, int l) { 
// return min(min(g, i, j), k, l);
// }

// Parameters i@r26, j@r27, k@r28, l@29
// Unoptimised code

p:      add r9, r0, r10 
        add r26, r0, r11 
        add r27, r0, r12 
        callr r25, min 
        xor r0, r0, r0 
        add r1, r0, r10 
        add r28, r0, r11 
        add r29, r0. r12 
        callr r25, min 
        xor r0, r0, r0 
        ret r25, 0 
        xor r0, r0, r0 

// Optimised code

p:      add r9, r0, r10 
        add r26, r0, r11 
        callr r25, min 
        add r27, r0, r12 
        add r1, r0, r10 
        add r28, r0, r11 
        callr r25, min 
        add r29, r0. r12 
        ret r25, 0 
        xor r0, r0, r0

// int gcd(int a, int b) { 
// if (b == 0) {
// return a;
// } else {
// return gcd(b, a % b); ; call an external function mod to evaluate a % b
// }
// }

; Parameters a@r26, b@27

// Unoptimised code

gcd:    sub r27, r0, r0 {c} 
        jne gcd0 
        xor r0, r0, r0 
        add r26, r0, r1 
        ret r25, 0 
        xor r0, r0, r0 
gcd0:   add r26, r0, r10 
        add r27, r0, r10 
        callr r25, mod 
        xor r0, r0, r0 
        add r27, r0, r10 
        add r1, r0, r11 
        callr r25, gcd 
        xor r0, r0, r0 
        ret r25, 0 
        xor r0, r0, r0 

// Optimised code

gcd:    sub r27, r0, r0 {c} 
        jeq gcd0 
        add r26, r0, r1 
        add r26, r0, r10 
        callr r25, mod 
        add r27, r0, r10 
        add r27, r0, r10 
        callr r25, gcd 
        add r1, r0, r11 
gcd0:   ret r25, 0 
        xor r0, r0, r0 