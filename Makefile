SRC=main.c parse.tab.c lex.yy.c
all: ruby

ruby: ${SRC}
	cc -o ruby ${SRC}

lex.yy.c: ruby.l
	flex ruby.l

parse.tab.c: parse.y
	bison -d parse.y

clean:
	rm -rf ruby lex.yy.c parse.tab.c parse.tab.h
