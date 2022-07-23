                =============================================
                LAMINI Narimene       181831043933        L3 ACAD A G1
                                        Travail monôme
               ==============================================



%{
#include<stdio.h>
extern int NL,NC;
int yylex();
int yyerror(char* s);
char sauvType[25];
int v1,v2;
char  ch1[30],ch2[30];


%}
%code requires {
   struct enreg {
    int entier; 
   char* str;
   float reel; 
   char* car;
   char TypeCourrant[20];
   };

}
%union 
{ 
    int entier; 
   char* str;
   float reel; 
    char* car;
   struct enreg E;
   


 }
%token  VAR READ WRITE While IF EXECUT ELSE END_IF Programme  CONST SUP 
           SUPE EG DIFF INFE INF aff 
%token fin '[' ']' '+' '-' '*' ';' '%' '#' '&' '{' '}' sep '@' '|' '/' deuxpts '=' app '(' ')' guillemet dz
%token  <str>mc_idf
%token <entier>cst_intgerA
%token  <entier>cst_intgerB 
%token <entier>cst_intgerC
%token <reel>cst_realA 
%token  <reel>cst_realB 
%token  <reel>cst_realC
%token  <reel>cst_realD 
%token <car>cst_char 
%token <str>cst_string 
%token  <str>INTEGER
%token   <str>REAL
%token  <str>CHAR
%token  <str>STRING
%token <str>PROCESS 
%token <str>LOOP 
%token <str>ARRAY
%type <E> Exp_A Exp_B Exp_C AFF Constante Idf_Aff




%start S
%%
S : BIBLIOTHEQUE Programme mc_idf '{' DECLARATION  INSTRUCTION     '}' {printf("\nProgramme  syntaxiquement correct\n");}
;
BIBLIOTHEQUE : Biblio BIBLIOTHEQUE 
                  |   
				  
;
Biblio: dz PROCESS fin { if(rechercherBib($2,"Mot cle "," ",0, 1)==-1)
                                   printf("Erreur semantique a la ligne %d et la colonne %d : La bibliotheque %s est deja declaree \n",NL,NC , $2);
								   }
    | dz LOOP fin   { if(rechercherBib($2,"Mot cle "," ",0, 1)==-1)
                                   printf("Erreur semantique a la ligne %d et la colonne %d : La bibliotheque %s est deja declaree \n",NL,NC , $2);
								   }       
	| dz ARRAY fin    { if(rechercherBib($2,"Mot cle "," ",0, 1)==-1)
                                   printf("Erreur semantique a la ligne %d et la colonne %d : La bibliotheque %s est deja declaree \n",NL,NC , $2);
								   }      
;
/******************************************************PARTIE DECLARATION************************************************************/

DECLARATION:  CONST Dec_Cst DECLARATION  VAR Dec_Var DECLARATION  
                       | VAR Dec_Var DECLARATION  CONST Dec_Cst DECLARATION  
					   | CONST Dec_Cst DECLARATION 
					   |  VAR Dec_Var DECLARATION 
					   | 
                  					   
;
Dec_Var:  Type deuxpts Var Dec_Var
        | Type deuxpts Var
		| 
;
Dec_Cst: Type deuxpts Cst Dec_Cst
        | Type deuxpts Cst
		|
;
Var: liste_Var
      |liste_Tab
;
Cst: liste_Const
      
;
liste_Var: mc_idf sep liste_Var 
                   { if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",0);}
							    else 
								{printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  de %s \n",NL,NC,$1);}
					
							  }
							  
                 | mc_idf '=' Constante  sep liste_Var
				 
				 { if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",0);}
							    else 
								{printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  de %s \n",NL,NC,$1);}
					
						   if(!(
						   ((typeEntite($1)==1 )&& (strcmp($3.TypeCourrant,"INTEGER")==0))
						  || ((typeEntite($1)==2 )&& (strcmp($3.TypeCourrant,"REAL")==0))
						  || ((typeEntite($1)==3 )&& (strcmp($3.TypeCourrant,"STRING")==0))
						  || ((typeEntite($1)==4 )&& (strcmp($3.TypeCourrant,"CHAR")==0))
                             ))
							{ printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	} 
							  
							  if(strcmp($3.TypeCourrant,"INTEGER")==0)
							       {SetValEntiere($1,$3.entier);}
						       if(strcmp($3.TypeCourrant,"REAL")==0)
							       {SetValReelle($1,$3.reel); }
					}
							  
		         | mc_idf fin
				 
				 { if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",0);}
							    else 
								{printf("Erreur semantique a la ligne %d et a la colonne %d : Double declaration  de %s \n",NL,NC,$1);}
								
							  }
							  
			     | mc_idf  '=' Constante fin
				 
				 { if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",0);}
							    else 
								{printf("Erreur semantique a la ligne %d et a la colonne %d : Double declaration  de %s \n",NL,NC,$1);}
                            if(!(
						   ((typeEntite($1)==1 )&& (strcmp($3.TypeCourrant,"INTEGER")==0))
						  || ((typeEntite($1)==2 )&& (strcmp($3.TypeCourrant,"REAL")==0))
						  || ((typeEntite($1)==3 )&& (strcmp($3.TypeCourrant,"STRING")==0))
						  || ((typeEntite($1)==4 )&& (strcmp($3.TypeCourrant,"CHAR")==0))
                             ))
							{ printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	} 
							 	  if(strcmp($3.TypeCourrant,"INTEGER")==0)
							       {SetValEntiere($1,$3.entier); }
								  if(strcmp($3.TypeCourrant,"REAL")==0)
							       {SetValEntiere($1,$3.reel); }
								   
								   
							  }
							  
				 |  mc_idf sep liste_Tab
				 
				 { if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",0);}
							    else 
								printf("Erreur semantique a la ligne %d et a la colonne %d : Double declaration  de %s \n",NL,NC,$1);
							  }
				 | liste_Tab
				 
;
liste_Tab: mc_idf '['cst_intgerB']' sep liste_Tab 
                 {
				     if (Bib_Declaree("ARRAY","Mot cle "," ",0, 1)==-1)
						  { printf("Erreur semantique a la ligne %d et a la colonne %d : declaration du tableau %s sans declarer la bibliotheque ARRAY \n",NL,NC,$1);}
					 if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",$3);}
					 else 
					{printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  du tableau%s \n",NL,NC,$1);}
				      v1=$3;
				 
					}
                  | mc_idf '['cst_intgerB']'  fin
				    {
				     if (Bib_Declaree("ARRAY","Mot cle "," ",0, 1)==-1)
						   {printf("Erreur semantique a la ligne %d et a la colonne %d : declaration de %s sans declarer la bibliotheque ARRAY \n",NL,NC,$1);}
				     if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",$3);}
					else 
				  {printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  du tableau %s \n",NL,NC,$1);}
			            v1=$3;
					}

				  | mc_idf '['cst_intgerB']' sep liste_Var
				    {
				     if (Bib_Declaree("ARRAY","Mot cle "," ",0, 1)==-1)
						   {printf("Erreur semantique a la ligne %d et a la colonne %d : declaration du tableau %s sans declarer la bibliotheque ARRAY \n",NL,NC,$1);}
					if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"false",$3);}
					else 
					{printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  de %s \n",NL,NC,$1);}
				         v1=$3;
					}
;
liste_Const: mc_idf  '=' Constante  sep liste_Const
                              { 
							  if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"true",0);}
					          else 
					           {printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  de %s \n",NL,NC,$1);}
							    if(!(
						   ((typeEntite($1)==1 )&& (strcmp($3.TypeCourrant,"INTEGER")==0))
						  || ((typeEntite($1)==2 )&& (strcmp($3.TypeCourrant,"REAL")==0))
						  || ((typeEntite($1)==3 )&& (strcmp($3.TypeCourrant,"STRING")==0))
						  || ((typeEntite($1)==4 )&& (strcmp($3.TypeCourrant,"CHAR")==0))
                             ))
							{ printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                              if(strcmp($3.TypeCourrant,"INTEGER")==0)
							       {SetValEntiere($1,$3.entier);}
						       if(strcmp($3.TypeCourrant,"REAL")==0)
							       {SetValReelle($1,$3.reel); }							
							  }
						
				
							
                              							  
              | mc_idf  '=' Constante fin
                              { 
							  if(doubleDeclaration($1)==0)   { insererTYPE($1,sauvType,"true",0);}
					          else 
					           {printf("Erreur semantique a la ligne %d et a la colonne %d: Double declaration  de %s \n",NL,NC,$1);}
							   if(!(
						   ((typeEntite($1)==1 )&& (strcmp($3.TypeCourrant,"INTEGER")==0))
						  || ((typeEntite($1)==2 )&& (strcmp($3.TypeCourrant,"REAL")==0))
						  || ((typeEntite($1)==3 )&& (strcmp($3.TypeCourrant,"STRING")==0))
						  || ((typeEntite($1)==4 )&& (strcmp($3.TypeCourrant,"CHAR")==0))
                             ))
							{ printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                               if(strcmp($3.TypeCourrant,"INTEGER")==0)
							       {SetValEntiere($1,$3.entier);}
						       if(strcmp($3.TypeCourrant,"REAL")==0)
							       {SetValReelle($1,$3.reel); }							
							  }
				
							    
                              			  
;
Constante: cst_intgerA { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_intgerB
	                      { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_intgerC
	                     { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   | cst_realA{ $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }
	   | cst_realB
	                      { $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }

	   | cst_realC { $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }
	   |cst_realD   { $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_string  {$$.str=$1;
	                            strcpy($$.TypeCourrant ,"STRING");                 
								 }
	   |cst_char   {
	                            strcpy($$.TypeCourrant ,"CHAR");                 
								 }
		
;
Type: INTEGER    {strcpy(sauvType,$1);} 
         | REAL   {strcpy(sauvType,$1);} 
         | CHAR   {strcpy(sauvType,$1);} 
		 | STRING   {strcpy(sauvType,$1);} 
;

/*********************************************************PARTIE INSTRUCTIONS****************************************************************************/
INSTRUCTION:  TypeInst INSTRUCTION
                     | TypeInst INSTRUCTION
					 |
;
TypeInst : Boucle 
              | Condition
			  |Affectation_Arithmethique
		      | Entree
			  |Sortie
; 
Affectation_Arithmethique : Idf_Aff aff Exp_A fin
                               { if(strcmp($1.TypeCourrant ,$3.TypeCourrant)!=0)
							  { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}   
							   
							   }
                                            
;
 
Exp_A : Exp_A  '+'  Exp_B
         {if (Bib_Declaree("PROCESS","Mot cle "," ",0, 1)==-1)
		{printf("Erreur semantique a la ligne %d et a la colonne %d : utilisation d'une expression arithmetique sans declarer la bibliotheque PROCESS \n",NL,NC);}
			if (!(
			    (strcmp($1.TypeCourrant,$3.TypeCourrant)==0)
			  || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
		      ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
			))
                printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);
			}
       | Exp_A '-' Exp_B
	        {if (Bib_Declaree("PROCESS","Mot cle "," ",0, 1)==-1)
			       printf("Erreur semantique a la ligne %d et a la colonne %d : utilisation d'une expression arithmetique sans declarer la bibliotheque PROCESS \n",NL,NC);
	                            if(!(
					           ((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
					         || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
						     || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
						     ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
						
								  ))
                          { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
						  }
	   | Exp_B
	   {  if(strcmp($1.TypeCourrant,"INTEGER")==0)
						         {$$.entier =$1.entier;
								  strcpy($$.TypeCourrant ,"INTEGER");   
								  }
								else if(strcmp($1.TypeCourrant,"REAL")==0)
						         {  $$.reel = $1.reel;
								  strcpy($$.TypeCourrant ,"REAL");   
								  }
								  else if(strcmp($1.TypeCourrant,"STRING")==0)
						         {  $$.str = $1.str;
								  strcpy($$.TypeCourrant ,"STRING");   
								  }
								   else
						         {  $$.car = $1.car;
								  strcpy($$.TypeCourrant ,"CHAR");   
								  }					
                             }			 
;
Exp_B : Exp_B '*' Exp_C
                {if (Bib_Declaree("PROCESS","Mot cle "," ",0, 1)==-1)
			{printf("Erreur semantique a la ligne %d et a la colonne %d : utilisation d'une expression arithmetique sans declarer la bibliotheque PROCESS \n",NL,NC);}
					if(!(
					           ((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
					         || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
						     || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
						     ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
							 ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"STRING")==0 ))
							 ||((strcmp($1.TypeCourrant,"STRING")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
							 ||((strcmp($1.TypeCourrant,"CHAR")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
							 ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"CHAR")==0 ))
								  ))
                           printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);			

						   }
            | Exp_B '/' Exp_C
			{if (Bib_Declaree("PROCESS","Mot cle "," ",0, 1)==-1)
				     {printf("Erreur semantique a la ligne %d et a la colonne %d : utilisation d'une expression arithmetique sans declarer la bibliotheque PROCESS \n",NL,NC);}
				if(!(
					           ((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
					         || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
						     || ((strcmp($1.TypeCourrant,"REAL")==0 ) &&  (strcmp($3.TypeCourrant,"INTEGER")==0 ))
						     ||((strcmp($1.TypeCourrant,"INTEGER")==0 ) &&  (strcmp($3.TypeCourrant,"REAL")==0 ))
								  ))
                          { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
					if((strcmp($3.TypeCourrant,"INTEGER")==0 )&& $3.entier==0)
					  { printf("Erreur semantique a la ligne %d et a la colonne %d : Division par 0 \n",NL,NC);	}
                         						   
		     }
			| Exp_C
			{  if(strcmp($1.TypeCourrant,"INTEGER")==0)
						         {$$.entier =$1.entier;
								  strcpy($$.TypeCourrant ,"INTEGER");   
								  }
								else if(strcmp($1.TypeCourrant,"REAL")==0)
						         {  $$.reel = $1.reel;
								  strcpy($$.TypeCourrant ,"REAL");   
								  }
								  else if(strcmp($1.TypeCourrant,"STRING")==0)
						         {  $$.str = $1.str;
								  strcpy($$.TypeCourrant ,"STRING");   
								  }
								   else
						         {  $$.car = $1.car;
								  strcpy($$.TypeCourrant ,"CHAR");   
								  }					
                             }			 
				
;
Exp_C: '('Exp_A')'
             | AFF {  if(strcmp($1.TypeCourrant,"INTEGER")==0)
						         {$$.entier =$1.entier;
								  strcpy($$.TypeCourrant ,"INTEGER");   
								  }
								else if(strcmp($1.TypeCourrant,"REAL")==0)
						         {  $$.reel = $1.reel;
								  strcpy($$.TypeCourrant ,"REAL");   
								  }
								  else if(strcmp($1.TypeCourrant,"STRING")==0)
						         {  $$.str = $1.str;
								  strcpy($$.TypeCourrant ,"STRING");   
								  }
								   else
						         {  $$.car = $1.car;
								  strcpy($$.TypeCourrant ,"CHAR");   
								  }					
                             }			 
;


AFF : mc_idf    {if(doubleDeclaration($1)==0) 
						       {printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$1);}
							   if(typeEntite($1)==1)
							   { strcpy($$.TypeCourrant ,"INTEGER"); 
                                    $$.entier = GetValEntiere($1);							   
								}
                               if(typeEntite($1)==2)
							    {strcpy($$.TypeCourrant ,"REAL"); 
								     $$.reel = GetValReelle($1);	
                                 	}							
                                if(typeEntite($1)==3)
							    {strcpy($$.TypeCourrant ,"STRING");   
								}
                                if(typeEntite($1)==4)
							    {strcpy($$.TypeCourrant ,"CHAR");   
                                  }								
							    
							   }
       | cst_intgerA { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_intgerB
	                      { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_intgerC
	                     { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   | cst_realA{ $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }
	   | cst_realB
	                      { $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }

	   | cst_realC { $$.reel = $1;
	                            strcpy($$.TypeCourrant ,"REAL");                 
								 }
	   |cst_realD   { $$.entier = $1;
	                            strcpy($$.TypeCourrant ,"INTEGER");                 
								 }
	   |cst_string  { $$.str = $1;
	                            strcpy($$.TypeCourrant ,"STRING");                 
								 }
	   |cst_char   { $$.car = $1;
	                            strcpy($$.TypeCourrant ,"CHAR");                 
								 }
	|mc_idf '['cst_intgerB']'{if(doubleDeclaration($1)==0) 
						       {printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$1);}
							   if(typeEntite($1)==1)
							   { strcpy($$.TypeCourrant ,"INTEGER"); 
                                    $$.entier = GetValEntiere($1);							   
								}
                               if(typeEntite($1)==2)
							    {strcpy($$.TypeCourrant ,"REAL"); 
								     $$.reel = GetValReelle($1);	
                                 	}							
                                if(typeEntite($1)==3)
							    {strcpy($$.TypeCourrant ,"STRING");   
								}
                                if(typeEntite($1)==4)
							    {strcpy($$.TypeCourrant ,"CHAR");   
                                  }								
							    if((isTableau($1)==0 )&& (depasserTailleMax($1,$3)==0))
								{printf("erreur semantique a la ligne %d et la colonne %d :Debordement \n",NL,NC);}
								
								if(isTableau($1)==-1)
							{printf("erreur semantique a la ligne %d et la colonne %d :%s n'est pas un tableau \n",NL,NC,$1);}
							}   
;
Idf_Aff : mc_idf
              {
						   if(doubleDeclaration($1)==0) 
						       {printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$1);}
						
						if(estConstante($1)==0)
						{printf("erreur semantique a la ligne %d et la colonne %d : changement de valeur de la constante %s\n",NL,NC,$1);}
						if(typeEntite($1)==1)
						  {strcpy($$.TypeCourrant,"INTEGER");}
						  if(typeEntite($1)==2)
						  {strcpy($$.TypeCourrant,"REAL");}
						  if(typeEntite($1)==3)
						  {strcpy($$.TypeCourrant,"STRING");}
						  if(typeEntite($1)==4)
						 {strcpy($$.TypeCourrant,"CHAR");}
				
}
					
          | mc_idf '['cst_intgerB']' 
		    {
						   if(doubleDeclaration($1)==0) 
						      { printf("erreur semantique a la ligne %d et la colonne %d : %s tableau non declare \n",NL,NC,$1);}
				if(typeEntite($1)==1)
						  {strcpy($$.TypeCourrant,"INTEGER");}
						  if(typeEntite($1)==2)
						  {strcpy($$.TypeCourrant,"REAL");}
						  if(typeEntite($1)==3)
						  {strcpy($$.TypeCourrant,"STRING");}
						  if(typeEntite($1)==4)
						 {strcpy($$.TypeCourrant,"CHAR");}
					 if((isTableau($1)==0 )&& (depasserTailleMax($1,$3)==0))
								{printf("erreur semantique a la ligne %d et la colonne %d :Debordement \n",NL,NC,$1);}
					if(isTableau($1)==-1)
							{printf("erreur semantique a la ligne %d et la colonne %d :%s n'est pas un tableau \n",NL,NC,$1);}
						}
;

Boucle : Bcl_While '{' INSTRUCTION Bcl_While '}' fin
            | Bcl_While '{' INSTRUCTION Condition Bcl_While   '}' fin
			| Bcl_While '{' INSTRUCTION READ Bcl_While   '}' fin
			| Bcl_While '{' INSTRUCTION READ Bcl_While   '}' fin
			|Bcl_While '{' INSTRUCTION    '}' fin
;
Bcl_While : While '(' Exp_A Operation Exp_A')' 
                           {if (Bib_Declaree("LOOP","Mot cle "," ",0, 1)==-1)
						   printf("Erreur semantique a la ligne %d et a la colonne %d : utilisation d'une boucle While sans declarer la bibliotheque LOOP \n",NL,NC);
						         if(strcmp($3.TypeCourrant,$5.TypeCourrant)!=0)
					{ printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
					}
;
Operation :  SUP 
               | SUPE 
		       | EG 
		       | DIFF
		       | INFE 
		       | INF
;
Condition:  EXECUT Cond fin
;

Cond : INSTRUCTION IF '(' Exp_A Operation Exp_A ')' END_IF{
                                           if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                                               }
											   
											   
             |  INSTRUCTION IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT INSTRUCTION  END_IF
			 {  if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                                               }
											   
											   
	    |  READ IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT INSTRUCTION  END_IF
			 {  if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
											 
											 }
		|     READ IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT READ  END_IF
			   {if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
					}						 
		 |  READ IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT WRITE  END_IF
			  { if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
											 }
        | WRITE IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT INSTRUCTION  END_IF
			  { if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                                               }
         | WRITE IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT READ  END_IF
			  { if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                                               }
     |   WRITE IF '(' Exp_A Operation Exp_A ')' ELSE EXECUT WRITE  END_IF
			  { if(strcmp($4.TypeCourrant,$6.TypeCourrant)!=0)
										     { printf("Erreur semantique a la ligne %d et a la colonne %d : incompatibilite de type\n",NL,NC);	}
                                               }											   
;
	
Entree : READ '('cst_string '|' '@' mc_idf ')' fin
                     {
						   if(doubleDeclaration($6)==0) 
						       {printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$6);}
						if(signeFormat($3,$6)==-1)
						printf("erreur semantique a la ligne %d et la colonne %d :incompatibilite de signe de formatage %s par rapport au type de %s\n",NL,NC,$3,$6);
						}
;
Sortie : WRITE'(' cst_string '|' N_Idf ')' fin
 
;
 N_Idf : mc_idf sep N_Idf
 {
						   if(doubleDeclaration($1)==0) 
						       printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$1);
						}
            | mc_idf
			{
						   if(doubleDeclaration($1)==0) 
						       printf("erreur semantique a la ligne %d et la colonne %d : %s variable non declaree \n",NL,NC,$1);
						}
;

%%
int yyerror(char* msg)
{
printf("Erreur syntaxique a la ligne %d colonne %d\n",NL,NC);
return 1;
}
main () 
{
   initialisation();
    yyparse();
  
     afficher();

}
yywrap()
{}