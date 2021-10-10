#include <iostream>
#include <cstdio>
#include <string>
#include <fstream>
#include "lexer.h"
#include "stdlib.h"
using namespace std;

#define inter1 string(10-to_string(rows).size(),' ')
#define inter2 string(10-to_string(cols).size(),' ')
#define MAXSTRING_LEN 257
#define MAXIDENTI_LEN 255

int yylex();
extern "C" FILE *yyin;
extern "C" char *yytext;

extern "C" int tokens_num;
extern "C" int cols;
extern "C" int rows;
extern "C" int yyleng;

string filename;
string comment;

int main(int argc, char **argv)
{
    if (argc > 1){
        yyin = fopen(argv[1], "r");
        if(argc > 2){
            filename = argv[2];
        }else {
            cout<<"Please designate the name of the outfile!";
            return 1;
        }
    } else {
        yyin = stdin;
    }

    ofstream outfile;
    outfile.open("ans/"+filename+".txt", ios::out | ios::trunc);

    outfile<<"ROW"<<string(7,' ')<<"COL"<<string(7,' ')<<"TYPE"<<string(21,' ')<<"TOKEN/ERROR MESSAGE"<<endl;
    while (true){
        int n = yylex();
        if (n == T_EOF){
            break;
        }else {
            switch (n){
            case STRING:
                //an overly long string
                if (yyleng > MAXSTRING_LEN) {
                    outfile<<rows<<inter1<<cols<<inter2<<"string"<<string(25-6,' ')<<"an overly long string"<<endl;
                }
                //an invalid string with tab(s) in it
                else if(string(yytext).find('\t') != string::npos) {
                    outfile<<rows<<inter1<<cols<<inter2<<"string"<<string(25-6,' ')<<"an invalid string with tab(s) in it"<<endl;
                }
                //an ok string
                else {
                    outfile<<rows<<inter1<<cols<<inter2<<"string"<<string(25-6,' ')<<yytext<<endl;
                }
                cols += yyleng;
                break;
            case INTEGER:
                //an out of range integer
                if (yyleng > 10 || atoll(yytext) > 2147483647) {
                    outfile<<rows<<inter1<<cols<<inter2<<"integer"<<string(25-7,' ')<<"an out of range integer"<<endl; 
                }
                //valid case
                else {
                    outfile<<rows<<inter1<<cols<<inter2<<"integer"<<string(25-7,' ')<<yytext<<endl; 
                }
                cols += yyleng;
                break;
            case OPERATOR:
                outfile<<rows<<inter1<<cols<<inter2<<"operator"<<string(25-8,' ')<<yytext<<endl; cols += yyleng;
                break;
            case REAL:
                outfile<<rows<<inter1<<cols<<inter2<<"real"<<string(25-4,' ')<<yytext<<endl; cols += yyleng;
                break;
            case RESERVED:
                outfile<<rows<<inter1<<cols<<inter2<<"reserved keyword"<<string(25-16,' ')<<yytext<<endl; cols += yyleng;
                break;
            case DELIMITER:
                outfile<<rows<<inter1<<cols<<inter2<<"delimiter"<<string(25-9,' ')<<yytext<<endl; cols += yyleng;
                break;
            case IDENTIFIER:
                //an overly long identifier
                if (yyleng > MAXIDENTI_LEN) {
                    outfile<<rows<<inter1<<cols<<inter2<<"identifier"<<string(25-10,' ')<<"an overly long identifier"<<endl;
                }
                //an ok identifier
                else {
                    outfile<<rows<<inter1<<cols<<inter2<<"identifier"<<string(25-10,' ')<<yytext<<endl;
                }
                cols += yyleng;
                break;
            case BEGCOMMENT:
                outfile<<rows<<inter1<<cols<<inter2<<"comment"<<string(25-7,' ');   cols += yyleng;
                comment = "(*";
                break;
            case COMMENT:
                outfile<<rows<<inter1<<cols<<inter2<<"comment"<<string(25-7,' ')<<yytext<<endl; cols += yyleng;
                break;
            case UNKNOWN:
                outfile<<rows<<inter1<<cols<<inter2<<"unknown"<<string(25-7,' ')<<yytext<<endl; cols += yyleng;
                break;
            default:
                break;
            }
        }
    }

    outfile<<endl;
    outfile<<"The number of the tokens: "<<tokens_num<<endl;
    outfile.close();

    return 0;
}
