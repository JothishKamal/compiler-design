%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(const char *s){ fprintf(stderr,"error: %s\n", s); }
%}

%union { int ival; }
%token <ival> NUM
%token PLUS MINUS MUL DIV MOD POW LP RP
%left PLUS MINUS
%left MUL DIV MOD
%right POW

%%
input: /* empty */ 
     | input line
     ;
line: '\n'
    | expr '\n' { printf("= %d\n", $1); }
    ;
expr: NUM { $$ = $1; }
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | expr MOD expr { $$ = $1 % $3; }
    | expr POW expr { $$ = (int)pow($1, $3); }
    | LP expr RP { $$ = $2; }
    ;
%%

int main(){ 
  printf("Enter expressions, Ctrl+D to exit\n"); 
  yyparse(); 
  return 0; 
}
