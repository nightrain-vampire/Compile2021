%{
#include "lexer.h"
#include "iostream"
using namespace std;
int tokens_num = 0;
int cols = 1;
int rows = 1;
%}
%option     nounput
%option     noyywrap

DIGIT       [0-9]
INTEGER     {DIGIT}+
REAL        {DIGIT}+"."{DIGIT}*
WS          [ \t]+
NEW_LINE        [\n]
LETTER		    [A-Z]|[a-z]
RESERVE		    (AND)|(ARRAY)|(BEGIN)|(BY)|(DIV)|(DO)|(ELSE)|(ELSIF)|(END)|(EXIT)|(FOR)|(IF)|(IN)|(IS)|(LOOP)|(MOD)|(NOT)|(OF)|(OR)|(OUT)|(PROCEDURE)|(PROGRAM)|(READ)|(RECORD)|(RETURN)|(THEN)|(TO)|(TYPE)|(VAR)|(WHILE)|(WRITE)
STRING          \"[^\"]*\"
OPERATOR	    \:\=|\+|\-|\*|\/|\<|\<\=|\>|\>\=|\=|\<\>
DELIMITER       \:|\;|\,|\.|\(|\)|\[|\]|\{|\}|\[\<|\>\]|\]
ID		        {LETTER}+({LETTER}|{DIGIT})*

%%
{WS}        {cols += yyleng;}
<<EOF>>     return T_EOF;
{NEW_LINE}              {rows++; cols = 1;}
{STRING}                {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"string                  "<<yytext<<endl; cols += yyleng; return STRING;}
{INTEGER}			    {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"integer                 "<<yytext<<endl; cols += yyleng; return INTEGER;}
{OPERATOR}		        {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"operator                "<<yytext<<endl; cols += yyleng; return OPERATOR;}
{REAL} 	                {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"real                    "<<yytext<<endl; cols += yyleng; return REAL;}
{RESERVE}		        {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"reserved keyword        "<<yytext<<endl; cols += yyleng; return RESERVED;}
{DELIMITER}             {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"delimiter               "<<yytext<<endl; cols += yyleng; return DELIMITER;}
{ID}                    {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"identifier              "<<yytext<<endl; cols += yyleng; return IDENTIFIER;}
.                       {tokens_num++; cout<<rows<<"        "<<cols<<"      "<<"unknown                 "<<yytext<<endl; cols += yyleng; return UNKNOWN;}
%%

