%{
  #include <stdio.h>
  extern int yylex(void);
  extern void yyerror(char const *s);
%}

%union {
  int ival;
  float fval;
  char *sval;
}

%left tPLUS
%right tEQUAL

%token tSTRING tFLOAT tNUMBER tID tCONSTANT tEQUAL tGT tLT tGTE tLTE tNEQUAL
%token tPLUS tMINUS tMULT tDIV tMOD tEMARK tQMARK tAND tOR tLSBRACE tRSBRACE
%token tLPAREN tRPAREN tLBRACE tRBRACE tAT tDOT tCOMMA tCOLON
%token kCLASS kEND kDEF

%start program

%%

program: expressions

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

class_definition: kCLASS tCONSTANT expressions kEND

method_definition: kDEF tID expressions kEND
                 | kDEF tID tLPAREN tID tRPAREN expressions kEND

method_call: variable tDOT tID
           | tCONSTANT tDOT tID tLPAREN tSTRING tRPAREN
           | tID tSTRING

variable: tID
        | tAT tID

value: tNUMBER
