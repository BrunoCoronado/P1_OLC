package sistema.analisis;

import java_cup.runtime.Symbol;
import sistema.bean.Token;
import main.Main;

import static sistema.ui.Principal.errores;
import static sistema.ui.Principal.tokens;

%%

%{
    StringBuffer string = new StringBuffer();

    public void addToken(String lexema, String tipo){
        tokens.add(new Token(lexema, tipo, yyline, yycolumn));
    }

    public void addError(String lexema, String tipo){
        errores.add(new Token(lexema, tipo, yyline, yycolumn));
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
%cup
/*%standalone*/

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

%state ETIQUETA_CON_TEXTO, TEXTO_ENTRE_COMILLAS

%%

<YYINITIAL>{
    ">"                     { addToken(yytext(), "mayor que"); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "<"                     { addToken(yytext(), "menor que"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    "\""                    { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS);}
    "~"                     { addToken(yytext(), "aceptacion"); return new Symbol(sym.aceptacion , yyline , yychar , yytext()); }

    "compi"                 { addToken(yytext(), "Palabra Reservada compi"); return new Symbol(sym.compi , yyline , yychar , yytext()); }                     
    "cabecera"              { addToken(yytext(), "Palabra Reservada cabecera"); return new Symbol(sym.cabecera , yyline , yychar , yytext()); }
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo"); yybegin(ETIQUETA_CON_TEXTO);  return new Symbol(sym.titulo , yyline , yychar , yytext()); }
    "cuerpo"                { addToken(yytext(), "Palabra Reservada cuerpo"); return new Symbol(sym.cuerpo , yyline , yychar , yytext()); }
    "fondo"                 { addToken(yytext(), "Palabra Reservada fondo"); return new Symbol(sym.fondo , yyline , yychar , yytext()); }
    "espacio"               { addToken(yytext(), "Palabra Reservada espacio"); return new Symbol(sym.espacio , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoA"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.textoA , yyline , yychar , yytext()); }
    "textob"                { addToken(yytext(), "Palabra Reservada textoB"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.textoB , yyline , yychar , yytext()); }
    "imagen"                { addToken(yytext(), "Palabra Reservada imagen");  return new Symbol(sym.imagen , yyline , yychar , yytext()); }
    "path"                  { addToken(yytext(), "Palabra Reservada path"); return new Symbol(sym.path , yyline , yychar , yytext()); }
    "alto"                  { addToken(yytext(), "Palabra Reservada alto"); return new Symbol(sym.alto , yyline , yychar , yytext()); }
    "ancho"                 { addToken(yytext(), "Palabra Reservada ancho"); return new Symbol(sym.ancho , yyline , yychar , yytext()); }
    "boton"                 { addToken(yytext(), "Palabra Reservada boton"); return new Symbol(sym.boton , yyline , yychar , yytext()); }
    "id"                    { addToken(yytext(), "Palabra Reservada id"); return new Symbol(sym.id , yyline , yychar , yytext()); }
    "texto"                 { addToken(yytext(), "Palabra Reservada texto"); return new Symbol(sym.texto , yyline , yychar , yytext()); }

    {numero}                { addToken(yytext(), "Numero"); return new Symbol(sym.numero , yyline , yychar , yytext()); }
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_CON_TEXTO>{
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo"); yybegin(YYINITIAL);  return new Symbol(sym.titulo , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(YYINITIAL); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "alineacion"            { addToken(yytext(), "Palabra Reservada alineacion"); return new Symbol(sym.alineacion , yyline , yychar , yytext()); }    
    "\"izquierda\""         { addToken(yytext(), "Palabra Reservada izquierda"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"derecha"\"           { addToken(yytext(), "Palabra Reservada derecha"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"centrado"\"          { addToken(yytext(), "Palabra Reservada centrado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"justificado"\"       { addToken(yytext(), "Palabra Reservada justificado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }    
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoA"); yybegin(YYINITIAL); return new Symbol(sym.textoA , yyline , yychar , yytext()); }
    "textob"                { addToken(yytext(), "Palabra Reservada textoB"); yybegin(YYINITIAL); return new Symbol(sym.textoB , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {textoEntreEtiquetas}   { addToken(yytext(), "texto Entre Etiquetas"); return new Symbol(sym.textoEntreEtiquetas , yyline , yychar , yytext()); }
    {comentarioSTRUCT}      {  }
}

<TEXTO_ENTRE_COMILLAS>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(YYINITIAL); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

.                           { addError(yytext(), "NO RECONOCIDO - ANALIZADOR LEXICO");}