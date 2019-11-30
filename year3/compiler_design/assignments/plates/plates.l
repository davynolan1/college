%{

%}

NUMBER  [0-9]{1,6}[ \t\n]+
NEWCOUNTY	C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
COUNTY		C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
YEAR  [0-9]{2}
NEWYEAR [0-9]{2}[12]

%%
{YEAR}-{COUNTY}-{NUMBER} 	{
					char yearString[2];
					strncpy(yearString, yytext, 2);
					int yearInt = atoi(yearString);
					if(yearInt < 13) yearInt = yearInt + 2000;
					else yearInt = yearInt + 1900;

					printf("%d\n", 2019-yearInt);
				}
{NEWYEAR}-{COUNTY}-{NUMBER}	{
					char yearString[2];
					strncpy(yearString, yytext, 2);
					int yearInt = atoi(yearString);
					
					printf("%d\n", 19-yearInt);
				}

.+[ \t\n]			{ printf("INVALID\n"); }
\n				{}
%%

int main()
{
	yylex();
	return 0;
}