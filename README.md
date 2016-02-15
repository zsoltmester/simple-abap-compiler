#A simple ABAP compiler, with a way less feature than to original.
##Compile:
	- Step by step:
	    flex lexical.l
	    bisonc++ grammar.y
	    g++ -o AbapSimple lex.yy.cc main.cc parse.cc
	- Or with the makefile:
	    make
