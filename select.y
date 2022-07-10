%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    int yyerror();
%}

%token SELECT FROM TB_COL_AL_NAME AS NEWLINE WHERE NUM LE GE EQ NE AND OR OTHER_KEYWORDS STRCON

%%
start             :   SELECT exp NEWLINE   {printf("\nValid SQL Select Statement\n"); exit(0);}
                  ;

exp               :   cols FROM TB_COL_AL_NAME tables
                  |   cols FROM TB_COL_AL_NAME create_alias tables
                  ;

cols              :   '*'
                  |   TB_COL_AL_NAME cols
                  |   alias_ref TB_COL_AL_NAME cols
                  |   TB_COL_AL_NAME
                  |   alias_ref TB_COL_AL_NAME
                  |   ',' TB_COL_AL_NAME cols
                  |   ',' alias_ref TB_COL_AL_NAME cols
                  |   ',' TB_COL_AL_NAME
                  |   ',' alias_ref TB_COL_AL_NAME
                  |   TB_COL_AL_NAME  create_alias_col
	                |   TB_COL_AL_NAME  create_alias_col cols
	                |   ',' TB_COL_AL_NAME  create_alias_col cols
                  |   ',' TB_COL_AL_NAME  create_alias_col
                  |   alias_ref TB_COL_AL_NAME create_alias_col cols
                  |   alias_ref TB_COL_AL_NAME create_alias_col
                  |   ',' alias_ref TB_COL_AL_NAME create_alias_col cols
                  |   ',' alias_ref TB_COL_AL_NAME create_alias_col
                  ;

tables            :   ';'
                  |   condition ';'
                  |   ',' TB_COL_AL_NAME create_alias tables
                  |   ',' TB_COL_AL_NAME tables
                  ;

alias_ref         :   TB_COL_AL_NAME '.'
                  ;

create_alias_col  :   AS STRCON
	                ;

create_alias      :   AS TB_COL_AL_NAME
                  |   ' ' TB_COL_AL_NAME
                  ;

condition         :   WHERE where_cond
	                ;

where_cond	      :   cond
      	          |   cond OR where_cond
      	          |   cond AND where_cond
      	          ;

cond	            :   tb '<' NUM
                  |   tb '<' STRCON
                  |   tb '<' tb
                  |   tb '>' NUM
                  |   tb '>' tb
                  |   tb '>' STRCON
                  |   tb LE NUM
                  |   tb LE tb
                  |   tb LE STRCON
                  |   tb GE NUM
                  |   tb GE tb
                  |   tb GE STRCON
                  |   tb EQ NUM
                  |   tb EQ tb
                  |   tb EQ STRCON
                  |   tb NE NUM
                  |   tb NE tb
                  |   tb NE STRCON
                  ;

tb                :   TB_COL_AL_NAME
                  |   alias_ref TB_COL_AL_NAME
                  ;

%%

int yyerror(char const* s)
{
    printf("\nInvalid SQL Select Statement\n");
    return 1;
}

int main()
{
    printf("\nEnter SQL SELECT statement: ");
    yyparse();
    return 0;
}
