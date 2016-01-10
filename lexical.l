%option noyywrap c++ yylineno

%{
	#include <iostream>
	#include <cstdlib>
	#include <sstream>

	#define DEBUG true

	void print_token(std::string token) {
		std::cout << token << std::endl;
	}

	void print_debug_message(std::string message) {
		if(DEBUG) {
			std::cout << "[DEBUG] " << message << std::endl;
		}
	}

	void print_error_message(std::string message) {
		std::cerr << "[ERROR] " << message << std::endl;
	}
%}

LOWER_CASE_LETTER [a-z]
DIGIT [0-9]
LEFT_BRACKET [(]
RIGHT_BRACKET [)]
WHITEPACE [ \t\n]

COMMENT_INDICATOR \*
END_STATEMENT_CHARACTER \.

PROGRAM_KEYWORD PROGRAM

DATA_KEYWORD DATA
DATA_SUFIX :
DATA_SEPARATOR ,

TYPE_KEYWORD TYPE
TYPE_KEYWORD_I I
TYPE_I_IDENTIFIER {DIGIT}+
TYPE_KEYWORD_B B
TYPE_KEYWORD_B_TRUE TRUE
TYPE_KEYWORD_B_FALSE FALSE

COMMENT ^{COMMENT_INDICATOR}.*

IDENTIFIER {LOWER_CASE_LETTER}({LOWER_CASE_LETTER}|{DIGIT}|_)*

WHILE_KEYWORD WHILE
ENDWHILE_KEYWORD ENDWHILE

IF_KEYWORD IF
ELSE_KEYWORD ELSE
ENDIF_KEYWORD ENDIF

AND_KEYWORD AND
OR_KEYWORD OR
NOT_KEYWORD NOT

EQUAL_KEYWORD =
LESSER_THAN_KEYWORD <
GREATER_THAN_KEYWORD >

TO_KEYWORD TO
BY_KEYWORD BY
FROM_KEYWORD FROM

READ_KEYWORD READ
WRITE_KEYWORD WRITE

MOVE_KEYWORD MOVE

ADD_KEYWORD ADD
SUBTRACT_KEYWORD SUBTRACT
MULTIPLY_KEYWORD MULTIPLY
DIVIDE_KEYWORD DIVIDE
MOD_KEYWORD MOD

%%

{COMMENT} {
	// Skip comment
	std::string current_text = YYText();
	print_debug_message("Comment: " + current_text); 
}

{END_STATEMENT_CHARACTER}$ {
	print_token("END_STATEMENT");
}

{PROGRAM_KEYWORD} {
	print_token("PROGRAM");
}

{DATA_KEYWORD} {
	print_token("DATA");
}

{DATA_SUFIX} {
	print_token("DATA_SUFIX");
}

{DATA_SEPARATOR} {
	print_token("DATA_SEPARATOR");
}

{TYPE_KEYWORD} {
	print_token("TYPE");
}

{TYPE_KEYWORD_I} {
	print_token("TYPE_I");
}

{TYPE_KEYWORD_B} {
	print_token("TYPE_B");
}

{WHILE_KEYWORD} {
	print_token("WHILE");
}

{ENDWHILE_KEYWORD} {
	print_token("ENDWHILE");
}

{IF_KEYWORD} {
	print_token("IF");
}

{ELSE_KEYWORD} {
	print_token("ELSE");
}

{ENDIF_KEYWORD} {
	print_token("ENDIF");
}

{EQUAL_KEYWORD} {
	print_token("EQUAL");
}

{LESSER_THAN_KEYWORD} {
	print_token("LESSER_THAN");
}

{GREATER_THAN_KEYWORD} {
	print_token("GREATER_THAN");
}

{AND_KEYWORD} {
	print_token("AND");
}

{OR_KEYWORD} {
	print_token("OR");
}

{NOT_KEYWORD} {
	print_token("NOT");
}

{TO_KEYWORD} {
	print_token("TO");
}

{BY_KEYWORD} {
	print_token("BY");
}

{FROM_KEYWORD} {
	print_token("FROM");
}

{READ_KEYWORD} {
	print_token("READ");
}

{WRITE_KEYWORD} {
	print_token("WRITE");
}

{MOVE_KEYWORD} {
	print_token("MOVE");
}

{ADD_KEYWORD} {
	print_token("ADD");
}

{SUBTRACT_KEYWORD} {
	print_token("SUBTRACT");
}

{MULTIPLY_KEYWORD} {
	print_token("MULTIPLY");
}

{DIVIDE_KEYWORD} {
	print_token("DIVIDE");
}

{MOD_KEYWORD} {
	print_token("MOD");
}

{TYPE_I_IDENTIFIER} {
	print_token("IDENTIFIER_I");
}

{TYPE_KEYWORD_B_TRUE} {
	print_token("IDENTIFIER_B_TRUE");
}

{TYPE_KEYWORD_B_FALSE} {
	print_token("IDENTIFIER_B_FALSE");
}

{LEFT_BRACKET} {
	print_token("LEFT_BRACKET");
}

{RIGHT_BRACKET} {
	print_token("RIGHT_BRACKET");
}

{IDENTIFIER} {
	print_token("IDENTIFIER");
}

{WHITEPACE}+ {
	// Skip whitespaces
	print_debug_message("Whitespace skipped.");
}

. {
	std::stringstream ss;
	ss << "Lexical error at line: " << lineno();
	print_error_message(ss.str());
	exit(1);
}

%%