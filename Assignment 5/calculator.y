%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type <dval> expression term factor power

%left '+' '-'
%left '*' '/' '%'
%right '^'

%%

program:
    /* empty */
    | program line
    ;

line:
    '\n'
    | expression '\n'   { printf("Result: %.2f\n\n", $1); }
    | error '\n'        { yyerrok; }
    ;

expression:
    term                    { $$ = $1; }
    | expression '+' term   { $$ = $1 + $3; }
    | expression '-' term   { $$ = $1 - $3; }
    ;

term:
    power                   { $$ = $1; }
    | term '*' power        { $$ = $1 * $3; }
    | term '/' power        { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | term '%' power        {
        if ($3 == 0) {
            yyerror("Modulo by zero");
            $$ = 0;
        } else {
            $$ = fmod($1, $3);
        }
    }
    ;

power:
    factor                  { $$ = $1; }
    | factor '^' power      { $$ = pow($1, $3); }
    ;

factor:
    NUMBER                  { $$ = $1; }
    | '(' expression ')'    { $$ = $2; }
    | '+' factor            { $$ = $2; }
    | '-' factor            { $$ = -$2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("========================================\n");
    printf("     Simple Calculator\n");
    printf("========================================\n");
    printf("Supported operations:\n");
    printf("  +  : Addition\n");
    printf("  -  : Subtraction\n");
    printf("  *  : Multiplication\n");
    printf("  /  : Division\n");
    printf("  %%  : Modulo\n");
    printf("  ^  : Exponentiation (power)\n");
    printf("  () : Parentheses for grouping\n");
    printf("\nExamples:\n");
    printf("  2 + 3 * 4\n");
    printf("  (2 + 3) * 4\n");
    printf("  2 ^ 3\n");
    printf("  10 %% 3\n");
    printf("\nEnter expressions (Ctrl+D or Ctrl+Z to exit):\n");
    printf("========================================\n\n");
    
    yyparse();
    
    printf("\nThank you for using the calculator!\n");
    return 0;
}