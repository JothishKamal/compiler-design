%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
extern FILE *yyin;
extern int yylineno;

int keyword_count = 0;
int identifier_count = 0;
int operator_count = 0;

typedef struct {
    char *name;
    int count;
} TokenInfo;

TokenInfo keywords[100];
TokenInfo identifiers[100];
TokenInfo operators[100];

int kw_idx = 0, id_idx = 0, op_idx = 0;

void add_token(TokenInfo *array, int *idx, const char *name) {
    for (int i = 0; i < *idx; i++) {
        if (strcmp(array[i].name, name) == 0) {
            array[i].count++;
            return;
        }
    }
    array[*idx].name = strdup(name);
    array[*idx].count = 1;
    (*idx)++;
}

void print_results() {
    printf("\n========== ANALYSIS RESULTS ==========\n\n");
    
    printf("KEYWORDS FOUND (%d total):\n", keyword_count);
    printf("%-20s %s\n", "Keyword", "Count");
    printf("----------------------------------------\n");
    for (int i = 0; i < kw_idx; i++) {
        printf("%-20s %d\n", keywords[i].name, keywords[i].count);
    }
    
    printf("\nIDENTIFIERS FOUND (%d total):\n", identifier_count);
    printf("%-20s %s\n", "Identifier", "Count");
    printf("----------------------------------------\n");
    for (int i = 0; i < id_idx; i++) {
        printf("%-20s %d\n", identifiers[i].name, identifiers[i].count);
    }
    
    printf("\nOPERATORS FOUND (%d total):\n", operator_count);
    printf("%-20s %s\n", "Operator", "Count");
    printf("----------------------------------------\n");
    for (int i = 0; i < op_idx; i++) {
        printf("%-20s %d\n", operators[i].name, operators[i].count);
    }
    
    printf("\n======================================\n");
}
%}

%union {
    char *str;
}

%token <str> KEYWORD IDENTIFIER
%token <str> PLUS MINUS MULT DIV MOD
%token <str> ASSIGN EQ NE LT GT LE GE
%token <str> AND OR NOT
%token <str> BITAND BITOR BITXOR BITNOT LSHIFT RSHIFT
%token <str> INC DEC
%token <str> LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET
%token <str> SEMICOLON COMMA DOT ARROW
%token <str> NUMBER STRING_LITERAL CHAR_LITERAL
%token <str> TERNARY COLON

%start program

%%

program:
    /* empty */
    | program statement
    ;

statement:
    KEYWORD         { add_token(keywords, &kw_idx, $1); keyword_count++; free($1); }
    | IDENTIFIER    { add_token(identifiers, &id_idx, $1); identifier_count++; free($1); }
    | operator      { }
    | NUMBER        { free($1); }
    | STRING_LITERAL { free($1); }
    | CHAR_LITERAL  { free($1); }
    | LPAREN        { free($1); }
    | RPAREN        { free($1); }
    | LBRACE        { free($1); }
    | RBRACE        { free($1); }
    | LBRACKET      { free($1); }
    | RBRACKET      { free($1); }
    | SEMICOLON     { free($1); }
    | COMMA         { free($1); }
    | DOT           { free($1); }
    | COLON         { free($1); }
    ;

operator:
    PLUS        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | MINUS     { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | MULT      { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | DIV       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | MOD       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | ASSIGN    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | EQ        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | NE        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | LT        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | GT        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | LE        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | GE        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | AND       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | OR        { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | NOT       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | BITAND    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | BITOR     { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | BITXOR    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | BITNOT    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | LSHIFT    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | RSHIFT    { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | INC       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | DEC       { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | ARROW     { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    | TERNARY   { add_token(operators, &op_idx, $1); operator_count++; free($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
        printf("Analyzing file: %s\n", argv[1]);
    } else {
        printf("Reading from standard input...\n");
        yyin = stdin;
    }
    
    yyparse();
    print_results();
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}