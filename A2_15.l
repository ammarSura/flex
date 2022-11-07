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

%x MULTILINE_COMMENT_NC    
%x SINGLELINE_COMMENT_NC

%%


"/*"            {BEGIN(MULTILINE_COMMENT_NC); }
<MULTILINE_COMMENT_NC>"*/" {BEGIN(INITIAL); }
<MULTILINE_COMMENT_NC>\n   {}
<MULTILINE_COMMENT_NC>.    {}

"//"            { BEGIN(SINGLELINE_COMMENT_NC); }
<SINGLELINE_COMMENT_NC>\n    {BEGIN(INITIAL); }
<SINGLELINE_COMMENT_NC>. {}

    /* Whitespace Rules */
{NEWLINE}   {  /* Newline Rule */ }
{WS}        { /* Ignore Whitespace */ }

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
{BRACKETS}      { return yytext[0]; /* Punctuator Rule */ }
{OPERATORS}      { return yytext[0]; /* Punctuator Rule */ }
{PUNCTUATION}      {return yytext[0]; /* Punctuator Rule */ }

{ID}        { return (ID); /* Identifier Rule & yytext points to lexeme */}
    /* Constant Rules */
{CHAR_CONSTANT} { return yytext[0]; /* Constant Rule */ }
{STRING_CONSTANT} {return (STRING_CONST); /* Constant Rule */ }
{INTEGER_CONSTANT} { return (INT_CONST); /* Constant Rule */ }
{SEMICOLON} {return yytext[0]; /* Constant Rule */ }


%%
