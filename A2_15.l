%{
	/* C Declarations and Definitions */
%}
/* Regular Expression Definitions */
KEYWORD "int"|"char"|"else"|"for"|"if"|"return"|"void"

BRACKETS [\{\}]|[\[\]]|[\(\)]
OPERATORS [\+\-\*\/%=!&\|!\?]|"->"
PUNCTUATION [;,\.\:]
LOGIC "&&"|"\|\|"
COMPARISON [<>=!]=?

INTEGER-CONSTANT [+-]?[1-9]+
CHAR-CONSTANT '[^'\\]?'
STRING-CONSTANT
ID [a-zA-Z][a-zA-Z0-9]*
WS [ ]+
NEWLINE [\n]



/* Definitions of Rules \& Actions */
%%
    /* Whitespace Rules */
{NEWLINE}   { printf("<NEWLINE>\n"); /* Newline Rule */ }
{WS}        { /* Ignore Whitespace */ }
    /* Keyword Rules */
{KEYWORD}    { printf("<KEYWORD, %s>\n", yytext); /* Keyword Rule */ }
    /* Punctuator Rules */
{BRACKETS}      { printf("<PUNCTUATOR, %s>\n", yytext); /* Punctuator Rule */ }
{OPERATORS}      { printf("<PUNCTUATOR, %s>\n", yytext); /* Punctuator Rule */ }
{PUNCTUATION}      { printf("<PUNCTUATOR, %s>\n", yytext); /* Punctuator Rule */ }
{LOGIC}      { printf("<PUNCTUATOR, %s>\n", yytext); /* Punctuator Rule */ }
{COMPARISON}      { printf("<PUNCTUATOR, %s>\n", yytext); /* Punctuator Rule */ }

{ID}        { printf("<ID, %s>\n", yytext); /* Identifier Rule & yytext points to lexeme */}
    /* Constant Rules */
{CHAR-CONSTANT} { printf("<CONSTANTc, %s>\n", yytext); /* Constant Rule */ }
{STRING-CONSTANT}
{INTEGER-CONSTANT} { printf("<CONSTANTi, %s>\n", yytext); /* Constant Rule */ }


%%

/* C functions */

yywrap() {}

int main() {
    yyin = fopen("A2_15.nc", "r");
    yylex();

    return 0;
}