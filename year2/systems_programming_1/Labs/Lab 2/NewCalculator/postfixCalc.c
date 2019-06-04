

#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
#include<ctype.h>


struct node
{

	char data;
	struct node *link;


};
struct node *root = NULL;

void push(char data)
{
	struct node *temp;
	
	temp = (struct node*)malloc(sizeof(struct node));
	temp->data = data;
	temp->link = NULL;
	if (root == NULL)
	{
		root = temp;
	}
	else
	{
		struct node *p;
		p = root;
		while (p->link != NULL)
		{
			p = p->link;
		}
		p->link = temp;
	}
}

void display()
{
	struct node *temp;
	temp = root;
	if (temp == NULL)
	{
		//printf("\nNo nodes in the list. \n");
	}
	else
	{
		while (temp != NULL)
		{
			//printf("%c->", temp->data);
			temp = temp->link;
		}
		//printf("\n");
	}
}

int length()
{
	display();
	struct node *temp;
	temp = root;
	int count = 0;
	while (temp != NULL)
	{
		count++;
		temp = temp->link;
	}
	return count;
}

char getTop()
{
	struct node *p = root;
	int i = 1;
	
	while (p != NULL)
	{
		if (i == length())
		{
			return(p->data);
		}
		i++;
		p = p->link;
	}
	return NULL;
}

void addAfter(char data, int location)
{
	struct node *temp, *p;
	int loc = location;
	int len = length();
	int i = 1;

	if (loc > len)
	{
		printf("Invalid location. \n");
		printf("Currently, the list has %d nodes.", len);
	}
	else
	{
		p = root;
		while (i < loc)
		{
			p = p->link;
			i++;
		}
		temp = (struct node*)malloc(sizeof(struct node));
		temp->link = p->link;
		p->link = temp;
	}
}

char pop()
{
	struct node *temp;
	int loc = length();
	char poppedData;

	if (loc == 1)
	{
		temp = root;
		root = temp->link;
		temp->link = NULL;
		poppedData = temp->data;
		free(temp);
	}
	else
	{
		struct node *p = root;
		struct node *q;
		int i = 1;
		while (i < loc - 1)
		{
			p = p->link;
			i++;
		}
		q = p->link;
		p->link = q->link;
		q->link = NULL;
		poppedData = q->data;
		free(q);
	}
	return poppedData;
}

int precedence(char ch)
{

	if (ch == '^')
		return (5);
	else if (ch == '*' || ch == '/')
		return (4);
	else if (ch == '+' || ch == '-')
		return (3);
	else
		return (2);
}




bool isOperator(char symbol)
{
	if ((symbol == '+') || (symbol == '-') || (symbol == '*') || (symbol == '^') || (symbol == '/'))
	{
		return true;
	}
	else return false;
}

int getPostfixSize(char* infix)
{
	int sizeCount = 0;
	int k = 0;

	while (infix[k] != '\0')
	{
		//printf("%c", infix[k]);
		if (isOperator(infix[k]) || isdigit(infix[k]))
		{
			sizeCount++;
			k++;
		}
		else k++;
	}
	//printf("\n size = %d", sizeCount);
	return sizeCount;
}
char *infixToPostfix(char* infix)
{
	
	int i = 0;
	int j = 0;
	
	char* postfix;
	postfix = malloc(sizeof(int) * getPostfixSize(infix));
	while (infix[i] != '\0')
	{
		if (isdigit(infix[i]))
		{
			postfix[j] = infix[i];
			j++;
		}
		else if (infix[i] == '(')
		{
			push(infix[i]);
		}
		else if (isOperator(infix[i]))
		{
			char top = getTop();
			while (top != NULL && (precedence(top) > precedence(infix[i])) )
			{
				postfix[j] = pop();
				j++;
			}
			push(infix[i]);
		}
		else if (infix[i] == ')')
		{
			while (getTop() != '(')
			{
				postfix[j] = pop();
				j++;
			}
			pop();
		}
		else if (infix[i] == ' ')
		{
			postfix[j] = infix[i];
			j++;
		}
		i++;
	}
	while (length() != 0)
	{
		postfix[j] = pop();
		j++;
	}
	postfix[j] = '\0';
	printf("\nThe postfix of this = ");
	puts(postfix);
	return postfix;
}



int equate(int n1, char operator, int n2)
{
	if (operator == '+') return n1 + n2;
	else if(operator == '-') return n1 - n2;
	else if(operator == '*') return n1 * n2;
	else if(operator == '/') return n2 / n1;
	else return 0;
}



int evaluatePostfix(char* postfix)
{
	
	int i = 0;
	int num = 0;
	int num2 = 0;
	int n1;
	int n2;
	int ans = 0;
	while (postfix[i] != '\0' )
	{
		
		if (isdigit(postfix[i]))
		{
			if (isdigit(postfix[i + 1]))
			{
				while (isdigit(postfix[i+1]))
				{
					num = (postfix[i] - 48) + num;
					num2 = postfix[i + 1] - 48;
					num = (num * 10) + num2;
					i++;
				}
				push(num);
			}
			else
			{
				num = postfix[i] - 48; //converting ascii to int
				push(num);
			}
		}
		else if (isOperator(postfix[i]))
		{
			n1 = pop();
			n2 = pop();
			ans = equate(n1, postfix[i], n2);
			push(ans);
		}
		i++;
		num = 0;
		num2 = 0;
	}
	return ans;
}

int main()
{
	int buzzSize = 1024;
	char exp[1024];
	FILE *f = fopen("exp.txt", "r");
	fgets(exp, buzzSize, f);
	printf("String read : %s \n", exp);
	size_t length = strlen(exp);
	if (exp[length - 1] == '\n')
	{
		exp[length - 1] = '\0';
	}
	int choice = 0;
	printf("Enter 1 for infix calculation or 2 for postfix calculation: ");
	scanf("%d", &choice);
	switch (choice)
	{
		case 1:
		{
			char* postfix;
			postfix = malloc(sizeof(char) * getPostfixSize(exp));
			postfix[getPostfixSize(exp) - 1] = '\0';
			postfix = infixToPostfix(exp);
			printf("\nThe answer = %d", evaluatePostfix(postfix));
			printf("\n");
			break;
		}
		case 2:
		{
			printf("\nThe answer = %d", evaluatePostfix(exp));
			printf("\n");
			break;
		}
		default:
		{
			printf("\nInvalid input. Run again and choose either option 1 or 2.");
			printf("\n");
		}
	}
	fclose(f);
	system("pause");
	return 0;
}