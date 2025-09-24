%{
    #include <stdio.h>
    int token_count = 0;
%}

%%
"int"                   { printf("%s keyword\n", yytext); token_count++; }
"float"|"char"|"double" { printf("%s keyword\n", yytext); token_count++; }

[0-9]+                  { printf("%s number\n", yytext); token_count++; }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("%s identifier\n", yytext); token_count++; }

"="                     { printf("%s operator\n", yytext); token_count++; }
"+"|"-"|"*"|"/"         { printf("%s operator\n", yytext); token_count++; }

";"                     { printf("%s special symbol\n", yytext); token_count++; }
","                     { printf("%s special symbol\n", yytext); token_count++; }
"("                     { printf("%s special symbol\n", yytext); token_count++; }
")"                     { printf("%s special symbol\n", yytext); token_count++; }

[ \t\n]+                ;
.                       { printf("%s unknown\n", yytext); token_count++; }
%%

int main() {
    yylex();
    printf("Total no. of tokens = %d\n", token_count);
    return 0;
}

int yywrap() {
    return 1;
}
