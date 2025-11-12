%{
#include <stdio.h>
int vowels=0, cons=0;
%}

%%
[aAeEiIoOuU]    { vowels++; }
[a-zA-Z]        { cons++; }
.|\n            ;

%%

int main(){ 
  yylex(); 
  printf("Vowels: %d, Consonants: %d\n", vowels, cons); 
  return 0;
}
