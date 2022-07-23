              =============================================
                LAMINI Narimene       181831043933        L3 ACAD A G1
                                        Travail monôme
               ==============================================



/****************CREATION DE LA TABLE DES SYMBOLES ******************/
/***Step 1: Definition des structures de données ***/
#include <stdio.h>
#include <stdlib.h>


typedef struct
{
   int state;
   char name[50];
   char code[20];
   char type[20];
   char valChaine[700];
   float val;
   char est_constante[5];
   int tailleTab;
 } element;

typedef struct
{ 
   int state; 
   char name[20];
   char type[20];
} elt;

element tab[1000];
elt tabs[50],tabm[40];
extern char sav[20];
char chaine [] = "";


/***Step 2: initialisation de l'état des cases des tables des symbloles***/
/*0: la case est libre    1: la case est occupée*/

void initialisation()
{
  int i;
  for (i=0;i<50;i++)
  {
	  tab[i].state=0; 
	  strcpy(tab[i].type,chaine); 
	  
	 
  }
  
  

  for (i=0;i<20;i++)
    {tabs[i].state=0;
   }
	
	for (i=0;i<20;i++)
    {
    tabm[i].state=0;}
	
	

}


/***Step 3: insertion des entititées lexicales dans les tables des symboles ***/

void inserer (char entite[], char code[],char type[],float val,int i,int y)
{
  switch (y)
 { 
   case 0:/*insertion dans la table des IDF et CONST*/
       tab[i].state=1;
       strcpy(tab[i].name,entite);
       strcpy(tab[i].code,code);
	   strcpy(tab[i].type,type);
	   tab[i].val=val;
	   break;

   case 1:/*insertion dans la table des mots clés*/
       tabm[i].state=1;
       strcpy(tabm[i].name,entite);
       strcpy(tabm[i].type,code);
       break; 
    
   case 2:/*insertion dans la table des séparateurs*/
      tabs[i].state=1;
      strcpy(tabs[i].name,entite);
      strcpy(tabs[i].type,code);
      break;
 }

}

/***Step 4: La fonction Rechercher permet de verifier  si l'entité existe dèja dans la table des symboles */
void rechercher (char entite[], char code[],char type[],float val,int y)	
{

int j,i;

switch(y) 
  {
   case 0:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0; ((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
        if((i<1000)&&(strcmp(entite,tab[i].name)!=0))
        { 
	        
			inserer(entite,code,type,val,i,0); 
	      
         }
       
        break;

   case 1:/*verifier si la case dans la tables des mots clés est libre*/
       
       for (i=0;((i<50)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if((i<50)&&(strcmp(entite,tabm[i].name)!=0))
		{if((strcmp(entite,"PROCESS")!=0) && (strcmp(entite,"LOOP")!=0)&& (strcmp(entite,"ARRAY")!=0)		)
          inserer(entite,code,type,val,i,1);
		}
       
        break; 
    
   case 2:/*verifier si la case dans la tables des séparateurs est libre*/
         for (i=0;((i<40)&&(tabs[i].state==1))&&(strcmp(entite,tabs[i].name)!=0);i++); 
        if((i<40)&&(strcmp(entite,tabs[i].name)!=0))
         inserer(entite,code,type,val,i,2);
     
        break;
  }

}


/***Step 5 L'affichage du contenue de la table des symboles ***/

void afficher()
{int i;
 
printf("\n\t################################################################# TABLE DES SYMBOLES ###########################################################\n\n");
printf("\n\n\t-----------------------------------------------------------------Table des symboles IDF et CST-------------------------------------------------------------\n\n");
printf("\t\t***********************************************************\n");
printf("\t\t| NOM        |  CODE          | TYPE         | VALEUR      |     \n");
printf("\t\t***********************************************************\n");

  
for(i=0;i<70;i++)
{	
	
    if(tab[i].state==1)
      { 
        printf("\t\t|%10s |%15s | %12s | %12f |\n",tab[i].name,tab[i].code,tab[i].type,tab[i].val);
		printf("\t\t------------------------------------------------------------\n");
		
         
      }
	 
}

 
printf("\n\n\t-----------------------------------------------------------------Table des symboles mots cles-------------------------------------------------------------\n\n");
printf("\t\t***************************\n");
printf("\t\t|   NOM     |   CODE      |\n");
printf("\t\t***************************\n");
  
for(i=0;i<40;i++)
{
    if(tabm[i].state==1)
      { 
        printf("\t\t|%10s |%12s | \n",tabm[i].name, tabm[i].type);
			printf("\t\t--------------------------\n");
               
      }
}

printf("\n\n\t-----------------------------------------------------------------Table des symboles separateurs-------------------------------------------------------------\n\n");

printf("\t\t***************************\n");
printf("\t\t|   NOM     |   CODE      | \n");
printf("\t\t***************************\n");
  
for(i=0;i<50;i++)
{
    if(tabs[i].state==1)
      { 
        printf("\t\t|%10s |%12s | \n\n",tabs[i].name,tabs[i].type );
			printf("\t\t--------------------------\n");
      }
}

}

/*****************************************************************LES FONCTIONS DES ROUTINES SEMATIQUES*************************************************************/
   /* La fonction  Recherche_position retourne la position d'un element dans la TS*/
   int Recherche_position(char entite[])
		{
		int i=0;
		while(i<1000)
		{
		
		if (strcmp(entite,tab[i].name)==0) return i;	
		i++;
		}
 
		return -1;
		
		}
    /* La fonction  insererTYPE insere le type d'un element dans la TS si ce dernier est vide*/
	
	 void insererTYPE(char entite[], char type[],char verifConst[],int taille)
	{
       int pos;
	   pos=Recherche_position(entite);
	   if(pos!=-1)  { strcpy(tab[pos].type,type); }
	  strcpy(tab[pos].est_constante,verifConst); 
	  tab[pos].tailleTab= taille;
	}
    
	  /* La fonction doubleDeclaration verifie si un element dans la TS est deja declare en consultant le champs type */
	  
	int doubleDeclaration(char entite[])
	{
	int pos;
	pos=  Recherche_position(entite);
	if(strcmp(tab[pos].type,"")==0) return 0;
	   else return -1;
	}
	/* la fonction insererBib permet d'inserer une bibliotheque a la TS */
	void insererBib (char entite[], char code[],char type[],float val,int i)
{
  
     tabm[i].state=1;
       strcpy(tabm[i].name,entite);
       strcpy(tabm[i].type,code);
}
/* La fonction rechercherBib verifie si une bibliotheque existe deje dans la TS  */
int rechercherBib (char entite[], char code[],char type[],float val)
{ int i;
	for (i=0;((i<50)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if((i<50)&&(strcmp(entite,tabm[i].name)!=0))
		{
			insererBib (entite,code,type,val,i); /* si la bibliotheque n'existe pas alors on l'insere dans la TS */
			return 0;
		}
	   else
	   return -1;
	
	
}
/* La fonction  Bib_Declaree verifie si une bibliotheque est declaree (c-à-d elle existe dans la TS) */
int Bib_Declaree(char entite[], char code[],char type[],float val)
{ int i;
	for (i=0;((i<50)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if((i<50)&&(strcmp(entite,tabm[i].name)!=0))
		{
			return -1;
		}
	   else
	   return 0;
		
}
/* La fonction typeEntite  retourne un entier selon le type de l'entitee passee en parametres */
int typeEntite(char entite[])
	{
	int pos;
	pos=  Recherche_position(entite);
	if(strcmp(tab[pos].type,"INTEGER")==0) return 1;
	if(strcmp(tab[pos].type,"REAL")==0) return 2;
	if(strcmp(tab[pos].type,"STRING")==0) return 3;
	if(strcmp(tab[pos].type,"CHAR")==0) return 4;
	   
	}
	int codeEntite(char entite[])
	{
	int pos;
	pos=  Recherche_position(entite);
	if((strcmp(tab[pos].type,"Cst entiere")==0) ||(strcmp(tab[pos].type,"Cst reelle")==0)||(strcmp(tab[pos].type,"Cst chaine")==0)||(strcmp(tab[pos].type,"Cst caractere")==0))
	   return 0;
	 else return -1;
	}
	/* La fonction estConstante verifie si une entitee est constante en consultant le champs est_constante dans la TS  */
	int estConstante(char entite[])
	{  
	int pos;
	pos = Recherche_position(entite);
	if((strcmp(tab[pos].est_constante,"true"))==0)
	return 0;
	else 
	return -1;
		
		
	}
	/*La fonction depasserTailleMax verifie si la taille passee en parametres depasse celle de l'entitee*/
	int depasserTailleMax(char entite[],int taille)
	{     int pos;
			pos = Recherche_position(entite);
			if(taille > tab[pos].tailleTab)
			return 0;
			else
			return -1;
		
		
	}
	/* La fonction isTableau verifie si une entitee est un tableau*/
	int isTableau(char entite[])
	{    int pos;
			pos = Recherche_position(entite);
			if(tab[pos].tailleTab !=0)
			return 0;
			else 
			return -1;
	}
	/*La fonction signeFormat vteste l'egalite entre le type de entite2 et le signe de formatage qui est entite1*/
	int signeFormat(char entite1[] , char entite2[])
	{ int pos;
	    	pos = Recherche_position(entite2);
	if (strcmp(entite1 , "\";\"")==0)
		{   if(strcmp(tab[pos].type,"INTEGER")!=0)return -1;}
     if (strcmp(entite1 , "\"%\"")==0)
		{   if(strcmp(tab[pos].type,"REAL")!=0)return -1;}
     if (strcmp(entite1, "\"?\"")==0)
		{   if(strcmp(tab[pos].type,"STRING")!=0)return -1;}
	 if (strcmp(entite1 , "\"&\"")==0)
		{   if(strcmp(tab[pos].type,"CHAR")!=0)return -1;}
		
	return 0;		
			
}
void SetValEntiere(char entite[] , float val)
{
	int pos;
	    	pos = Recherche_position(entite);
	 if(pos!=-1)tab[pos].val = val;
}
int GetValEntiere(char entite[])
{int pos;
	pos = Recherche_position(entite);
			return tab[pos].val;
}

void SetValReelle(char entite[] , float val)
{
	int pos;
	    	pos = Recherche_position(entite);
	 if(pos!=-1)tab[pos].val = val;
}
float GetValReelle(char entite[])
{int pos;
	pos = Recherche_position(entite);
			return tab[pos].val;
}



	
