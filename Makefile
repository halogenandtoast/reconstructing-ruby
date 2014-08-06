all: ruby

ruby: lex.yy.c
	cc -o ruby lex.yy.c

lex.yy.c: ruby.l
	flex ruby.l

clean:
	rm ruby lex.yy.c
