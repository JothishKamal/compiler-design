%{
#include <stdio.h>
#include <math.h>
%}

%%
[0-9]+  {
          int n = atoi(yytext);
          int tmp = n, sum = 0, digits = 0;
          while(tmp){ 
            digits++; 
            tmp/=10; 
          }
          tmp = n;
          while(tmp){ 
            int r = tmp % 10;
            sum += pow(r, digits);
            tmp /= 10;
          }
          if (sum==n)
            printf("%d is Armstrong\n", n);
          else 
            printf("%d is not Armstrong\n", n);
        }
\n      ;
.       ;
%%

int main(){ 
  yylex(); 
  return 0;
}
