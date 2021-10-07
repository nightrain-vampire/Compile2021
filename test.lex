%{
#include "test.h"
%}

DIGIT		[0-9]
INTEGER		{DEGIT}+
REAL       	{DIGIT}+"."{DIGIT}*
WS          	[ \t]+
LETTER		[A-z]
RESERVE		
STRING          {LETTER}+[{LETTER}|{DIGIT}]*


%%
""
%%
