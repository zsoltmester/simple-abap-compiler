%baseclass-preinclude <iostream>
%lsp-needed

%token 
END_STATEMENT
PROGRAM
DATA
DATA_SUFIX
DATA_SEPARATOR
TYPE
TYPE_I
TYPE_B
WHILE
ENDWHILE
IF
ELSE
ENDIF
NOT
TO
BY
FROM
READ
WRITE
MOVE
ADD
SUBTRACT
MULTIPLY
DIVIDE
MOD
IDENTIFIER_I
IDENTIFIER_B_TRUE
IDENTIFIER_B_FALSE
LEFT_BRACKET
RIGHT_BRACKET
IDENTIFIER

%left
AND
OR
EQUAL
LESSER_THAN
GREATER_THAN

%%

// This is the start of the program, which can separate into 3 section:
// - program definition (program)
// - variable declarations (data)
// - the main program (main)
start:
	program data main
	{
        std::cout << "start -> program data main" << std::endl;
    }
;

//
// The program definition section.
//
program:
	PROGRAM IDENTIFIER END_STATEMENT
	{
        std::cout << "program -> PROGRAM IDENTIFIER END_STATEMENT" << std::endl;
    }
;

//
// The variable declaration section. It can be skipped.
//
data:
	// skip
    {
        std::cout << "data -> skip" << std::endl;
    }
|
	DATA DATA_SUFIX one_or_more_declarations
	{
        std::cout << "data -> DATA DATA_SUFIX one_or_more_declarations" << std::endl;
	}
;

one_or_more_declarations:
	declaration END_STATEMENT
	{
        std::cout << "data -> declaration END_STATEMENT" << std::endl;
	}
|
	declaration DATA_SEPARATOR one_or_more_declarations
	{
        std::cout << "data -> declaration DATA_SEPARATOR one_or_more_declarations" << std::endl;
	}
;

declaration:
	IDENTIFIER TYPE TYPE_I
	{
        std::cout << "data -> IDENTIFIER TYPE TYPE_I" << std::endl;
	}
|
	IDENTIFIER TYPE TYPE_B 
	{
        std::cout << "data -> IDENTIFIER TYPE TYPE_B" << std::endl;
	}
;

//
// The section of the main program. it can be skipped.
//
main:
	// skip
    {
        std::cout << "main -> skip" << std::endl;
    }
|
	one_or_more_statements
	{
        std::cout << "main -> one_or_more_statements" << std::endl;
	}
;

one_or_more_statements:
	statement END_STATEMENT
	{
        std::cout << "main -> statement END_STATEMENT" << std::endl;
	}
|
	statement END_STATEMENT one_or_more_statements
	{
        std::cout << "main -> statement END_STATEMENT one_or_more_statements" << std::endl;
	}
;

statement:
	move
	{
        std::cout << "statement -> move" << std::endl;
	}
|
	read
	{
        std::cout << "statement -> read" << std::endl;
	}
|
	write
	{
        std::cout << "statement -> write" << std::endl;
	}
|
	add
	{
        std::cout << "statement -> add" << std::endl;
	}
|
	substract
	{
        std::cout << "statement -> substract" << std::endl;
	}
|
	multiply
	{
        std::cout << "statement -> multiply" << std::endl;
	}
|
	divide
	{
        std::cout << "statement -> divide" << std::endl;
	}
|
	mod
	{
        std::cout << "statement -> mod" << std::endl;
	}
|
	while
	{
        std::cout << "statement -> while" << std::endl;
	}
|
	if
	{
        std::cout << "statement -> if" << std::endl;
	}
;

expression:
	IDENTIFIER
	{
        std::cout << "expression -> IDENTIFIER" << std::endl;
	}
|
	IDENTIFIER_I
	{
        std::cout << "expression -> IDENTIFIER_I" << std::endl;
	}
|
	IDENTIFIER_B_TRUE
	{
        std::cout << "expression -> IDENTIFIER_B_TRUE" << std::endl;
	}
|
	IDENTIFIER_B_FALSE
	{
        std::cout << "expression -> IDENTIFIER_B_FALSE" << std::endl;
	}
|
	expression AND expression
	{
        std::cout << "expression -> expression AND expression" << std::endl;
	}
|
	expression OR expression
	{
        std::cout << "expression -> expression OR expression" << std::endl;
	}
|
	NOT expression
	{
        std::cout << "expression -> NOT expression" << std::endl;
	}
|
	LEFT_BRACKET expression RIGHT_BRACKET
	{
        std::cout << "expression -> LEFT_BRACKET expression RIGHT_BRACKET" << std::endl;
	}
|
	expression EQUAL expression
	{
        std::cout << "expression -> expression EQUAL expression" << std::endl;
	}
|
	expression LESSER_THAN expression
	{
        std::cout << "expression -> expression LESSER_THAN expression" << std::endl;
	}
|
	expression GREATER_THAN expression
	{
        std::cout << "expression -> expression GREATER_THAN expression" << std::endl;
	}
;

move:
	MOVE expression TO IDENTIFIER
	{
        std::cout << "move -> MOVE expression TO IDENTIFIER" << std::endl;
	}
;

read:
	READ TO IDENTIFIER
	{
        std::cout << "read -> READ TO IDENTIFIER" << std::endl;
	}
;

write:
	WRITE expression
	{
        std::cout << "write -> WRITE expression" << std::endl;
	}
;

add:
	ADD expression TO IDENTIFIER
	{
        std::cout << "add -> ADD expression TO IDENTIFIER" << std::endl;
	}
;

substract:
	SUBTRACT expression FROM IDENTIFIER
	{
        std::cout << "substract -> SUBTRACT expression FROM IDENTIFIER" << std::endl;
	}
;

multiply:
	MULTIPLY IDENTIFIER BY expression
	{
        std::cout << "multiply -> MULTIPLY IDENTIFIER BY expression" << std::endl;
	}
;

divide:
	DIVIDE IDENTIFIER BY expression
	{
        std::cout << "divide -> DIVIDE IDENTIFIER BY expression" << std::endl;
	}
;

mod:
	MOD IDENTIFIER BY expression TO IDENTIFIER
	{
        std::cout << "mod -> MOD IDENTIFIER BY expression TO IDENTIFIER" << std::endl;
	}
;

while:
	WHILE expression END_STATEMENT one_or_more_statements ENDWHILE
	{
        std::cout << "while -> WHILE expression END_STATEMENT one_or_more_statements ENDWHILE" << std::endl;
	}
;

if:
	IF expression END_STATEMENT one_or_more_statements zero_or_one_else
	{
        std::cout << "if -> IF expression END_STATEMENT one_or_more_statements zero_or_one_else" << std::endl;
	}
;

zero_or_one_else:
	ENDIF
	{
        std::cout << "zero_or_one_else -> ENDIF" << std::endl;
	}
|
	ELSE END_STATEMENT one_or_more_statements ENDIF
	{
        std::cout << "zero_or_one_else -> ELSE END_STATEMENT one_or_more_statements ENDIF" << std::endl;
	}
;