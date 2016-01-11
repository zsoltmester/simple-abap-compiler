%option noyywrap c++ yylineno

%{
	#include <cstdlib>
	#include <iostream>
	#include <sstream>
	#include "Parserbase.h"

	#define DEBUG true

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
	print_debug_message("Lexer read: END_STATEMENT"); 
	return Parser::END_STATEMENT;
}

{PROGRAM_KEYWORD} {
	print_debug_message("Lexer read: PROGRAM"); 
	return Parser::PROGRAM;
}

{DATA_KEYWORD} {
	print_debug_message("Lexer read: DATA"); 
	return Parser::DATA;
}

{DATA_SUFIX} {
	print_debug_message("Lexer read: DATA_SUFIX"); 
	return Parser::DATA_SUFIX;
}

{DATA_SEPARATOR} {
	print_debug_message("Lexer read: DATA_SEPARATOR"); 
	return Parser::DATA_SEPARATOR;
}

{TYPE_KEYWORD} {
	print_debug_message("Lexer read: TYPE"); 
	return Parser::TYPE;
}

{TYPE_KEYWORD_I} {
	print_debug_message("Lexer read: TYPE_I"); 
	return Parser::TYPE_I;
}

{TYPE_KEYWORD_B} {
	print_debug_message("Lexer read: TYPE_B"); 
	return Parser::TYPE_B;
}

{WHILE_KEYWORD} {
	print_debug_message("Lexer read: WHILE"); 
	return Parser::WHILE;
}

{ENDWHILE_KEYWORD} {
	print_debug_message("Lexer read: ENDWHILE"); 
	return Parser::ENDWHILE;
}

{IF_KEYWORD} {
	print_debug_message("Lexer read: IF"); 
	return Parser::IF;
}

{ELSE_KEYWORD} {
	print_debug_message("Lexer read: ELSE"); 
	return Parser::ELSE;
}

{ENDIF_KEYWORD} {
	print_debug_message("Lexer read: ENDIF"); 
	return Parser::ENDIF;
}

{EQUAL_KEYWORD} {
	print_debug_message("Lexer read: EQUAL"); 
	return Parser::EQUAL;
}

{LESSER_THAN_KEYWORD} {
	print_debug_message("Lexer read: LESSER_THAN"); 
	return Parser::LESSER_THAN;
}

{GREATER_THAN_KEYWORD} {
	print_debug_message("Lexer read: GREATER_THAN"); 
	return Parser::GREATER_THAN;
}

{AND_KEYWORD} {
	print_debug_message("Lexer read: AND"); 
	return Parser::AND;
}

{OR_KEYWORD} {
	print_debug_message("Lexer read: OR"); 
	return Parser::OR;
}

{NOT_KEYWORD} {
	print_debug_message("Lexer read: NOT"); 
	return Parser::NOT;
}

{TO_KEYWORD} {
	print_debug_message("Lexer read: TO"); 
	return Parser::TO;
}

{BY_KEYWORD} {
	print_debug_message("Lexer read: BY"); 
	return Parser::BY;
}

{FROM_KEYWORD} {
	print_debug_message("Lexer read: FROM"); 
	return Parser::FROM;
}

{READ_KEYWORD} {
	print_debug_message("Lexer read: READ"); 
	return Parser::READ;
}

{WRITE_KEYWORD} {
	print_debug_message("Lexer read: WRITE"); 
	return Parser::WRITE;
}

{MOVE_KEYWORD} {
	print_debug_message("Lexer read: MOVE"); 
	return Parser::MOVE;
}

{ADD_KEYWORD} {
	print_debug_message("Lexer read: ADD"); 
	return Parser::ADD;
}

{SUBTRACT_KEYWORD} {
	print_debug_message("Lexer read: SUBTRACT"); 
	return Parser::SUBTRACT;
}

{MULTIPLY_KEYWORD} {
	print_debug_message("Lexer read: MULTIPLY"); 
	return Parser::MULTIPLY;
}

{DIVIDE_KEYWORD} {
	print_debug_message("Lexer read: DIVIDE"); 
	return Parser::DIVIDE;
}

{MOD_KEYWORD} {
	print_debug_message("Lexer read: MOD"); 
	return Parser::MOD;
}

{TYPE_I_IDENTIFIER} {
	std::string current_text = YYText();
	print_debug_message("Lexer read: IDENTIFIER_I: " + current_text); 
	return Parser::IDENTIFIER_I;
}

{TYPE_KEYWORD_B_TRUE} {
	print_debug_message("Lexer read: IDENTIFIER_B_TRUE"); 
	return Parser::IDENTIFIER_B_TRUE;
}

{TYPE_KEYWORD_B_FALSE} {
	print_debug_message("Lexer read: IDENTIFIER_B_FALSE"); 
	return Parser::IDENTIFIER_B_FALSE;
}

{LEFT_BRACKET} {
	print_debug_message("Lexer read: LEFT_BRACKET"); 
	return Parser::LEFT_BRACKET;
}

{RIGHT_BRACKET} {
	print_debug_message("Lexer read: RIGHT_BRACKET"); 
	return Parser::RIGHT_BRACKET;
}

{IDENTIFIER} {
	std::string current_text = YYText();
	print_debug_message("Lexer read: IDENTIFIER: " + current_text); 
	return Parser::IDENTIFIER;
}

{WHITEPACE}+ {
	// Skip whitespaces
	//print_debug_message("Whitespace skipped.");
}

. {
	std::stringstream ss;
	ss << "Lexical error at line: " << lineno();
	print_error_message(ss.str());
	exit(1);
}

%%
