%{
#include <stdio.h>
%}

%%
[ \t\n]+     { printf(" "); }     /* Replace any sequence of spaces/tabs/newlines with single space */
.            { printf("%s", yytext); }
%%

int main() {
    yylex();
    return 0;
}
