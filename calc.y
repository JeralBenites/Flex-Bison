%{  

    /*------------------
    Declaraciones en C
    --------------------*/  
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include <windows.h>//HANDLE set Color El evento manejador
    #define RA 180/3.14159
    /*RA radio angular  para sacra el cos -sen--tan Un radián es equivalente a 180 / PI grados
    exponecial  es e^x =  2.71etc^x*/ 


    int backcolor=0;
    int color[8] = {0x009, 0x00D, 0x00C, 0x002, 0x00B, 0x005, 0x00F,0x004};
    
	double variable[60];

    void setCColor(int color);

	void actualizaVariable(char var, double valor);
	double retornaValor(char var);
	int posicionArray(char var);
    	
	double Sx(double x);
	double Cx(double x);
    double Tx(double x);
 
    double Ax(double x);
    double Ex(double x);
    double Rx(double x);

    double ACx(double x);
    double ASx(double x);
    double ATx(double x);

    double VCx(double x);
  

	void yyerror(char *s);
	extern char *yytext;
	extern int yylineno;
%}

/*------------------------------------
Declaraciones en Bison - tipos 
de variable terminales y no terminale
--------------------------------------*/

%union {float real; char txt;}

/*----------
terminales
------------*/        		
%start linea
%token SALIR
%token FINL
%token <real> NUM SEN COS TAN ABS EXP SQR ARCOS ARCOSEN ARCOTAN ARCTAND VALCER VALMAX
%token <txt> VARIABLE

/*-------------
No terminales
---------------*/
%type <real> linea exp factor term
%type <txt> asignar

%%

/*-------------------
Reglas Gramaticales
---------------------*/
linea   : asignar FINL			{ printf("\n==> "); }
		| SALIR FINL			{ exit(EXIT_SUCCESS); }
		| exp FINL			    { setCColor(color[5]); printf("  = %.2f\n\n", $1); setCColor(color[6]);  printf("==> ");}
		
		| linea asignar FINL	{ printf("\n==> "); }
		| linea exp FINL		{ setCColor(color[5]); printf("  = %.2f\n\n", $2); setCColor(color[6]);  printf("==> ");}
		| linea SALIR FINL		{ exit(EXIT_SUCCESS); }
 	        ;

asignar : VARIABLE '=' exp  	{ actualizaVariable($1,$3); }
         /*Achorandome con el Error*/
        | error	exp             { printf("\n"); }
        ;

exp    	: factor                { $$ = $1; }
        | exp '+' factor        { $$ = $1 + $3; }
        | exp '-' factor        { $$ = $1 - $3; }
        ;

factor  : term                    { $$ = $1; }
       	| factor '*' term         { $$ = $1 * $3; }
        | factor '/' term         { $$ = $1 / $3; }
        | factor '^' term         { $$ = pow($1,$3); }
        | factor '|' term         { $$ = fmax($1,$3); }
        | factor '&' term         { $$ = fmin($1,$3); }
        | factor '#' term         { $$ = atan2($1,$3)*RA; }
        ;

term   	: NUM                	{$$ = $1; }
		| SEN '(' exp ')' 	    { $$ = Sx($3); }
		| COS '(' exp ')' 	    { $$ = Cx($3); }
        | TAN '(' exp ')' 	    { $$ = Tx($3); }
        | ABS '(' exp ')' 	    { $$ = Ax($3); }
        | EXP '(' exp ')' 	    { $$ = Ex($3); }
        | SQR '(' exp ')' 	    { $$ = Rx($3); }
        | ARCOS '(' exp ')' 	{ $$ = ACx($3);}
        | ARCOSEN '(' exp ')' 	{ $$ = ASx($3);}
        | ARCOTAN '(' exp ')' 	{ $$ = ATx($3);}
        | VALCER'(' exp ')' 	{ $$ = VCx($3);}
        
        | '-' NUM		        { $$ = -$2; }
		| '(' exp ')'		    { $$ = $2; }
		| VARIABLE		        { $$ = retornaValor($1); }
 	        ;
%%  

/*-----
---C---
-------*/

int main (void) {
	
        setCColor(color[4]);
	    printf("\n\n\n\t\t..::::::Curso : Tradvctoresss  I  2015-I  VTP::::::..\n\t\t\t\t");
		setCColor(color[2]);
	    printf("\n\n\t               Bienvenido a la Calcvladora!!!!!!          ");
		setCColor(color[4]);
	    printf("\n\n\t\t .Profesor  =>Carlos De Souza Ferreyra\n\t\t .Alumno    =>Jerameel Benites Gonzales\n ");
	    setCColor(color[6]);
	    printf("\n\n\t\t\t    Arriba Alianza !!!!!!!");
        printf("\n\n\t\t .Mangomarca, San Juan De Lvrigancho, Lima-PerV  ");
        setCColor(color[8]);
	    printf("\n\n================================================================================");
        printf("\nSeno(sen) - Coseno(cos) - Tangente(tan) - Exponencial(exp) - Raiz Cuadrada(sqrt)");
        printf("\nValorAbsoluto(abs)- Arcocoseno(acos)- ArcoSeno(asen)- ArcoTan(atan)- Potencia(^)");
        printf("\n Valor Cercano(valcer)  - Maximo Numero(|) - Minimo Valor(&) - ArcoTanDoble(#)   ");
        printf("\n================================================================================");
        setCColor(color[6]);
	    printf("\n\nEmpieza Bandido!!!!!! \n\n==> ");
	
	int i;
	for(i=0; i<60; i++)
		variable[i] = 0;
	/*Retorna Parse*/
	return yyparse ( );
}

void setCColor( int color)
{
        static HANDLE hConsole;
 
        hConsole = GetStdHandle( STD_OUTPUT_HANDLE );
 
        SetConsoleTextAttribute( hConsole, color | (backcolor * 0x10 + 0x100) );
}

void actualizaVariable(char var, double valor)
{
	int b = posicionArray(var);
	variable[b] = valor;
}

double retornaValor(char var)
{
	int b = posicionArray(var);
	return variable[b];
}

int posicionArray(char var)
{
	int idx = -1;

	if(islower(var)) idx = var - 'a' + 26;//26sustitucion sub
	else if(isupper(var)) idx = var - 'A';

	return idx;
} 

double Sx(double x)
{
	return sin(x*RA);
}

double Cx(double x)
{
	return cos(x*RA);
}

double Tx(double x)
{
	return tan(x*RA);
}
//absoluto
double Ax(double x)
{
	return fabs(x);
}

double Ex(double x)
{
	return exp(x);
}

//raiz
double Rx(double x)
{
	return sqrt(x);
}

double ACx(double x)
{
	return acos(x*RA);
}

double ASx(double x)
{
	return asin(x*RA);
}

double ATx(double x)
{
	return atan(x*RA);
}
//valor cercano
double VCx(double x)
{
	return lround (x);
}




void yyerror(char *s)
{
printf( "Error: %s at %s, linea %d  %c Escribe Bien p Compare!!\n",s, yytext, yylineno);


}
