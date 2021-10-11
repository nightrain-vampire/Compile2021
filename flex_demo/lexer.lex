%{
#include "lexer.h"
#include "iostream"
#include "string"

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
STRING          \"[^\"^\n]*\"
OPERATOR	    \:\=|\+|\-|\*|\/|\<|\<\=|\>|\>\=|\=|\<\>
DELIMITER       \:|\;|\,|\.|\(|\)|\[|\]|\{|\}|\[\<|\>\]|\]
ID		        {LETTER}+({LETTER}|{DIGIT})*
UN_STRING       \"[^\"^\n]*\n

%x COMMENT

%%
{WS}                    {cols += yyleng;}
<INITIAL><<EOF>>        return T_EOF;
{NEW_LINE}              {rows++; cols = 1;}
{UN_STRING}             {cols = 1; return UTSTRING;}
{STRING}                {tokens_num++;  return STRING;}
{INTEGER}			    {tokens_num++;  return INTEGER;}
{OPERATOR}		        {tokens_num++;  return OPERATOR;}
{REAL} 	                {tokens_num++;  return REAL;}
{RESERVE}		        {tokens_num++;  return RESERVED;}
{DELIMITER}             {tokens_num++;  return DELIMITER;}
{ID}                    {tokens_num++;  return IDENTIFIER;}
.                       {tokens_num++;  return BADCHAR;}


"(*"                   {cols += 2; BEGIN COMMENT; }
<COMMENT>.             {cols += yyleng;}
<COMMENT>\n            {cols = 1; rows++; } 
<COMMENT>"*)"          {cols += 2; BEGIN INITIAL; }
<COMMENT><<EOF>>       return C_EOF;
%%

