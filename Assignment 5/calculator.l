%{
#include "y.tab.h"
#include <stdlib.h>
%}

%option noyywrap
%option yylineno

%%

    /* Numbers - integers and floating point */
[0-9]+          { yylval.dval = atof(yytext); return NUMBER; }
[0-9]+\.[0-9]*  { yylval.dval = atof(yytext); return NUMBER; }
\.[0-9]+        { yylval.dval = atof(yytext); return NUMBER; }

    /* Operators */
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"%"             { return '%'; }
"^"             { return '^'; }

    /* Parentheses */
"("             { return '('; }
")"             { return ')'; }

    /* Newline */
\n              { return '\n'; }

    /* Whitespace - ignore */
[ \t]+          { /* ignore whitespace */ }

    /* Comments - ignore */
#.*             { /* ignore comments starting with # */ }

    /* Invalid characters */
.               { 
                    fprintf(stderr, "Invalid character: %s\n", yytext); 
                }

%%