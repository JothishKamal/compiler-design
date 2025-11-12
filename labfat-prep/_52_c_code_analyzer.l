%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int kw_count = 0, id_count = 0, op_count = 0;
const char *keywords[] = {"auto","break","case","char","const","continue","default","do","double","else","enum","extern","float","for","goto","if","inline","int","long","register","return","short","signed","sizeof","static","struct","switch","typedef","union","unsigned","void","volatile","while", NULL};
int is_keyword(const char *s){ 
    for (int i=0; keywords[i]; ++i)
        if (strcmp(s, keywords[i])==0) 
            return 1; 
    return 0; 
}
%}

%%
"/*"([^*]|\*+[^*/])*\*+ "/"             ;
"//".*\n                                ;
[_a-zA-Z][_a-zA-Z0-9]*                  {
                                            if (is_keyword(yytext)) 
                                                kw_count++; 
                                            else
                                                id_count++;
                                        }
"=="|"!="|"<="|">="|"++"|"--"|"&&"|"||" { op_count++; }
[+\-*/%=&|<>!^~]                        { op_count++; }
[ \t\n]+                                ;
.                                       ;
%%

int main(int argc, char **argv) {
    if (argc<2) { printf("Usage: %s file.c\n", argv[0]); return 1; }
    FILE *f = fopen(argv[1],"r"); if (!f) { perror("fopen"); return 1; }
    yyin = f;
    yylex();
    printf("Keywords: %d\nIdentifiers: %d\nOperators: %d\n", kw_count, id_count, op_count);
    fclose(f);
    return 0;
}
