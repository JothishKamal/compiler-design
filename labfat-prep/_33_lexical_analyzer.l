%{
#include <stdio.h>
#include <string.h>
%}

%%
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"   { printf("<KEYWORD, %s>\n", yytext); }
[_a-zA-Z][_a-zA-Z0-9]*    { printf("<IDENTIFIER, %s>\n", yytext); }
[0-9]+(\.[0-9]+)?         { printf("<NUMBER, %s>\n", yytext); }
"=="|"!="|"<="|">="|"++"|"--"|"&&"|"||" { printf("<OPERATOR, %s>\n", yytext); }
[+\-*/%=&|<>!^~]          { printf("<OPERATOR, %s>\n", yytext); }
[(){}\[\],;.]             { printf("<SPECIAL, %s>\n", yytext); }
[ \t\n]+                  ;
.                         { printf("<UNKNOWN, %s>\n", yytext); }
%%

int main(){ 
  yylex(); 
  return 0; 
}
