%{
#include "y.tab.h"
#include <string.h>
%}

%option noyywrap
%option yylineno

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ALNUM       [a-zA-Z0-9_]
WHITESPACE  [ \t\r]+

%%

    /* C Keywords */
"auto"      { yylval.str = strdup(yytext); return KEYWORD; }
"break"     { yylval.str = strdup(yytext); return KEYWORD; }
"case"      { yylval.str = strdup(yytext); return KEYWORD; }
"char"      { yylval.str = strdup(yytext); return KEYWORD; }
"const"     { yylval.str = strdup(yytext); return KEYWORD; }
"continue"  { yylval.str = strdup(yytext); return KEYWORD; }
"default"   { yylval.str = strdup(yytext); return KEYWORD; }
"do"        { yylval.str = strdup(yytext); return KEYWORD; }
"double"    { yylval.str = strdup(yytext); return KEYWORD; }
"else"      { yylval.str = strdup(yytext); return KEYWORD; }
"enum"      { yylval.str = strdup(yytext); return KEYWORD; }
"extern"    { yylval.str = strdup(yytext); return KEYWORD; }
"float"     { yylval.str = strdup(yytext); return KEYWORD; }
"for"       { yylval.str = strdup(yytext); return KEYWORD; }
"goto"      { yylval.str = strdup(yytext); return KEYWORD; }
"if"        { yylval.str = strdup(yytext); return KEYWORD; }
"int"       { yylval.str = strdup(yytext); return KEYWORD; }
"long"      { yylval.str = strdup(yytext); return KEYWORD; }
"register"  { yylval.str = strdup(yytext); return KEYWORD; }
"return"    { yylval.str = strdup(yytext); return KEYWORD; }
"short"     { yylval.str = strdup(yytext); return KEYWORD; }
"signed"    { yylval.str = strdup(yytext); return KEYWORD; }
"sizeof"    { yylval.str = strdup(yytext); return KEYWORD; }
"static"    { yylval.str = strdup(yytext); return KEYWORD; }
"struct"    { yylval.str = strdup(yytext); return KEYWORD; }
"switch"    { yylval.str = strdup(yytext); return KEYWORD; }
"typedef"   { yylval.str = strdup(yytext); return KEYWORD; }
"union"     { yylval.str = strdup(yytext); return KEYWORD; }
"unsigned"  { yylval.str = strdup(yytext); return KEYWORD; }
"void"      { yylval.str = strdup(yytext); return KEYWORD; }
"volatile"  { yylval.str = strdup(yytext); return KEYWORD; }
"while"     { yylval.str = strdup(yytext); return KEYWORD; }

    /* Operators - Compound assignments must come before single operators */
"+="        { yylval.str = strdup(yytext); return ASSIGN; }
"-="        { yylval.str = strdup(yytext); return ASSIGN; }
"*="        { yylval.str = strdup(yytext); return ASSIGN; }
"/="        { yylval.str = strdup(yytext); return ASSIGN; }
"%="        { yylval.str = strdup(yytext); return ASSIGN; }
"&="        { yylval.str = strdup(yytext); return ASSIGN; }
"|="        { yylval.str = strdup(yytext); return ASSIGN; }
"^="        { yylval.str = strdup(yytext); return ASSIGN; }
"<<="       { yylval.str = strdup(yytext); return ASSIGN; }
">>="       { yylval.str = strdup(yytext); return ASSIGN; }
"++"        { yylval.str = strdup(yytext); return INC; }
"--"        { yylval.str = strdup(yytext); return DEC; }
"<<"        { yylval.str = strdup(yytext); return LSHIFT; }
">>"        { yylval.str = strdup(yytext); return RSHIFT; }
"<="        { yylval.str = strdup(yytext); return LE; }
">="        { yylval.str = strdup(yytext); return GE; }
"=="        { yylval.str = strdup(yytext); return EQ; }
"!="        { yylval.str = strdup(yytext); return NE; }
"&&"        { yylval.str = strdup(yytext); return AND; }
"||"        { yylval.str = strdup(yytext); return OR; }
"->"        { yylval.str = strdup(yytext); return ARROW; }
"+"         { yylval.str = strdup(yytext); return PLUS; }
"-"         { yylval.str = strdup(yytext); return MINUS; }
"*"         { yylval.str = strdup(yytext); return MULT; }
"/"         { yylval.str = strdup(yytext); return DIV; }
"%"         { yylval.str = strdup(yytext); return MOD; }
"<"         { yylval.str = strdup(yytext); return LT; }
">"         { yylval.str = strdup(yytext); return GT; }
"&"         { yylval.str = strdup(yytext); return BITAND; }
"|"         { yylval.str = strdup(yytext); return BITOR; }
"^"         { yylval.str = strdup(yytext); return BITXOR; }
"~"         { yylval.str = strdup(yytext); return BITNOT; }
"!"         { yylval.str = strdup(yytext); return NOT; }
"="         { yylval.str = strdup(yytext); return ASSIGN; }
"?"         { yylval.str = strdup(yytext); return TERNARY; }

    /* Delimiters */
"("         { yylval.str = strdup(yytext); return LPAREN; }
")"         { yylval.str = strdup(yytext); return RPAREN; }
"{"         { yylval.str = strdup(yytext); return LBRACE; }
"}"         { yylval.str = strdup(yytext); return RBRACE; }
"["         { yylval.str = strdup(yytext); return LBRACKET; }
"]"         { yylval.str = strdup(yytext); return RBRACKET; }
";"         { yylval.str = strdup(yytext); return SEMICOLON; }
","         { yylval.str = strdup(yytext); return COMMA; }
"."         { yylval.str = strdup(yytext); return DOT; }
":"         { yylval.str = strdup(yytext); return COLON; }

    /* Identifiers */
{LETTER}{ALNUM}*    { yylval.str = strdup(yytext); return IDENTIFIER; }

    /* Numbers */
{DIGIT}+            { yylval.str = strdup(yytext); return NUMBER; }
{DIGIT}+"."{DIGIT}* { yylval.str = strdup(yytext); return NUMBER; }

    /* String Literals */
\"([^"\\\n]|\\.)*\" { yylval.str = strdup(yytext); return STRING_LITERAL; }

    /* Character Literals */
'([^'\\\n]|\\.)+'   { yylval.str = strdup(yytext); return CHAR_LITERAL; }

    /* Comments - ignore */
"/*"([^*]|\*+[^*/])*\*+"/"  { /* multi-line comment */ }
"//".*                       { /* single-line comment */ }

    /* Preprocessor directives - ignore */
^"#".*                       { /* preprocessor directive */ }

    /* Newlines */
\n          { /* line counting handled by %option yylineno */ }

    /* Whitespace */
{WHITESPACE} { /* ignore whitespace */ }

    /* Unknown characters */
.           { /* ignore other characters */ }

%%