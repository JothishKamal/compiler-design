%{
#include <stdio.h>
int words=0;
%}

%%
[ \t\n]+        ;
[A-Za-z0-9]+    { words++; }
.               ;
%%

int main(){ 
  yylex();
  printf("Words: %d\n", words);
  return 0;
}
