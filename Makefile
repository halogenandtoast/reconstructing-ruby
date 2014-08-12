all: ruby

ruby: main.c lex.yy.c
	cc -o ruby main.c lex.yy.c

lex.yy.c: ruby.l
	flex ruby.l

clean:
	rm -rf ruby lex.yy.c
