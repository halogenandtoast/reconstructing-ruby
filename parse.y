%{
  #include <stdio.h>
  #include "node.h"
  extern void yyerror(struct parser_state *state, const char *s);
%}

%pure-parser
%parse-param { parser_state *state }
%lex-param { state }

%union {
  int ival;
  float fval;
  char *sval;
}

%{
  extern int yylex(YYSTYPE *yylval, parser_state *state);
%}


%left tPLUS
%right tEQUAL

%token tFLOAT tNUMBER tEQUAL tGT tLT tGTE tLTE tNEQUAL
%token tPLUS tMINUS tMULT tDIV tMOD tEMARK tQMARK tAND tOR tLSBRACE tRSBRACE
%token tLPAREN tRPAREN tLBRACE tRBRACE tAT tDOT tCOMMA tCOLON
%token kCLASS kEND kDEF
%token <sval> tSTRING tCONSTANT tID

%start program

%%

program: expressions { printf("%s\n", state->source_file); }

expressions: expressions expression
           | expression

expression: class_definition
          | binary_expression
          | method_definition
          | variable
          | assignment
          | method_call
          | value

binary_expression: expression tPLUS expression

assignment: variable tEQUAL expression

class_definition: kCLASS tCONSTANT expressions kEND { free($2); }

method_definition: kDEF tID expressions kEND { free($2); }
                 | kDEF tID tLPAREN tID tRPAREN expressions kEND { free($2); free($4); }

method_call: variable tDOT tID { free($3); }
           | tCONSTANT tDOT tID tLPAREN tSTRING tRPAREN { free($1); free($3); free($5); }
           | tID tSTRING { free($1); free($2); }

variable: tID { free($1); }
        | tAT tID { free($2); }

value: tNUMBER
