%{
#include <stdio.h>
%}

%%
[ \t\n]+    { putchar(' '); }
.           { putchar(yytext[0]); }
%%

int main(){
  yylex();
  return 0;
}
