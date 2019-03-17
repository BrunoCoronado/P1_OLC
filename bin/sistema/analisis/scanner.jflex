package sistema.analisis;

/*impor java_cup.runtime.Symbol;*/
import sistema.bean.Token;
import main.Main;

%%

%{
    StringBuffer string = new StringBuffer();

    public void addToken(String lexema, String tipo){
        main.Main.tokens.add(new Token(lexema, tipo, yyline, yycolumn));
    }

    public void addError(String lexema, String tipo){
        main.Main.errores.add(new Token(lexema, tipo, yyline, yycolumn));
    }

    public void removerUltimoToken(){
        try{
            main.Main.tokens.remove(main.Main.tokens.size() - 1);
        }catch(Exception ex){}
    }
%}

%class Scanner
%public
%unicode
%full
%char
%line
%column
%ignorecase
/*%cup*/
%standalone

finDeLinea = \r|\n|\r\n
caracterDeEntrada = [^\r\n]
espacioEnBlanco = {finDeLinea} | [ \t\f]
comentarioSTRUCT = "<!" [^!]* "!>"
comentarioHSCRIPT = {comentarioMultilinea} | {ComentarioUnaLinea}
comentarioMultilinea   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
ComentarioUnaLinea     = "//" {caracterDeEntrada}* {finDeLinea}?
textoEntreEtiquetas = ">" [^<]* "<"
numero = 0 | [1-9][0-9]*
numeroDecimal = (0 | [1-9][0-9]*) "." (0 | [1-9][0-9]*)
identificador = [a-z] ([a-z] | [0-9] | "_")*

%state TEXTO, HSCRIPT, CADENA

%%

<YYINITIAL>{
    ">"                     { addToken(yytext(), "mayor que"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "<"                     { addToken(yytext(), "menor que"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "/"                     { addToken(yytext(), "barra"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "="                     { addToken(yytext(), "igual"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "\""                    { addToken(yytext(), "comillas");  string.setLength(0); yybegin(TEXTO); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "?"                     { addToken(yytext(), "interrogacion"); yybegin(HSCRIPT);/*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "compi"                 { addToken(yytext(), "Palabra Reservada compi"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "cabecera"              { addToken(yytext(), "Palabra Reservada cabecera"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo");  /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "cuerpo"                { addToken(yytext(), "Palabra Reservada cuerpo"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "espacio"               { addToken(yytext(), "Palabra Reservada espacio"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoa"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "textob"                { addToken(yytext(), "Palabra Reservada textob"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "imagen"                { addToken(yytext(), "Palabra Reservada imagen");  /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "boton"                 { addToken(yytext(), "Palabra Reservada boton"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "tabla"                 { addToken(yytext(), "Palabra Reservada tabla"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "fila"                  { addToken(yytext(), "Palabra Reservada fila"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "columnac"              { addToken(yytext(), "Palabra Reservada columnac"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "columna"               { addToken(yytext(), "Palabra Reservada columna"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "fondo"                 { addToken(yytext(), "Palabra Reservada fondo"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "alineacion"            { addToken(yytext(), "Palabra Reservada alineacion");/*return new Symbol(sym. , yyline , yychar , yytext());*/ }    
    "izquierda"             { addToken(yytext(), "Palabra Reservada izquierda"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "derecha"               { addToken(yytext(), "Palabra Reservada derecha"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "centrado"              { addToken(yytext(), "Palabra Reservada centrado"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "justificado"           { addToken(yytext(), "Palabra Reservada justificado"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }    
    "path"                  { addToken(yytext(), "Palabra Reservada path"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "alto"                  { addToken(yytext(), "Palabra Reservada alto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "ancho"                 { addToken(yytext(), "Palabra Reservada ancho"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "id"                    { addToken(yytext(), "Palabra Reservada id"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "texto"                 { addToken(yytext(), "Palabra Reservada texto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "borde"                 { addToken(yytext(), "Palabra Reservada borde"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "true"                  { addToken(yytext(), "Palabra Reservada true"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "false"                 { addToken(yytext(), "Palabra Reservada false"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }

    {textoEntreEtiquetas}   { addToken(yytext(), "cadena"); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {numero}                { addToken(yytext(), "numero"); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<TEXTO>{
    "\""                    { addToken(string.toString(), "cadena"); addToken(yytext(), "comilla"); yybegin(YYINITIAL);/*yybegin(YYINITIAL); return new Symbol(sym.cadena , yyline , yychar , string.toString());*/ }
    [^\n\r\"\\]+            { string.append( yytext() ); }
    \\t                     { string.append( '\t' ); }
    \\n                     { string.append( '\n' ); }
    \\r                     { string.append( '\r' ); }
    \\\"                    { string.append( '\"' ); }
    \\                      { string.append( '\\' ); }
}

<HSCRIPT>{
    "?"                     { addToken(yytext(), "interrogacion"); yybegin(YYINITIAL);/*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "$"                     { addToken(yytext(), "dolar"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "\""                    { addToken(yytext(), "comillas");  string.setLength(0); yybegin(CADENA); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "="                     { addToken(yytext(), "igual"); /*return new Symbol(sym.suma , yyline , yychar , yytext());*/ }
    "+"                     { addToken(yytext(), "suma"); /*return new Symbol(sym.suma , yyline , yychar , yytext());*/ }
    "-"                     { addToken(yytext(), "resta"); /*return new Symbol(sym.resta , yyline , yychar , yytext());*/ }
    "*"                     { addToken(yytext(), "multiplicacion"); /*return new Symbol(sym.multiplicacion , yyline , yychar , yytext());*/ }
    "/"                     { addToken(yytext(), "division"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    ";"                     { addToken(yytext(), "punto y coma"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "."                     { addToken(yytext(), "punto"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "("                     { addToken(yytext(), "parentesis abre"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    ")"                     { addToken(yytext(), "parentesis cierra"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "{"                     { addToken(yytext(), "llave abre"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "}"                     { addToken(yytext(), "llave cierra"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "["                     { addToken(yytext(), "corchete abre"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    "]"                     { addToken(yytext(), "corchete cierra"); /*return new Symbol(sym.division , yyline , yychar , yytext());*/ }
    ">"                     { addToken(yytext(), "operador mayor que"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "<"                     { addToken(yytext(), "operador menor que"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "=="                    { addToken(yytext(), "operador igual igual"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "<="                    { addToken(yytext(), "operador menor igual"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    ">="                    { addToken(yytext(), "operador mayor igual"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "!="                    { addToken(yytext(), "operador no igual"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "&&"                    { addToken(yytext(), "operador AND"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "||"                    { addToken(yytext(), "operador OR"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "!"                     { addToken(yytext(), "operador NOT"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "#"                     { addToken(yytext(), "numerañ"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }

    "hs"                    { addToken(yytext(), "Palabra Reservada de difinicion HScript"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "true"                  { addToken(yytext(), "Palabra Reservada true"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "false"                 { addToken(yytext(), "Palabra Reservada false"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "echo"                  { addToken(yytext(), "Palabra Reservada echo"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "if"                    { addToken(yytext(), "Palabra Reservada if"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "else"                  { addToken(yytext(), "Palabra Reservada else"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "repetir"               { addToken(yytext(), "Palabra Reservada repetir"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }

    "insertar"              { addToken(yytext(), "Funcion insertar"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "crearparrafo"          { addToken(yytext(), "Funcion crear parrafo"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setalineacion"         { addToken(yytext(), "Funcion set alineacion"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getalineacion"         { addToken(yytext(), "Funcion get alineacion"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ } 
    "creartextoa"           { addToken(yytext(), "Funcion crear texto A"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "creartextob"           { addToken(yytext(), "Funcion crear texto B"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setcontenido"          { addToken(yytext(), "Funcion set contenido"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getcontenido"          { addToken(yytext(), "Funcion get contenido"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "crearimagen"           { addToken(yytext(), "Funcion crear imagen"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setpath"               { addToken(yytext(), "Funcion set path"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getpath"               { addToken(yytext(), "Funcion get path"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setalto"               { addToken(yytext(), "Funcion set alto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getalto"               { addToken(yytext(), "Funcion get alto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setancho"              { addToken(yytext(), "Funcion set ancho"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getancho"              { addToken(yytext(), "Funcion get ancho"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "creartabla"            { addToken(yytext(), "Funcion crear tabla"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "setborde"              { addToken(yytext(), "Funcion set borde"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "getborde"              { addToken(yytext(), "Funcion get borde"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "crearboton"            { addToken(yytext(), "Funcion crear boton"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "settexto"              { addToken(yytext(), "Funcion set texto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "gettexto"              { addToken(yytext(), "Funcion get texto"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "clickboton"            { addToken(yytext(), "Funcion click boton"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }

    {identificador}         { addToken(yytext(), "identificador"); /*return new Symbol(sym.identificador , yyline , yychar , yytext());*/ }
    {numero}                { addToken(yytext(), "numero"); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {numeroDecimal}         { addToken(yytext(), "numeroDecimal"); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioHSCRIPT}     { }
}

<CADENA>{
    "\""                    { addToken(string.toString(), "cadena"); addToken(yytext(), "comilla"); yybegin(HSCRIPT);/*yybegin(YYINITIAL); return new Symbol(sym.cadena , yyline , yychar , string.toString());*/ }
    [^\n\r\"\\]+            { string.append( yytext() ); }
    \\t                     { string.append( '\t' ); }
    \\n                     { string.append( '\n' ); }
    \\r                     { string.append( '\r' ); }
    \\\"                    { string.append( '\"' ); }
    \\                      { string.append( '\\' ); }
}