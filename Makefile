COMPILERNAME=AbapSimple

all: $(COMPILERNAME)
	-

clean:
	rm -rf $(COMPILERNAME) lex.yy.cc Parserbase.h parse.cc *~

lex.yy.cc: lexical.l
	flex lexical.l

parse.cc: grammar.y
	bisonc++ grammar.y

$(COMPILERNAME): main.cc lex.yy.cc parse.cc Parser.ih Parser.h
	g++ -o $(COMPILERNAME) main.cc parse.cc lex.yy.cc
