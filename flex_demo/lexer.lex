%{
#include "lexer.h"
#include "iostream"
#include "string"

#define inter1 string(10-to_string(rows).size(),' ')
#define inter2 string(10-to_string(cols).size(),' ')

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
COMMENT         [\(][\*][^\*(?=\))]*[\*][\)]


%%
{WS}        {cols += yyleng;}
<<EOF>>     return T_EOF;
{NEW_LINE}              {rows++; cols = 1;}
{COMMENT}               {cols += yyleng; return COMMENT;}
{STRING}                {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"string"<<string(25-6,' ')<<yytext<<endl; cols += yyleng; return STRING;}
{INTEGER}			    {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"integer"<<string(25-7,' ')<<yytext<<endl; cols += yyleng; return INTEGER;}
{OPERATOR}		        {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"operator"<<string(25-8,' ')<<yytext<<endl; cols += yyleng; return OPERATOR;}
{REAL} 	                {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"real"<<string(25-4,' ')<<yytext<<endl; cols += yyleng; return REAL;}
{RESERVE}		        {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"reserved keyword"<<string(25-16,' ')<<yytext<<endl; cols += yyleng; return RESERVED;}
{DELIMITER}             {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"delimiter"<<string(25-9,' ')<<yytext<<endl; cols += yyleng; return DELIMITER;}
{ID}                    {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"identifier"<<string(25-10,' ')<<yytext<<endl; cols += yyleng; return IDENTIFIER;}
.                       {tokens_num++; cout<<rows<<inter1<<cols<<inter2<<"unknown"<<string(25-7,' ')<<yytext<<endl; cols += yyleng; return UNKNOWN;}
%%

