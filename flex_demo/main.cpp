#include <iostream>
#include <cstdio>
#include<string>
#include "lexer.h"
using namespace std;

int yylex();
extern "C" FILE *yyin;
extern "C" char *yytext;

extern "C" int tokens_num;

int main(int argc, char **argv)
{
    if (argc > 1){
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }

    cout<<"ROW"<<string(7,' ')<<"COL"<<string(7,' ')<<"TYPE"<<string(21,' ')<<"TOKEN/ERROR MESSAGE"<<endl;
    while (true){
        int n = yylex();
        if (n == T_EOF){
            break;
        }
    }
    cout<<"The number of the tokens: "<<tokens_num<<endl;
    
    return 0;
}
