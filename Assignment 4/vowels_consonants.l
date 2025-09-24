%{
    int vowels = 0, consonants = 0;
%}

%%
[aeiouAEIOU]       { vowels++; }          /* Match vowels */
[a-zA-Z]           { consonants++; }      /* Match consonants */
.|\n               ;                      /* Ignore everything else */
%%

int main() {
    yylex();
    printf("Number of vowels are: %d\n", vowels);
    printf("Number of consonants are: %d\n", consonants);
    return 0;
}

int yywrap() {
    return 1;
}
