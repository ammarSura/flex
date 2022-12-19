/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     KEYWRD_VOID = 258,
     KEYWRD_INT = 259,
     KEYWRD_CHAR = 260,
     KEYWRD_IF = 261,
     KEYWRD_ELSE = 262,
     KEYWRD_FOR = 263,
     KEYWRD_RETURN = 264,
     INT_CONST = 265,
     STRING_CONST = 266,
     CONST = 267,
     ID = 268,
     LT_EQUAL = 269,
     GT_EQUAL = 270,
     EQUAL = 271,
     NOT_EQUAL = 272,
     LOGIC_AND = 273,
     LOGIC_OR = 274,
     ARW_PTR = 275
   };
#endif
/* Tokens.  */
#define KEYWRD_VOID 258
#define KEYWRD_INT 259
#define KEYWRD_CHAR 260
#define KEYWRD_IF 261
#define KEYWRD_ELSE 262
#define KEYWRD_FOR 263
#define KEYWRD_RETURN 264
#define INT_CONST 265
#define STRING_CONST 266
#define CONST 267
#define ID 268
#define LT_EQUAL 269
#define GT_EQUAL 270
#define EQUAL 271
#define NOT_EQUAL 272
#define LOGIC_AND 273
#define LOGIC_OR 274
#define ARW_PTR 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "parser.y"
{ // Placeholder for a value
	struct symtab *symp;
    int intval;
}
/* Line 1529 of yacc.c.  */
#line 94 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

