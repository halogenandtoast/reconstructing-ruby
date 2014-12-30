%{
  #include <stdio.h>
  extern int yylex(void);
  extern void yyerror(char const *s);
%}

%left tPLUS

%token tSTRING tFLOAT tNUMBER tID tCONSTANT tEQUAL tGT tLT tGTE tLTE tNEQUAL
%token tPLUS tMINUS tMULT tDIV tMOD tEMARK tQMARK tAND tOR tLSBRACE tRSBRACE
%token tLPAREN tRPAREN tLBRACE tRBRACE tAT tDOT tCOMMA tCOLON

%start program

%%

program: expressions

expressions: expressions expression
           | expression

expression: tNUMBER
          | expression tPLUS expression { printf("%d\n", $1 + $3); }
