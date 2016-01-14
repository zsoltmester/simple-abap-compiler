%baseclass-preinclude "semantics.h"
%lsp-needed

%union
{
	std::string *value;
	Type *type;
}

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
LEFT_BRACKET
RIGHT_BRACKET
%token <value> IDENTIFIER_I
%token <value> IDENTIFIER_B_TRUE
%token <value> IDENTIFIER_B_FALSE
%token <value> IDENTIFIER

%type <type> expression;

%left OR
%left AND
%left EQUAL
%left LESSER_THAN
%left GREATER_THAN

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
        std::cout << "Declared: " << *$1 << std::endl;
        
		if (symbolTable.count(*$1) > 0)
		{
			std::stringstream ss;
			ss << "Duplicated variable: \"" << *$1 << "\", "
				<< "Previous declaration: " << symbolTable[*$1].declarationRow;
			error(ss.str().c_str());
		}
		
		symbolTable[*$1] = VariableData(d_loc__.first_line, Integer);
		
		delete $1;
	}
|
	IDENTIFIER TYPE TYPE_B 
	{
        std::cout << "data -> IDENTIFIER TYPE TYPE_B" << std::endl;
        std::cout << "Declared: " << *$1 << std::endl;
        
		if (symbolTable.count(*$1) > 0)
		{
			std::stringstream ss;
			ss << "Duplicated variable: \"" << *$1 << "\", "
				<< "Previous declaration: " << symbolTable[*$1].declarationRow;
			error(ss.str().c_str());
		}
		
		symbolTable[*$1] = VariableData(d_loc__.first_line, Boolean);
		
		delete $1;
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
        
		if(symbolTable.count(*$1) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$1;
			error(ss.str().c_str());
		}
		
		$$ = new Type(symbolTable[*$1].type);

		delete $1;
	}
|
	IDENTIFIER_I
	{
        std::cout << "expression -> IDENTIFIER_I" << std::endl;
        
		$$ = new Type(Integer);
	}
|
	IDENTIFIER_B_TRUE
	{
        std::cout << "expression -> IDENTIFIER_B_TRUE" << std::endl;
        
		$$ = new Type(Boolean);
	}
|
	IDENTIFIER_B_FALSE
	{
        std::cout << "expression -> IDENTIFIER_B_FALSE" << std::endl;
        
		$$ = new Type(Boolean);
	}
|
	expression AND expression
	{
        std::cout << "expression -> expression AND expression" << std::endl;
        
        if (*$1 != Boolean || *$3 != Boolean)
        {
        	std::cout << *$1 << " - " << *$3 << std::endl;
        	error("Invalid types at AND.");
        }
        
		delete $1;
		delete $3;
		
		$$ = new Type(Boolean);
	}
|
	expression OR expression
	{
        std::cout << "expression -> expression OR expression" << std::endl;
        
        if (*$1 != Boolean || *$3 != Boolean)
        {
        	error("Invalid types at OR.");
        }
        
		delete $1;
		delete $3;
		
		$$ = new Type(Boolean);
	}
|
	NOT expression
	{
        std::cout << "expression -> NOT expression" << std::endl;
        
        if (*$2 != Boolean)
        {
        	error("Invalid type at NOT.");
        }
        
		delete $2;
		
		$$ = new Type(Boolean);
	}
|
	LEFT_BRACKET expression RIGHT_BRACKET
	{
        std::cout << "expression -> LEFT_BRACKET expression RIGHT_BRACKET" << std::endl;
        
		$$ = $2;
		
		delete $2;
	}
|
	expression EQUAL expression
	{
        std::cout << "expression -> expression EQUAL expression" << std::endl;
        
        if (*$1 != Integer || *$3 != Integer)
        {
        	error("Invalid types at EQUAL.");
        }
        
		delete $1;
		delete $3;
		
		$$ = new Type(Boolean);
	}
|
	expression LESSER_THAN expression
	{
        std::cout << "expression -> expression LESSER_THAN expression" << std::endl;
        
        if (*$1 != Integer || *$3 != Integer)
        {
        	error("Invalid types at LESSER_THAN.");
        }
        
		delete $1;
		delete $3;
		
		$$ = new Type(Boolean);
	}
|
	expression GREATER_THAN expression
	{
        std::cout << "expression -> expression GREATER_THAN expression" << std::endl;
        
        if (*$1 != Integer || *$3 != Integer)
        {
        	error("Invalid types at GREATER_THAN.");
        }
        
		delete $1;
		delete $3;
		
		$$ = new Type(Boolean);
	}
;

move:
	MOVE expression TO IDENTIFIER
	{
        std::cout << "move -> MOVE expression TO IDENTIFIER" << std::endl;
        
		if(symbolTable.count(*$4) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$4;
			error(ss.str().c_str());
		}
		
		if (*$2 != symbolTable[*$4].type)
        {
        	error("Invalid types at MOVE.");
        }

		delete $2;
		delete $4;
	}
;

read:
	READ TO IDENTIFIER
	{
        std::cout << "read -> READ TO IDENTIFIER" << std::endl;
        
		if(symbolTable.count(*$3) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$3;
			error(ss.str().c_str());
		}

		delete $3;
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
        
		if(symbolTable.count(*$4) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$4;
			error(ss.str().c_str());
		}
        
        if (*$2 != Integer || symbolTable[*$4].type != Integer)
        {
        	error("Invalid types at ADD.");
        }

		delete $2;
		delete $4;
	}
;

substract:
	SUBTRACT expression FROM IDENTIFIER
	{
        std::cout << "substract -> SUBTRACT expression FROM IDENTIFIER" << std::endl;
        
		if(symbolTable.count(*$4) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$4;
			error(ss.str().c_str());
		}
        
        if (*$2 != Integer || symbolTable[*$4].type != Integer)
        {
        	error("Invalid types at SUBTRACT.");
        }

		delete $2;
		delete $4;
	}
;

multiply:
	MULTIPLY IDENTIFIER BY expression
	{
        std::cout << "multiply -> MULTIPLY IDENTIFIER BY expression" << std::endl;
        
		if(symbolTable.count(*$2) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$2;
			error(ss.str().c_str());
		}
        
        if (*$4 != Integer || symbolTable[*$2].type != Integer)
        {
        	error("Invalid types at MULTIPLY.");
        }

		delete $2;
		delete $4;
	}
;

divide:
	DIVIDE IDENTIFIER BY expression
	{
        std::cout << "divide -> DIVIDE IDENTIFIER BY expression" << std::endl;
        
		if(symbolTable.count(*$2) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$2;
			error(ss.str().c_str());
		}
        
        if (*$4 != Integer || symbolTable[*$2].type != Integer)
        {
        	error("Invalid types at DIVIDE.");
        }

		delete $4;
		delete $2;
	}
;

mod:
	MOD IDENTIFIER BY expression TO IDENTIFIER
	{
        std::cout << "mod -> MOD IDENTIFIER BY expression TO IDENTIFIER" << std::endl;
        
		if(symbolTable.count(*$2) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$2;
			error(ss.str().c_str());
		}
        
		if(symbolTable.count(*$6) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$6;
			error(ss.str().c_str());
		}
        
        if (*$4 != Integer || symbolTable[*$2].type != Integer || symbolTable[*$6].type != Integer)
        {
        	error("Invalid types at MOD.");
        }

		delete $2;
		delete $4;
		delete $6;
	}
;

while:
	WHILE expression END_STATEMENT one_or_more_statements ENDWHILE
	{
        std::cout << "while -> WHILE expression END_STATEMENT one_or_more_statements ENDWHILE" << std::endl;
        
        if (*$2 != Boolean)
        {
        	error("Invalid type at WHILE.");
        }

		delete $2;
	}
;

if:
	IF expression END_STATEMENT one_or_more_statements zero_or_one_else
	{
        std::cout << "if -> IF expression END_STATEMENT one_or_more_statements zero_or_one_else" << std::endl;
        
        if (*$2 != Boolean)
        {
        	error("Invalid type at IF.");
        }

		delete $2;
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
