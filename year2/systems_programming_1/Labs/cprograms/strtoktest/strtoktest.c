#include <stdio.h>
#include <string.h>

int main()
{
	char str[] = "my name is Davy";
	int init_size = strlen(str);
	char delim[] = " ";

	char *ptr = strtok(str, delim);

	while(ptr != NULL)
	{
		printf("'%s'\n", ptr);
		ptr = strtok(NULL, delim);
	}

	for (int i=0; i<init_size; i++)
	{
		printf("%d ", str[i]);
	}

	printf("\n");

	return 0;
}