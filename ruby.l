%{
  #include <stdlib.h>
  #include <stdio.h>
%}

%option noyywrap

%%
[0-9]+ { printf("NUMBER: %s\n", yytext); }
. {}
%%

int main(int argc, char *argv[]) {
  yylex();
  return EXIT_SUCCESS;
}
