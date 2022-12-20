%{
#include "parser.h"
#include "parser.c"
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
OPERATORS [\+\-\*\/%=!\|\!\?&]|"->"
PUNCTUATION [,\.\:]

INTEGER_CONSTANT [+-]?[0-9]+
CHAR_CONSTANT '[^'\\]?'
STRING_CONSTANT \"([^\\\"]|\\.)*\"
ID [a-zA-Z_][a-zA-Z0-9_]*
SEMICOLON ";"
WS [\t\n]

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
{WS}+        { /* Ignore Whitespace */ }

    /* Keyword Rules */

{INT}       {
                yylval.symp = symlook(yytext);
                printf("bez = %s\n", yytext);
                return (KEYWRD_INT);
            }      
{CHAR}      {   
                yylval.symp = symlook(yytext);
                return (KEYWRD_CHAR);
            }
{IF}        {
                yylval.symp = symlook(yytext);
                return (KEYWRD_IF);
            }
{ELSE}      {
                yylval.symp = symlook(yytext);
                return (KEYWRD_ELSE);
            }
{FOR}       {   
                yylval.symp = symlook(yytext);
                return (KEYWRD_FOR);
            }
{RETURN}    {
                yylval.symp = symlook(yytext);
                return (KEYWRD_RETURN);
            }
{VOID}      {   
                yylval.symp = symlook(yytext);
                return (KEYWRD_VOID);
            }

    /* Punctuator Rules */
"||"        {
                yylval.symp = symlook(yytext);
                return (LOGIC_OR);
            }
"&&"        {
                yylval.symp = symlook(yytext);
                return (LOGIC_AND);
            }
"!="        {
                yylval.symp = symlook(yytext);
                return (NOT_EQUAL);
            }
"=="        {
                yylval.symp = symlook(yytext);
                return (EQUAL);
            }
"<="        {
                yylval.symp = symlook(yytext);
                return (LT_EQUAL);
            }
">="        {
                yylval.symp = symlook(yytext);
                return (GT_EQUAL);
            }
"->"        {
                yylval.symp = symlook(yytext);
                return (ARW_PTR);
            }
{BRACKETS}      {   
                    yylval.symp = symlook(yytext);
                    return *yytext; /* Punctuator Rule */ 
                }
{OPERATORS}     { 
                    yylval.symp = symlook(yytext);
                    return *yytext; /* Punctuator Rule */
                }
{PUNCTUATION}   {
                    yylval.symp = symlook(yytext);
                    return *yytext; /* Punctuator Rule */ 
                }

{ID}            { 
                    yylval.symp = symlook(yytext);
                    return (ID); /* Identifier Rule & yytext points to lexeme */
                }
    /* Constant Rules */
{CHAR_CONSTANT} { 
                    yylval.symp = symlook(yytext);
                    return *yytext; /* Constant Rule */ 
                }
{STRING_CONSTANT}   {
                        yylval.symp = symlook(yytext);
                        return (STRING_CONST); /* Constant Rule */ 
                    }
{INTEGER_CONSTANT}  { 
                        yylval.symp = symlook(yytext);
                        yylval.intval = atoi(yytext);
                        // printf("bez = %s\n", yytext);
                        return (INT_CONST); /* Constant Rule */ 
                    }
{SEMICOLON}         {
                        yylval.symp = symlook(yytext);
                        return *yytext; /* Constant Rule */ 
                    }


%%
