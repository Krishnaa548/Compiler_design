%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define MAX_SYMBOLS 100

typedef  struct{
char name[100];
int declared;
}Symbol;

Symbol symbol_table[MAX_SYMBOLS];

int symbol_count = 0;

int symbol_exists(char *name)
{
	for(int i=0; i<symbol_count; i++)
	{
		if(strcmp(symbol_table[i].name,name)==0)
		{
			return 1;
		}
	}
	return 0;
}

void add_symbol(char *name)
{
	if(symbol_exists(name)==0 && symbol_count<MAX_SYMBOLS)
	{
		strcpy(symbol_table[symbol_count].name, name);
		symbol_table[symbol_count].declared=1;
		symbol_count++;
	}
}

void print_symbol_table(){
	printf("Symbol Table:\n");
	for(int i=0; i<symbol_count; i++)
	{
		printf("Name: %s, Declared: %d\n", symbol_table[i].name, symbol_table[i].declared);
	}
}
%}

%%
[a-zA-Z_][a-zA-Z0-9_]* { add_symbol(yytext); }
[ \t\n]+          ;
[;,\(\){}=]       ;
%%

int main(int argc, char **argv)
{
	if(argc>1)
	{
		FILE *input_file = fopen(argv[1],"r");
		if(input_file)
		{
			yyin = input_file;
			yylex();
			fclose(input_file);
		}
		
		else
		{
			fprintf(stderr, "could not open file %s\n", argv[1]);
		}
	}
	
	else
	{
		printf("Please provide an input file\n");
		return 1;
	}
	
	print_symbol_table();
	return 0;
}

int yywrap()
{
	return 1;
}
	
	
	
















