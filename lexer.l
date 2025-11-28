%{
#include <stdio.h>
#include <stdlib.h>

#define T_IDENT   1   //ідентифікатор 
#define T_BOOL    2   // 0 або 1 
#define T_LPAREN  3   // ( 
#define T_RPAREN  4   // ) 
#define T_AND     5   // and 
#define T_OR      6   // or 
#define T_NOT     7   // not 

extern FILE *yyin;
%}

%option noyywrap

%%
and { printf("%d %s\n", T_AND, yytext); }
or  { printf("%d %s\n", T_OR,  yytext); }
not { printf("%d %s\n", T_NOT, yytext); }

[A-Za-z][A-Za-z0-9]* {
    printf("%d %s\n", T_IDENT, yytext);
}

[01] {
    printf("%d %s\n", T_BOOL, yytext);
}

"(" { printf("%d %s\n", T_LPAREN, yytext); }
")" { printf("%d %s\n", T_RPAREN, yytext); }

[ \t\r\n]+   { }

. {
    fprintf(stderr, "Unknown symbol: %s\n", yytext);
}

%%

int main(int argc, char *argv[])
{
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Cannot open input");
            return 1;
        }
    }

    yylex();

    if (argc > 1) fclose(yyin);
    return 0;
}
