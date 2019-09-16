# Flex-Bison CODE
```text
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
```
# Flex-Bison Screenshot
![myimage-alt-tag](https://github.com/JeralBenites/Flex-Bison/blob/master/13457730_10209501009703318_70656300_n.png?raw=true)