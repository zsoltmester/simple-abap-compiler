#ABAP compiler
It has less feature, than the original.
##Compile this project
	- Step by step:
	    flex lexical.l
	    bisonc++ grammar.y
	    g++ -o AbapSimple lex.yy.cc main.cc parse.cc
	- Or with the makefile:
	    make
