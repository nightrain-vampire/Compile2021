%{
#include "test.h"
#include "iostream"
using namespace std;
int tokens_num = 0;
int cols = 0;
int rows = 0;
%}
%option		nounput
%option		noyywrap

DIGIT		    [0-9]
INTERGER	    {DIGIT}+
REAL       	    {DIGIT}+"."{DIGIT}*
WS          	[ \t]+
NEW_LINE        [\n]
LETTER		    [A-z]
RESERVE		    (AND)|(ARRAY)|(BEGIN)|(BY)|(DIV)|(DO)|(ELSE)|(ELSIF)|(END)|(EXIT)|(FOR)|(IF)|(IN)|(IS)|(LOOP)|(MOD)|(NOT)|(OF)|(OR)|(OUT)|(PROCEDURE)|(PROGRAM)|(READ)|(RECORD)|(RETURN)|(THEN)|(TO)|(TYPE)|(VAR)|(WHILE)|(WRITE)
STRING          \"[^\"]*\"
OPERATOR	    \:\=|\+|\-|\*|\/|\<|\<\=|\>|\>\=|\=|\<\>
DELIMITER       \:|\;|\,|\.|\(|\)|\[|\]|\{|\}|\[\<|\>\]|\]
ID		        {LETTER}+({LETTER}|{DIGIT})*
BUILT_IN_TYPE	(INTEGER)|(REAL)|(BOOLEAN)



%%
{STRING}                {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"string         "<<rows<<"  "<<cols<<endl; return STRING;}
{WS}
{NEW_LINE}              {rows++; cols = 0;}		
<<EOF>>			        return T_EOF;
{DIGIT}			        {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"digit          "<<rows<<"      "<<cols<<endl; return DIGIT;}
{OPERATOR}		        {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"operator       "<<rows<<"      "<<cols<<endl; return OPERATOR;}
{INTERGER}|{REAL} 	    {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"number         "<<rows<<"      "<<cols<<endl; return NUMBER;}
{RESERVE}		        {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"reserve        "<<rows<<"      "<<cols<<endl; return RESERVE;}
{BUILT_IN_TYPE}		    {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"built_in_type  "<<rows<<"      "<<cols<<endl; return BUILT_IN_TYPE;} 
{DELIMITER}             {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"delimiter      "<<rows<<"      "<<cols<<endl; return DELIMITER;}
{ID}                    {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"ID             "<<rows<<"      "<<cols<<endl; return ID;}
.                       {tokens_num++; cols += yyleng; cout<<yytext<<":  "<<"unknown        "<<rows<<"      "<<cols<<endl; return UNKNOWN;}
%%
