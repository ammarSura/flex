%{
#include <string.h>
#include <stdio.h>
#include <iostream>
#include "parser.h"

extern int yylex();
void yyerror(char *s);
struct quadarray* array[NSYMS]; // Store of Quads
int quadPtr = 0; // Index of next quad
%}

%union { // Placeholder for a value
	struct symtab *symp;
    int intval;
} 
/* %token <symp> NAME */


%start translation_unit

%token <symp>KEYWRD_VOID KEYWRD_INT KEYWRD_CHAR KEYWRD_IF KEYWRD_ELSE KEYWRD_FOR KEYWRD_RETURN
%token <intval>INT_CONST 
%token <symp>STRING_CONST CONST ID
%token <symp>LT_EQUAL GT_EQUAL EQUAL NOT_EQUAL LOGIC_AND LOGIC_OR ARW_PTR

%type <symp> primary_expression postfix_expression argument_expression_list_opt argument_expression_list assignment_expression unary_expression unary_operator multiplicative_expression additive_expression relational_expression equality_expression logical_AND_expression logical_OR_expression conditional_expression expression declaration type_specifier init_declarator constant_expression declarator direct_declarator parameter_list parameter_declaration pointer_opt statement pointer compound_statement id_opt expression_statement selection_statement iteration_statement jump_statement translation_unit function_definition declaration_list initializer block_item_list block_item block_item_list_opt expression_opt declaration_list_opt

/* %type <symp> KEYWRD_INT */


%left '+'
%left '-'
%left '*'
%left '/'
%left '%'

%left '<'
%left '>'
%left LT_EQUAL
%left GT_EQUAL
%left EQUAL
%left NOT_EQUAL
%left LOGIC_AND
%left LOGIC_OR
%right '?'
%right ':'
%right '='

%%
primary_expression: ID
    {$$ = $1, printf("primary_expression -> ID\n");}
| constant_expression
    {$$ = $1, printf("primary_expression -> constant_expression\n");}
| STRING_CONST
    {$$ = $1, printf("primary_expression -> STRING_CONST");}
| '(' expression ')' 
    {$$ = $2, printf("primary_expression -> '(' expression ')");}
;

postfix_expression: primary_expression
    {$$ = $1, printf("postfix_expression -> primary_expression\n");}
| postfix_expression '[' expression ']'
    { printf("postfix_expression -> postfix_expression '[' expression ']'\n");}
| postfix_expression '(' argument_expression_list_opt ')'
    {printf("postfix_expression -> postfix_expression '(' argument_expression_list_opt ')'\n");}
| postfix_expression ARW_PTR ID
    {printf("postfix_expression -> postfix_expression ARW_PTR ID\n");}
;

argument_expression_list_opt: argument_expression_list
    {$$ = $1, printf("argument_expression_list_opt -> argument_expression_list\n");}
| /* empty */
    {$$ = NULL, printf("argument_expression_list_opt -> %epmty\n");}
;

argument_expression_list: assignment_expression
    {$$ = $1, printf("argument_expression_list -> assignment_expression\n");}
| argument_expression_list ',' assignment_expression
    {$$ = $1, $3, printf("argument_expression_list -> argument_expression_list ',' assignment_expression\n");}
;

unary_expression: postfix_expression
    {$$ = $1, printf("unary_expression -> postfix_expression\n");}
| unary_operator unary_expression
    {$$ = $1, printf("unary_expression -> unary_operator unary_expression\n");}
;

unary_operator: '&'
    {
        // $$ = '&';
        printf("unary_operator opx-> &\n");
        }
| '*'
    {printf("unary_operator -> '*'\n");}
| '+'
    {printf("unary_operator -> '+'\n");}
| '-'
    {printf("unary_operator -> '-'\n");}
| '!'
    {printf("unary_operator -> '!'\n");}
;

multiplicative_expression: unary_expression
    {printf("multiplicative_expression -> unary_expression\n");}
| multiplicative_expression '*' unary_expression
    {printf("multiplicative_expression -> multiplicative_expression '*' unary_expression\n");}
| multiplicative_expression '/' unary_expression
    {printf("multiplicative_expression -> multiplicative_expression '/' unary_expression\n");}
| multiplicative_expression '%' unary_expression
    {printf("multiplicative_expression -> multiplicative_expression '%' unary_expression\n");}
;

additive_expression: multiplicative_expression
    {printf("additive_expression -> multiplicative_expression\n");}
| additive_expression '+' multiplicative_expression 
    {printf("additive_expression -> additive_expression '+' multiplicative_expression\n");}
| additive_expression '-' multiplicative_expression
    {printf("additive_expression -> additive_expression '-' multiplicative_expression\n");}
;

relational_expression: additive_expression
    {printf("relational_expression -> additive_expression\n");}
| relational_expression '<' additive_expression
    {printf("relational_expression -> relational_expression '<' additive_expression\n");}
| relational_expression '>' additive_expression
    {printf("relational_expression -> relational_expression '>' additive_expression\n");}
| relational_expression LT_EQUAL additive_expression
    {printf("relational_expression -> relational_expression LT_EQUAL additive_expression\n");}
| relational_expression GT_EQUAL additive_expression
    {printf("relational_expression -> relational_expression GT_EQUAL additive_expression\n");}
;

equality_expression: relational_expression
    {printf("equality_expression -> relational_expression\n");}
| equality_expression EQUAL relational_expression
    {printf("equality_expression -> equality_expression EQUAL relational_expression\n");}
| equality_expression NOT_EQUAL relational_expression
    {printf("equality_expression -> equality_expression NOT_EQUAL relational_expression\n");}
;

logical_AND_expression: equality_expression
    {printf("logical_AND_expression -> equality_expression\n");}
| logical_AND_expression LOGIC_AND equality_expression
    {printf("logical_AND_expression -> logical_AND_expression LOGIC_AND equality_expression\n");}
;

logical_OR_expression: logical_AND_expression
    {printf("logical_OR_expression -> logical_AND_expression\n");}
| logical_OR_expression LOGIC_OR logical_AND_expression
    {printf("logical_OR_expression -> logical_OR_expression LOGIC_OR logical_AND_expression\n");}
;

conditional_expression: logical_OR_expression
    {printf("conditional_expression -> logical_OR_expression\n");}
| logical_OR_expression '?' expression ':' conditional_expression
    {printf("conditional_expression -> logical_OR_expression '?' expression ':' conditional_expression\n");}
;

assignment_expression: conditional_expression 
    {printf("assignment_expression -> conditional_expression\n");}
| unary_expression '=' assignment_expression
    {printf("assignment_expression -> unary_expression '=' assignment_expression\n");}
;

expression: assignment_expression 
    {printf("expression -> assignment_expression\n");}
;

declaration: type_specifier init_declarator ';'
    {printf("declaration -> type_specifier init_declarator ';'\n");}
;

init_declarator: declarator
    {printf("init_declarator -> declarator\n");}
| declarator '=' initializer
    {printf("init_declarator -> declarator '=' initializer\n");}
;

type_specifier: 
    {printf("type_specifier -> null\n");}
| KEYWRD_VOID
    {printf("type_specifier -> KEYWRD_VOID\n");}
| KEYWRD_INT
    {printf("type_specifier -> KEYWRD_INT %s\n");}
| KEYWRD_CHAR
    {printf("type_specifier -> KEYWRD_CHAR\n");}
;

declarator: pointer_opt direct_declarator

;

direct_declarator: ID
    {printf("direct_declarator -> ID\n");}
| ID '[' INT_CONST ']'
    {printf("direct_declarator -> ID '[' INT_CONST ']'\n");}
| ID '[' parameter_list ']'
    {printf("direct_declarator -> ID '[' parameter_list ']'\n");}
;

pointer_opt: pointer
    {$$ = $1, printf("pointer_opt -> pointer\n");}
|
    {$$ = NULL, printf("pointer_opt -> null\n");}
;

pointer: '*'
    {printf("pointer -> '*'\n");}
;

parameter_list: parameter_declaration
    {$$ = $1, printf("parameter_list -> parameter_declaration\n");}
| parameter_list ',' parameter_declaration
    {$$ = $1, $3, printf("parameter_list -> parameter_list ',' parameter_declaration\n");}
;

parameter_declaration: type_specifier pointer_opt id_opt
    {printf("parameter_declaration -> type_specifier pointer_opt id_opt\n");}
;

id_opt: ID ';'
    {printf("id_opt -> ID ';'\n");}
| /* empty */
    {$$ = NULL, printf("id_opt -> null\n");}
;

initializer: assignment_expression
    {$$ = $1, printf("initializer -> assignment_expression\n");}
;

statement: expression_statement
    {$$ = $1, printf("statement -> expression_statement\n");}
| compound_statement
    {$$ = $1, printf("statement -> compound_statement\n");}
| selection_statement
    {$$ = $1, printf("statement -> selection_statement\n");}
| iteration_statement
    {$$ = $1, printf("statement -> iteration_statement\n");}
| jump_statement
    {$$ = $1, printf("statement -> jump_statement\n");}
;

compound_statement: '{' block_item_list_opt '}'
    {$$ = $2, printf("compound_statement -> '{' block_item_list_opt '}'\n");}
;

block_item_list_opt: block_item_list
    {$$ = $1, printf("block_item_list_opt -> block_item_list\n");}
|
    {$$ = NULL, printf("block_item_list_opt -> null\n");}
;

block_item_list: block_item
    {$$ = $1, printf("block_item_list -> block_item\n");}
| block_item_list block_item
    {printf("block_item_list -> block_item_list block_item\n");}
;

block_item: declaration
    {$$ = $1, printf("block_item -> declaration\n");}
| statement
    {$$ = $1, printf("block_item -> statement\n");}
;

expression_statement: expression_opt 
    {$$ = $1, printf("expression_statement -> expression_opt");}
;

expression_opt: expression ';'
    {$$ = $1, printf("expression_opt -> expression ';'\n");}
|
    {$$ = NULL, printf("expression_opt -> null\n");}
;

selection_statement: KEYWRD_IF '(' expression ')' statement
    {printf("selection_statement -> KEYWRD_IF '(' expression ')' statement\n");}
| KEYWRD_IF '(' expression ')' statement KEYWRD_ELSE statement
    {printf("selection_statement -> KEYWRD_IF '(' expression ')' statement KEYWRD_ELSE statement\n");}
;

iteration_statement: KEYWRD_FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement
    {printf("iteration_statement -> KEYWRD_FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement\n");}
;

jump_statement: KEYWRD_RETURN expression_opt 
    {printf("jump_statement -> KEYWRD_RETURN expression_opt ';'\n");}
;

translation_unit: function_definition
    {$$ = $1, printf("translation_unit -> function_definition\n");}
| declaration
    {$$ = $1, printf("translation_unit -> declaration\n");}
;

function_definition: type_specifier declarator '(' declaration_list_opt ')' compound_statement
    {printf("function_definition -> type_specifier declarator '(' declaration_list_opt ')' compound_statement\n");}
;

declaration_list_opt: declaration_list ';'
    {$$ = $1, printf("declaration_list_opt -> declaration_list ';'\n");}
|
;

declaration_list: declaration
    {$$ = $1, printf("declaration_list -> declaration\n");}
| declaration_list declaration ';'
    {printf("declaration_list -> declaration_list declaration ';'\n");}
;

constant_expression: INT_CONST
    {$$ = $1, printf("constant_expression -> INT_CONST, \n");}
| CONST 
    {printf("constant_expression -> CONST\n");}
;

%%

void yyerror(char *s) {
    std::cout << s << std::endl;
}
int main() {
    /* #ifdef YYDEBUG
        yydebug=1; */
    /* #endif */
    yyparse();
}