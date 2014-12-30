%{
  #include <stdio.h>
  #include "parse.tab.h"
  #define VTYPE(type, value) printf("%s(%s)\n", type, value)
  #define TOKEN(id) return t##id
%}

%option noyywrap
%option yylineno

NUMBER [0-9](_[0-9]|[0-9])*

%%
#.*$ {}
\"([^"]|\\.)*\" { VTYPE("STRING", yytext); TOKEN(STRING); }
\'([^']|\\.)*\' { VTYPE("STRING", yytext); TOKEN(STRING); }
{NUMBER}(\.{NUMBER}|(\.{NUMBER})?[eE][+-]?{NUMBER}) { VTYPE("FLOAT", yytext); TOKEN(FLOAT); }
{NUMBER} { yylval = atoi(yytext); TOKEN(NUMBER); }
[a-z_][a-zA-Z0-9_]* { VTYPE("ID", yytext); TOKEN(ID); }
[A-Z][a-zA-Z0-9_]* { VTYPE("CONSTANT", yytext); TOKEN(CONSTANT); }
"=" { TOKEN(EQUAL); }
">" { TOKEN(GT); }
"<" { TOKEN(LT); }
">=" { TOKEN(GTE); }
"<=" { TOKEN(LTE); }
"!=" { TOKEN(NEQUAL); }
"+" { TOKEN(PLUS); }
"-" { TOKEN(MINUS); }
"*" { TOKEN(MULT); }
"/" { TOKEN(DIV); }
"%" { TOKEN(MOD); }
"!" { TOKEN(EMARK); }
"?" { TOKEN(QMARK); }
"&" { TOKEN(AND); }
"|" { TOKEN(OR); }
"[" { TOKEN(LSBRACE); }
"]" { TOKEN(RSBRACE); }
"(" { TOKEN(LPAREN); }
")" { TOKEN(RPAREN); }
"{" { TOKEN(LBRACE); }
"}" { TOKEN(RBRACE); }
"@" { TOKEN(AT); }
"." { TOKEN(DOT); }
"," { TOKEN(COMMA); }
":" { TOKEN(COLON); }
[\t ] {}
\n {}
. { fprintf(stderr, "Unknown token '%s'\n", yytext); }
%%

void yyerror(char const *s) {
  fprintf(stderr, "%s. Unexpected \"%s\" on line %d\n", s, yytext, yylineno);
}
