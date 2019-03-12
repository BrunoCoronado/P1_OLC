package sistema.analisis

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
%}

%class scanner
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
espacioEnBlanco = {finDeLinea} | [ \t\f]
comentario = "<!" [^*] "!>"
texto = ([a-z]|[0-9]|{caracteres})*
caracteres = ("\!"|"\""|"\|"|"#"|"\$"|"%"|"&"|"/"|"("|")"|"="|"?"|"\\"|"\'"|"¡"|"¿"|"/"|"\*"|"-"|"\+"|"\."|"\{"|"\}"|"["|"]"|"-"|"_"|";"|":"|","|"~"|"\^")
numero = 0 | [0-9][0-9]*

%state STRING

%%

<YYINITIAL>{
    "compi"                 { addToken(yytext(), "Palabra Reservada compi      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo     "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "cabecera"              { addToken(yytext(), "Palabra Reservada cabecera   "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "cuerpo"                { addToken(yytext(), "Palabra Reservada cuerpo     "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "fondo"                 { addToken(yytext(), "Palabra Reservada fondo      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo    "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "alineacion"            { addToken(yytext(), "Palabra Reservada alineacion "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }    
    "izquierda"             { addToken(yytext(), "Palabra Reservada izquierda  "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "derecha"               { addToken(yytext(), "Palabra Reservada derecha    "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "centrado "             { addToken(yytext(), "Palabra Reservada centrado   "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "justificado"           { addToken(yytext(), "Palabra Reservada justificado"); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }    
    "salto"                 { addToken(yytext(), "Palabra Reservada salto      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoa     "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "textob"                { addToken(yytext(), "Palabra Reservada textob     "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "imagen"                { addToken(yytext(), "Palabra Reservada imagen     "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "path"                  { addToken(yytext(), "Palabra Reservada path       "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "alto"                  { addToken(yytext(), "Palabra Reservada alto       "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "ancho"                 { addToken(yytext(), "Palabra Reservada ancho      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "boton"                 { addToken(yytext(), "Palabra Reservada boton      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "id"                    { addToken(yytext(), "Palabra Reservada id         "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "texto"                 { addToken(yytext(), "Palabra Reservada texto      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "tabla"                 { addToken(yytext(), "Palabra Reservada tabla      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "borde "                { addToken(yytext(), "Palabra Reservada borde      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "true"                  { addToken(yytext(), "Palabra Reservada true       "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "false"                 { addToken(yytext(), "Palabra Reservada false      "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "fila"                  { addToken(yytext(), "Palabra Reservada fila       "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "columnac"              { addToken(yytext(), "Palabra Reservada columnac   "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "columna"               { addToken(yytext(), "Palabra Reservada columna    "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }

    ">"                     { addToken(yytext(), "mayor que                    "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "<"                     { addToken(yytext(), "menor que                    "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }                     
    "!"                     { addToken(yytext(), "exclamacion                  "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "/"                     { addToken(yytext(), "barra                        "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "="                     { addToken(yytext(), "igual                        "); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    "\""                    { addToken(yytext(), "comillas                     ");  string.setLength(0); yybegin(STRING); /*return new Symbol(sym. , yyline , yychar , yytext());*/ }
    {numero}                { addToken(yytext(), "numero"+yytext()              ); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {texto}                 { addToken(yytext(), "texto                        "); /*return new Symbol(sym.numero , yyline , yychar , yytext());*/ }
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentario}            {  }

}
<STRING> {
    "\""                    { addToken(string.toString(), "texto entre comillas"); addToken(yytext(), "comillacierra"); /*yybegin(YYINITIAL); return new Symbol(sym.cadena , yyline , yychar , string.toString());*/ }
    [^\n\r\"\\]+            { string.append( yytext() ); }
    \\t                     { string.append( '\t' ); }
    \\n                     { string.append( '\n' ); }
    \\r                     { string.append( '\r' ); }
    \\\"                    { string.append( '\"' ); }
    \\                      { string.append( '\\' ); }
}
