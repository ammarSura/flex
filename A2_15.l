%{
#include "y.tab.h"
#include <stdio.h>  
void yyerror (const char * msg) {
    fprintf(stderr, "C-like : %s\n", msg);
    exit(1);
}
%}
%option noyywrap
/* Regular Expression Definitions */

INT "int"
CHAR "char"
IF "if"
ELSE "else"
FOR "for"
RETURN "return"
VOID "void"
COMMENT_SINGLE "\/\/".*
COMMENT_MULTI "/*"([^*]*|(\*+[^/]))*"*/"

BRACKETS [\{\}]|[\[\]]|[\(\)]
OPERATORS [\+\-\*\/%=!&\|!\?]|"->"
PUNCTUATION [,\.\:]

INTEGER_CONSTANT [+-]?[1-9]+
CHAR_CONSTANT '[^'\\]?'
STRING_CONSTANT \"([^\\\"]|\\.)*\"
ID [a-zA-Z][a-zA-Z0-9]*
SEMICOLON ";"
WS [ ]+

NEWLINE [\n]



/* Definitions of Rules \& Actions */
%%
    /* Whitespace Rules */
{NEWLINE}   {  /* Newline Rule */ }
{WS}        { /* Ignore Whitespace */ }
{COMMENT_SINGLE} { /* Ignore Comments */ } /* Comment Rule */
{COMMENT_MULTI}   { /* Ignore Comments */ } /* Comment Rule */
    /* Keyword Rules */

{INT} {return (KEYWRD_INT);}      
{CHAR} {return (KEYWRD_CHAR);}
{IF} {return (KEYWRD_IF);}
{ELSE} {return (KEYWRD_ELSE);}
{FOR} {return (KEYWRD_FOR);}
{RETURN} {return (KEYWRD_RETURN);}
{VOID} {return (KEYWRD_VOID);}

    /* Punctuator Rules */
"||" {return (LOGIC_OR);}
"&&" {return (LOGIC_AND);}
"!=" {return (NOT_EQUAL);}
"==" {return (EQUAL);}
"<=" {return (LT_EQUAL);}
">=" {return (GT_EQUAL);}
"->" {return (ARW_PTR);}
{BRACKETS}      { return *yytext; /* Punctuator Rule */ }
{OPERATORS}      { return *yytext; /* Punctuator Rule */ }
{PUNCTUATION}      {return *yytext; /* Punctuator Rule */ }

{ID}        { return (ID); /* Identifier Rule & yytext points to lexeme */}
    /* Constant Rules */
{CHAR_CONSTANT} { return *yytext; /* Constant Rule */ }
{STRING_CONSTANT} {return (STRING_CONST) /* Constant Rule */ }
{INTEGER_CONSTANT} { return (INTEGER_CONSTANT); /* Constant Rule */ }
{SEMICOLON} {return (SEMICOLON) /* Constant Rule */ }


%%

/* C functions */

yywrap() {}

int main() {
    yyin = fopen("A2_15.nc", "r");
    yylex();

    return 0;
}