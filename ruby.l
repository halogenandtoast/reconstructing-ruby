%{
  #include <stdio.h>
%}

%option noyywrap

%%
[0-9]+ { printf("NUMBER: %s\n", yytext); }
\n {}
. { fprintf(stderr, "Unknown token %s\n", yytext); }
