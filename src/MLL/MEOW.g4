grammar MEOW;


compilationUnit
    :   consts? functions? mainProg
;


block
    :   OPEN_FIG_PAREN (statment )* CLOSE_FIG_PAREN
    ;


consts
   :    CONST varDeclaration SEMICOLON (CONST varDeclaration SEMICOLON)*
   ;


callMethode
    :   varname OPEN_PAREN expressionList CLOSE_PAREN
    ;


mainProg
    : MAIN block
    ;


functions
    :   DEF varname OPEN_PAREN parameterList CLOSE_PAREN block (DEF varname OPEN_PAREN parameterList CLOSE_PAREN block)*
    ;


statment
    :   varDeclaration SEMICOLON
    |   callMethode SEMICOLON
    |   expression SEMICOLON
    |   print SEMICOLON
    |   ifStatment
    |   assigment
    |   whileStatment
    |   forStatment
    ;




print
    :   PRINT OPEN_PAREN expressionList CLOSE_PAREN
    ;


ifStatment
    :   IF OPEN_PAREN conclusionList CLOSE_PAREN  block (ELSE block)?
    ;


conclusionList
    :   conclusion (pob=(AND | OR) conclusion)*
    ;


forStatment
    :   FOR OPEN_PAREN forInside CLOSE_PAREN block
    ;

forInside
    :   forInit SEMICOLON conclusionList SEMICOLON expression
    ;

forInit
    :  (varDeclaration | expression) (COMMA (varDeclaration | expression))*
    ;

whileStatment
    :   WHILE OPEN_PAREN conclusionList CLOSE_PAREN block
    ;

conclusion
    :   expression # ExpConclusin
    |   callMethode # CallMethodeConlusin
    |   expression op = (LOGIC_EQUAL | NEGATION_EQUAL) expression # EqualsConclusion
    |   expression op = (MORE_ | MORE_EQUAL )  expression # MoreThenConclusion
    |   expression op = (LESS_ | LESS_EQUAL ) expression # LessThenConclusion
    ;


varDeclaration
    :   type varname (EQUAL expression)?
    ;


assigment
    :   varname EQUAL expression
    ;

expressionList
    :   (expression (COMMA expression)*)?
    ;

parameterList
    :   (varDeclaration (COMMA varDeclaration)*)?
    ;


expression
    :   assigment # AssigmentExpression
    |   callMethode # CallMethodeExpression
    |   expression op = (MULTIPLY | DIVISION | MOD) expression # MultipliesExpression
    |   expression  op = ( SUM | SUB ) expression # SummExpression
    |   varname # VarNameExpression
    |   literal # LiteralExpression
    |   OPEN_PAREN expression CLOSE_PAREN # ParenExpression
    ;


literal
    :   boolLiteral
    |   intLiteral
    |   floatLiteral
    |   charLiteral
    ;

intLiteral
    :   NUMBER
    ;

boolLiteral
    :   TRUE
    |   FALSE
    ;

charLiteral
    :   BACKSLASH LETTERS BACKSLASH
    ;


floatLiteral
    :   NUMBER DOT NUMBER
    ;


type
    :   INT
    |   CHAR
    |   FLOAT
    |   BOOL
    ;


varname
   : LETTERS (LETTERS | NUMBER )*
   ;




DEF : 'def';
OPEN_PAREN : '(';
CLOSE_PAREN : ')';
OPEN_FIG_PAREN : '{';
CLOSE_FIG_PAREN : '}';
CONST : 'const';
SEMICOLON : ';';
MAIN : 'main()';
PRINT : 'print';
IF : 'if';
ELSE : 'else';
AND : 'and';
OR : 'or';

FOR : 'for';
COMMA : ',';
WHILE : 'while';

LOGIC_EQUAL : '==';
NEGATION_EQUAL : '!=';
MORE_ : '>';
MORE_EQUAL : '>=';
LESS_ : '<';
LESS_EQUAL : '<=';
EQUAL : '=';

MULTIPLY : '*';
DIVISION : '/';
MOD : '%';
SUM : '+';
SUB : '-';

TRUE : 'true';
FALSE : 'false';
BACKSLASH : '\\';
DOT : '.';

INT : 'int';
CHAR : 'char';
FLOAT : 'float';
BOOL : 'bool';


LETTERS
   : ('a' .. 'z' | 'A' .. 'Z') +
   ;


NUMBER
    :   [0-9] ([0-9])*
    ;


WS:                 [ \t\r\n\u000C]+ -> channel(HIDDEN);
COMMENT:            '/*' .*? '*/'    -> channel(HIDDEN);
LINE_COMMENT:       '//' ~[\r\n]*    -> channel(HIDDEN);
