Fordítás (a pandora.inf.elte.hu-n):
	> Külön:
	  flex lexical.l
	  bisonc++ grammar.y
	  g++ -o AbapSimple lex.yy.cc main.cc parse.cc
	> Makefile-al:
	  make

Feltölteni egy filet:
	> scp -r ./<a_file_neve> qt3qf8@pandora.inf.elte.hu:~/Compiler/AbapSimple 
