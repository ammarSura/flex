create-lexer:
	flex A2_15.l;
	gcc lex.yy.c A2_15.c -ll;
	./a.out < A2_15.nc;




