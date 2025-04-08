#include<stdio.h>
#include<string.h>
#include<ctype.h>
#define MAX_LEN 100

//List of C keywords
const char *keywords[]={
    "int","float","double","char","return","if","else","while","for",
    "void","break","countinue"
};

//function checks if string is a keyword
int isKeyword(char *str){
    for(int i=0;i<sizeof(keywords) / sizeof(keywords[0]);i++) {
        if(strcmp(str,keywords[i])==0){
            return 1;
        }
    }
    return 0;
};

//Function to check if string is valid identifier
int isIdentifier(char *str){
    if(!isalpha(str[0]) && str[0]!='_') {
        return 0;
    }
    for(int i=0;str[i]!='\0';i++){
        if(!isalnum(str[i]) && str[i]!='_'){
            return 0;
        }
    }
    return 1;
}

//Function to classify and print tokens
void classifyToken(char *token) {
    if(isKeyword(token)) {
        printf("Keyword: %s\n", token);
    } else if(isIdentifier(token)){
        printf("Identifier: %s\n", token);
    } else if(strchr("+=*/%=<>!&|^~",token[0]) != NULL) {
        printf("Operator: %s\n", token);
    } else if(strchr("()[]{};,.#",token[0]) != NULL) {
        printf("Punctuation: %s\n", token);
    } else{
        printf("Unknown Token: %s\n",token);
    }
}

void tokenizer(char *str){
    char *token = strtok(str, "\t\n\r");
    while(token!=NULL) {
        classifyToken(token);
        token=strtok(NULL,"\t\n\r");
    }
}

int main() {
    char input[MAX_LEN];
    printf("Enter a C code snippet:");
    fgets(input,MAX_LEN,stdin);
    tokenizer(input);
    return 0;
}


