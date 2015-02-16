SRC=main.c parse.tab.c lex.yy.c

all: ruby

ruby: ${SRC}
	cc -O0 -g -o ruby ${SRC}

lex.yy.c: ruby.l
	flex ruby.l

parse.tab.c: parse.y
	bison -v -d parse.y

clean:
	rm -rf ruby lex.yy.c parse.tab.c parse.tab.h parse.output

check:
	docker run -v `pwd`:/usr/src/ruby ruby bash -c "make clean && make && (valgrind --leak-check=full --show-reachable=yes ./ruby program.rb)"
