#include <iostream>
#include <cstdio>
#include "test.h"
using namespace std;

int yylex();
extern "C" FILE *yyin;
extern "C" char *yytext;

int main(int argc, char **argv)
{
	if (argc > 1){
		yyin = fopen(argv[1], "r");
	} else {
		yyin = stdin;
	}

	cout<<"tokens"<<"	type	"<<"	rows"<<"	cols"<<endl;
	while (true) {
		int n = yylex();
		if(n == T_EOF){
			break;
		}
	}

	return 0;
}
