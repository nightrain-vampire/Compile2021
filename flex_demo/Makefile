GCC = @g++
LEX = @flex

lexer: lexer.c main.cpp
			$(GCC) lexer.c main.cpp -o lexer

lexer.c: lexer.lex
			$(LEX) -o lexer.c lexer.lex

pjtest1: 
				./lexer tests/case_1.pcat case1
				./lexer tests/case_2.pcat case2
				./lexer tests/case_3.pcat case3
				./lexer tests/case_4.pcat case4
				./lexer tests/case_5.pcat case5
				./lexer tests/case_6.pcat case6
				./lexer tests/case_7.pcat case7
				./lexer tests/case_8.pcat case8
				./lexer tests/case_9.pcat case9
				./lexer tests/case_10.pcat case10

clean:
				@-rm -f lexer.c lexer
.PHONY: clean