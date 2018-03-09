%{
	#include "calc.tab.h"
%}

DIGITO [0-9]

%%


{DIGITO}+("."{DIGITO}+)?    { yylval.real = atof(yytext); return (NUM); }
[a-zA-Z]			        { yylval.txt = yytext[0]; return VARIABLE; }
[ \t]				        ;
"\n"				        { return FINL; }
[-+*/^|&#=()]			    { return yytext[0]; }
"sen"				        { return SEN; }
"cos"				        { return COS; }
"tan"                       { return TAN; }
"abs"                       { return ABS; }
"exp"                       { return EXP; }
"sqrt"                      { return SQR; }
"acos"                      { return ARCOS; }
"asen"                      { return ARCOSEN; }
"atan"                      { return ARCOTAN; }
"valcer"                    { return VALCER; }
"Acabe"				        { return SALIR; }

.				            { ECHO; yyerror ("Caracter desconocido.");}

%%
int yywrap (void) {
	return 1;
}
/*124 , ^94*/