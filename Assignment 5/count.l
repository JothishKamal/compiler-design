%{
#include <stdio.h>
int lines = 0, spaces = 0, tabs = 0;
%}

%%
\n          { lines++; }
" "         { spaces++; }
"\t"        { tabs++; }
.           ;
%%

int main() {
    yylex();
    printf("Number of lines: %d\n", lines);
    printf("Number of spaces: %d\n", spaces);
    printf("Number of tabs: %d\n", tabs);
    return 0;
}
