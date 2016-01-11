TODO makefile-t kell csinálnom

Fordítás a pandora.inf.elte.hu szerveren:

flex lexical.l
bisonc++ grammar.y
g++ -o compiler lex.yy.cc main.cc parse.cc
