#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <stdio.h>


int isDottedQuad(char *str){
    int i;
    int dotCount = 0;
    int digAfterDot = 0;
    for(int i = 0; str[i] != '\0'; i++){
        if(strcmp(&str[i], ".") == 0){
            dotCount++;
            if(isdigit(str[i+1]))
                digAfterDot++;
        }
    }
    if(dotCount == 3 && digAfterDot == 3){
        return 1;
    }
    return 0;
}

int dottedQuad2uint(char *str, unsigned int *addr){
    int A = 0;
    int B = 0;
    int C = 0;
    int D = 0;

    if(isDottedQuad(str)){
        char*temp = strtok(str, ".");
        A = temp[0];
        B = temp[1];
        C = temp[2];
        D = temp[3];

        addr[0] = (A*(pow(256,3)))+(B*(pow(256,2)))+(C*256)+D;
        return addr[0];
    }
    else{
        printf("Input string is not in dotted-quad form.");
    }
    return 0;
}

int uint2dottedQuad(unsigned int addr, unsigned char *buf, size_t *buflen){
    
}

