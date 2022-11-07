parser:
	flex --debug A2_15.l
	yacc -dtv A2_15.y
	g++ -c lex.yy.c
	g++ -c y.tab.c 
	g++ lex.yy.o y.tab.o -ll
	./a.out < A2_15.nc




