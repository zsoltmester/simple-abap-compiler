#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>
#include <FlexLexer.h>
#include "Parser.h"

#define DEBUG true

void handle_input(std::ifstream& ifs, int argc, char* argv[]);

int main(int argc, char* argv[])
{
    std::ifstream ifs;
    handle_input(ifs, argc, argv);
    Parser parser(ifs);
    parser.parse();
    if (DEBUG) 
    {
        std::cout << "[DEBUG] Compiler finished successfuly." << std::endl;
    }
    return 0;
}

void handle_input(std::ifstream& ifs, int argc, char* argv[])
{
    if(argc < 2)
    {
        std::cerr << "[ERROR] Add the input file name as an argument." << std::endl;
        exit(1);
    }

    ifs.open(argv[1]);
    if(!ifs)
    {
        std::cerr << "[ERROR] Error while opening the file: " << argv[1] << "." << std::endl;
        exit(1);
    }
}
