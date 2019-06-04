#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
#include<ctype.h>
int main()
{
	int buzzSize = 1024;
	char exp[1024];
	char * filename = "input.in";


	FILE *fp = fopen(filename, "r");
	int lines = 0;
	int c = 0;

	char *result = malloc(strlen(filename) + strlen(".results") + 1);
	strcpy(result, filename);
	strcat(result, ".results");
	FILE *output = fopen(result, "w");
	fprintf(output,"%s", "printing\n");
	
	int i = 0;
	int j = 0;
	while (!feof(fp))
	{
		fgets(exp, buzzSize, fp);
		fprintf(output,"%s\n", exp);
		if (exp[strlen(exp) - 1] != '\n')
		{
			fprintf(output, "\n");
		}
		char *tmp = NULL;;
		//int result;
		if (exp[0] == 'p')

		{

			//result = evaluatePostfix(tmp);
			//printf("%d", result);
			//fprintf(output, "%d\n", result);
			fprintf(output, "%s\n", "answer postfix");
			i = 0;
			j = 0;
			tmp = NULL;
		}
		if (exp[0] == 'i')
		{

			//result = evaluatePostfix(infixToPostfix(tmp));
			//printf("%d", result);
			//fprintf(output, "%d\n", result);
			fprintf(output, "%s\n", "answer infix");
			i = 0;
			j = 0;
			tmp = NULL;
		}
	}
	int h = 0;
	char ans[1024];
	//while (!feof(output))
	//{
	//	if (fgets(ans, 1024, output) != NULL)
	//	{
	//		puts(ans);
	//	}
	//}
	
	fclose(output);
	fclose(fp);

}