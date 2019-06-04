#include <stdio.h>
#include <string.h>
int main() {
	char str1[100], str2[100], str3[100];
	printf("Enter 3 words separated by white space: \n");
	scanf("%s%s%s",str1,str2,str3);
	printf("Word 1: ");
	puts(str1);
	printf("\nWord 2: ");
	puts(str2);
	printf("\nWord 3: ");
	puts(str3);
	return 0;
}