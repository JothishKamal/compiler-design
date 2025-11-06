%{
#include <stdio.h>
int word_count = 0;
%}

%option noyywrap

%%
[ \t\n]+        ;   
[A-Za-z0-9]+    { word_count++; }
.               ;   
%%

int main() {
    yylex();
    printf("Number of words: %d\n", word_count);
    return 0;
}
