               =============================================
                LAMINI Narimene       181831043933        L3 ACAD A G1
                                        Travail monôme
               ==============================================


%{
   #include<stdio.h>
   #include<string.h>
   #include "LAMINI_Narimene.tab.h"   
   int NL=1,NC=1;
   #include "TS.h"
   extern YYSTYPE yylval;
%}

lettre [a-zA-Z]
chiffre[0-9]
lettreMaj [A-Z]
Real_A   "("[+-][1-9]{chiffre}*"."{chiffre}+")"
Real_B [1-9]{chiffre}*"."{chiffre}+
Real_C "("[+-][0]+"."{chiffre}+")"
Real_D  [0]"."{chiffre}+
idf {lettreMaj}({lettre}|{chiffre})*
integer_A "("[+-][1-9]{chiffre}*")"
integer_B  [1-9]{chiffre}*
integer_C  [0]
char  \'.\'
deb "/*"
ffin "*/"
string"\""([^"]|"\n")*"\""
Commentaire {deb}([^"/*"]|\n)*?{ffin}

%%
PROCESS       {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1); NC=NC+strlen(yytext); return PROCESS;}
LOOP              {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return LOOP;}
ARRAY           {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return ARRAY;}
VAR                   {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return VAR;}
READ                {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return READ;}
WRITE               {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return WRITE;}
While                 {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return While;}
IF                      {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return IF;}
EXECUT             {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return EXECUT;}
ELSE                  {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return ELSE;}
END_IF             {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return END_IF;}
Programme        {rechercher (yytext,"Mot cle "," ",0, 1);  NC=NC+strlen(yytext);return Programme;}
INTEGER               { yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return INTEGER;}
REAL                  {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return REAL;}
CHAR                {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return CHAR;}
STRING              {yylval.str=strdup(yytext); rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext);return STRING;}
CONST               {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return CONST;}
SUP                  {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return SUP;}
SUPE                {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return SUPE;}
EG                     {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return EG;}
DIFF                  {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return DIFF;}
INFE                 {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return INFE;}
INF                     {rechercher (yytext,"Mot cle "," ",0, 1);NC=NC+strlen(yytext); return INF;}
":="                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return aff;}	
 \n                       {NC=NC+strlen(yytext); NL++; }
"["                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '[';}
"]"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return ']';}
"+"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return  '+';}
"-"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '-';}
"/"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '/';}
"*"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '*';}
";"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return ';';}
"%"                     {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '%';}
"#"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '#';}
"&"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '&';}
"{"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return   '{';}
"}"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '}';}
"##"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext);return dz;} 
"//"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return sep;}
"@"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '@';}
"|"                        {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '|';}
"::"                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return deuxpts;}
"="                       {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '=';}
'                          { rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return app;}
"("                     {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return '(';}
")"                     {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return ')';}
"$"                      {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return fin;}
\"                        {rechercher (yytext,"Separateur",0,0, 2);NC=NC+strlen(yytext); return guillemet; }
{idf}                  {yylval.str=strdup(yytext);rechercher (yytext,"IDF ","",0, 0); 
                            if(yyleng >10)printf("Erreur! l'identifiant %s est trop long (Taille maximale: 10 caracteres)a la ligne %d et la colonne %d \n",yytext,NL,NC);
                             NC=NC+strlen(yytext);return mc_idf;}
{integer_A}        {yylval.entier= atoi(yytext);rechercher (yytext,"Cst entiere ","Entier",atoi(yytext), 0); NC=NC+strlen(yytext);return cst_intgerA;}
{integer_B}       {yylval.entier= atoi(yytext);rechercher (yytext,"Cst entiere ","Entier",atoi(yytext), 0);NC=NC+strlen(yytext);return cst_intgerB;}
{integer_C}        {yylval.entier= atoi(yytext);rechercher (yytext,"Cst entiere ","Entier",atoi(yytext), 0);NC=NC+strlen(yytext);return cst_intgerC;}
{Real_A}           {yylval.reel= atof(yytext);rechercher (yytext,"Cst reelle ","Reel",atof(yytext), 0);NC=NC+strlen(yytext);return cst_realA;}
{Real_B}          {yylval.reel= atof(yytext);rechercher (yytext,"Cst reelle ","Reel",atof(yytext), 0);NC=NC+strlen(yytext);return cst_realB;}
{Real_C}          {yylval.reel= atof(yytext);rechercher (yytext,"Cst reelle ","Reel",atof(yytext), 0);NC=NC+strlen(yytext);return cst_realC;}
{Real_D}          {yylval.reel= atof(yytext);rechercher (yytext,"Cst reelle ","Reel",atof(yytext), 0);NC=NC+strlen(yytext);return cst_realD;}  
{char}                {yylval.car= strdup(yytext);rechercher (yytext,"Cst caractere ","Caractere",0, 0);NC=NC+strlen(yytext);return cst_char;}
{string}              {yylval.str= strdup(yytext);rechercher (yytext,"Cst chaine ","String",0, 0);
                                int nb=0;
                while(yytext[nb]!='\0')
               { if(yytext[nb]=='\n'){NC=1;NL++;}
                 else {NC++;}
				 nb++;
				 }
				 return cst_string;}
				 
{Commentaire}   {NC=NC+strlen(yytext); }		 	
[ \t]                       {NC=NC+strlen(yytext); }
.                            {printf("Erreur lexicale ligne %d colonne %d ==> %s Entite Inconnue ! \n",NL,NC,yytext);}
%%
