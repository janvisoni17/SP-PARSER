%{
    #include "y.tab.h"
    /*no spaces between columns of columlist and tables of table list*/
%}
name [a-zA-Z][a-zA-Z_]*
string_cond [\']([ ]*{name}*)*[\']
number [0-9]+

%%

("SELECT "|"Select "|"select ")     {return SELECT;}
(" WHERE "|" Where "|" where ")     {return WHERE;}
(" OR "|" Or "|" or ")     	        {return OR;}
(" AND "|" And "|" and ")     	    {return AND;}
{number}                            {return NUM;}
{string_cond}                       {return STRCON;}
"<="                                {return LE;}
">="                                {return GE;}
"="             		                {return EQ;}
"<>"              		              {return NE;}
(" FROM "|" From "|" from ")        {return FROM;}
(" AS "|" As "|" as ")              {return AS;}
("CREATE"|"create"|"Create"|"HAVING"|"Having"|"having"|"LIKE"|"Like"|"like"|"ORDER"|"Order"|"order"|"NOT"|"Not"|"not"|"NULL"|"Null"|"null"|"BETWEEN"|"Between"|"between"|"ASC"|"Asc"|"asc"|"CURRENT_DATE"|"Current_date"|"current_date"|"IS"|"Is"|"is"|"IN"|"In"|"in"|"SYSDATE"|"Sysdate"|"sysdate"|"DUAL"|"dual"|"Dual")              {return OTHER_KEYWORDS;}
{name}                              {return TB_COL_AL_NAME; }
.                                   {return *yytext;}
\n                                  {return NEWLINE;}
%%
int yywrap()
{
  return 1;
}
