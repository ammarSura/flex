%{

%}

%%

[a-z] { printf("Found a lowercase letter");}
. { printf("Found a non-letter");}

\n { printf("Found a newline");}
%%

yywrap() {}

int main() {
    printf("Enter a string: ");
    yylex();

    return 0;
}