%{
#include "calc.tab.h"
%}

%%
[0-9]+  { yylval.ival = atoi(yytext); return NUM; }
[ \t\n] ;
"+"     return PLUS;
"-"     return MINUS;
"*"     return MUL;
"/"     return DIV;
"%"     return MOD;
"^"     return POW;
"("     return LP;
")"     return RP;
.       { return yytext[0]; }
%%

int yywrap(){ 
  return 1; 
}
