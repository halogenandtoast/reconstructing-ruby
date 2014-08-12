#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylex(void);

int main(int argc, char *argv[]) {
  if(argc > 1) {
    yyin = fopen(argv[1], "r");
  }

  yylex();
  return EXIT_SUCCESS;
}
