%{
  #include <stdio.h>
  extern int yylex(void);
  void yyerror(char const *s) { fprintf(stderr, "%s\n", s); }
%}

%left tPLUS

%token tNUMBER
%token tPLUS
%start program

%%

program: expressions

expressions: expressions expression
           | expression

expression: tNUMBER
          | expression tPLUS expression { printf("%d\n", $1 + $3); }
