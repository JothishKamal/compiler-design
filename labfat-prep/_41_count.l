%{
#include <stdio.h>
int lines=0, spaces=0, tabs=0;
%}

%%
\n      { lines++; }
[ ]     { spaces++; }
[\t]    { tabs++; }
.       ;
%%

int main(){ 
  yylex(); 
  printf("Lines: %d Spaces: %d Tabs: %d\n", lines, spaces, tabs); 
  return 0;
}
