%{
#include <string.h>
#include <iostream>
extern int yylex();
void yyerror(char *s);
%}


%token KEYWRD_VOID KEYWRD_INT KEYWRD_CHAR KEYWRD_IF KEYWRD_ELSE KEYWRD_FOR KEYWRD_RETURN

%token INT_CONST STRING_CONST CONST ID

%token LT_EQUAL GT_EQUAL EQUAL NOT_EQUAL LOGIC_AND LOGIC_OR ARW_PTR

%start translation_unit

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
| constant_expression
| STRING_CONST
| '(' expression ')'
;

postfix_expression: primary_expression
| postfix_expression '[' expression ']'
| postfix_expression '(' argument_expression_list_opt ')'
| postfix_expression ARW_PTR ID
;

argument_expression_list_opt: argument_expression_list
|
;

argument_expression_list: assignment_expression
| argument_expression_list ',' assignment_expression
;

unary_expression: postfix_expression
| unary_operator unary_expression
;

unary_operator: '&'
| '*'
| '+'
| '-'
| '!'
;

multiplicative_expression: unary_expression
| multiplicative_expression '*' unary_expression
| multiplicative_expression '/' unary_expression
| multiplicative_expression '%' unary_expression
;

additive_expression: multiplicative_expression
| additive_expression '+' multiplicative_expression 
| additive_expression '-' multiplicative_expression
;

relational_expression: additive_expression
| relational_expression '<' additive_expression
| relational_expression '>' additive_expression
| relational_expression LT_EQUAL additive_expression
| relational_expression GT_EQUAL additive_expression
;

equality_expression: relational_expression
| equality_expression EQUAL relational_expression
| equality_expression NOT_EQUAL relational_expression
;

logical_AND_expression: equality_expression
| logical_AND_expression LOGIC_AND equality_expression
;

logical_OR_expression: logical_AND_expression
| logical_OR_expression LOGIC_OR logical_AND_expression
;

conditional_expression: logical_OR_expression '?' expression ':' logical_AND_expression
| logical_OR_expression '?' expression ':' conditional_expression
;

assignment_expression: conditional_expression ';'
| unary_expression '=' assignment_expression
;

expression: assignment_expression ';'
;

declaration: type_specifier init_declarator ';'
;

init_declarator: declarator
| declarator '=' initializer
;

type_specifier: KEYWRD_VOID
| KEYWRD_INT
| KEYWRD_CHAR
;

declarator: pointer_opt direct_declarator
;

parameter_list_opt: parameter_list
|
;

direct_declarator: ID
| ID '[' INT_CONST ']'
| ID '[' parameter_list_opt ']'
;

pointer_opt: pointer
|
;

pointer: '*'
;

parameter_list: parameter_declaration
| parameter_list ',' parameter_declaration
;

parameter_declaration: type_specifier pointer_opt id_opt
;

id_opt: ID ';'
|
;

initializer: assignment_expression
;

statement: expression_statement
| compound_statement
| selection_statement
| iteration_statement
| jump_statement
;

compound_statement: '{' block_item_list_opt '}'
;

block_item_list_opt: block_item_list
|
;

block_item_list: block_item
| block_item_list block_item
;

block_item: declaration
| statement
;

expression_statement: expression_opt ';'
;

expression_opt: expression ';'
|
;

selection_statement: KEYWRD_IF '(' expression ')' statement
| KEYWRD_IF '(' expression ')' statement KEYWRD_ELSE statement
;

iteration_statement: KEYWRD_FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement
;

jump_statement: KEYWRD_RETURN expression_opt ';'
;

translation_unit: function_definition
| declaration
;

function_definition: type_specifier declarator '(' declaration_list_opt ')' compound_statement
;

declaration_list_opt: declaration_list ';'
|
;

declaration_list: declaration
| declaration_list declaration ';'
;

constant_expression: INT_CONST
| CONST 
;

%%

void yyerror(char *s) {
    std::cout << s << std::endl;
}
int main() {
    #ifdef YYDEBUG
        yydebug=1;
    #endif
    yyparse();
}