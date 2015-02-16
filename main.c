#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "node.h"
#include "parse.tab.h"

extern FILE* yyin;
extern int yyparse(parser_state*);
extern int yylex_destroy(void);

int main(int argc, char *argv[]) {
  parser_state state = { NULL, 0 };

  if(argc > 1) {
    state.source_file = argv[1];
    yyin = fopen(argv[1], "r");
  }

  yyparse(&state);

  if(argc > 1) {
    fclose(yyin);
  }

  yylex_destroy();
  return EXIT_SUCCESS;
}
