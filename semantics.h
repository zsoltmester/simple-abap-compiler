#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <iostream>
#include <sstream>
#include <string> 
#include <map>

enum Type 
{
	Integer,
	Boolean,
	String
};

struct VariableData
{
	int declarationRow;
	Type type;
	
	VariableData(int declarationRow, Type type) 
		: declarationRow(declarationRow), type(type)
	{
	}
	
	VariableData()
	{
	}
};

#endif //SEMANTICS_H
