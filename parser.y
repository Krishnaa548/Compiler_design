%{
#include<stdio.h>
#include<stdlib.h>
int yyerror(char *s);
int yylex();
%}

%token NUMBER ID
%left '+' '-'
%left '*' '/'

%%
S : T {printf("Result = %d\n",$$);}
  ;
T : T '+' T {$$=$1+$3;}
  | T '-' T{$$=$1-$3;}
  | T '*' T {$$=$1*$3;}
  | T '/' T {$$=$1/$3;}
  | '-' NUMBER {$$=-$2;}
  | '-' ID {$$=-$2;}
  | '('T')' {$$=$2;}
  | NUMBER {$$=$1;}
  | ID {$$=$1;}
  ;
%%

int main()
{
	printf("Enter expression: \n");
	yyparse();
	return 0;
}

int yyerror(char *s)
{
	printf("\nError: %s\n",s);
	return 0;
}

