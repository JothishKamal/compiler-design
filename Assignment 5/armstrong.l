%{
#include <stdio.h>
#include <math.h>

int isArmstrong(int num) {
    int n = num, sum = 0, digits = 0;
    while (n > 0) {
        digits++;
        n /= 10;
    }
    n = num;
    while (n > 0) {
        int d = n % 10;
        sum += pow(d, digits);
        n /= 10;
    }
    return sum == num;
}
%}

%%
[0-9]+  {
            int num = atoi(yytext);
            if (isArmstrong(num))
                printf("%d is an Armstrong number.\n", num);
            else
                printf("%d is NOT an Armstrong number.\n", num);
        }
.|\n    ;   /* Ignore everything else */
%%

int main() {
    printf("Enter a number: ");
    yylex();
    return 0;
}
