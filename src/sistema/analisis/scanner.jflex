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

    public Symbol validarTextoEntreLLaves(String cadena){
        cadena = cadena.replace("\n", "");
        cadena = cadena.replace("<", "");
        cadena = cadena.replace(">", "");
        if(cadena.matches(".*([a-zA-Z]+|[0-9]+)+.*")){
            addToken(cadena, "texto Entre Etiquetas");
            return new Symbol(sym.textoEntreEtiquetas , yyline , yychar , cadena);
        }else{
            addToken("<", "menor que"); 
            return new Symbol(sym.menorQue , yyline , yychar , "<");
        }
    }
%}

%class Scanner
%public
%unicode
%full
%8bit
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
identificador = [a-z0-9_]+

%state ETIQUETA_CON_TEXTO, TEXTO_ENTRE_COMILLAS, TEXTO_ENTRE_COMILLAS_BOTON, TEXTO_ENTRE_COMILLAS_IMAGEN 
%state ETIQUETA_ESPECIAL, ETIQUETA_IMAGEN, ETIQUETA_BOTON, ETIQUETA_IMAGEN_CIERRE, ETIQUETA_BOTON_CIERRE
%state ETIQUETA_TABLA, ETIQUETA_TABLA_CIERRE, CONTENIDO_TABLA, ETIQUETA_ESPECIAL_TABLA, ETIQUETA_CON_TEXTO_TABLA
%state ETIQUETA_IMAGEN_TABLA, ETIQUETA_BOTON_TABLA, ETIQUETA_IMAGEN_CIERRE_TABLA, ETIQUETA_BOTON_CIERRE_TABLA
%state TEXTO_ENTRE_COMILLAS_BOTON_TABLA, TEXTO_ENTRE_COMILLAS_IMAGEN_TABLA, ETIQUETA_HS, TEXTO_ENTRE_COMILLAS_HSCRIPT

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
    "espacio"               { addToken(yytext(), "Palabra Reservada espacio"); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.espacio , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoA"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.textoA , yyline , yychar , yytext()); }
    "textob"                { addToken(yytext(), "Palabra Reservada textoB"); yybegin(ETIQUETA_CON_TEXTO); return new Symbol(sym.textoB , yyline , yychar , yytext()); }
    "imagen"                { addToken(yytext(), "Palabra Reservada imagen"); yybegin(ETIQUETA_IMAGEN); return new Symbol(sym.imagen , yyline , yychar , yytext()); }
    "boton"                 { addToken(yytext(), "Palabra Reservada boton"); yybegin(ETIQUETA_BOTON); return new Symbol(sym.boton , yyline , yychar , yytext()); }
    "tabla"                 { addToken(yytext(), "Palabra Reservada tabla"); yybegin(ETIQUETA_TABLA); return new Symbol(sym.tabla , yyline , yychar , yytext()); }
    "?hs"                   { addToken(yytext(), "Palabra Reservada etiqueta inicial hs"); yybegin(ETIQUETA_HS); return new Symbol(sym.inicioHS , yyline , yychar , yytext()); }
    
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_ESPECIAL>{
    {textoEntreEtiquetas}   { yybegin(YYINITIAL); return validarTextoEntreLLaves(yytext()); }
}

<ETIQUETA_IMAGEN>{
    ">"                     { addToken(yytext(), "mayor que"); yybegin(ETIQUETA_IMAGEN_CIERRE); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    "\""                    { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS_IMAGEN);}

    "path"                  { addToken(yytext(), "Palabra Reservada path"); return new Symbol(sym.path , yyline , yychar , yytext()); }
    "alto"                  { addToken(yytext(), "Palabra Reservada alto"); return new Symbol(sym.alto , yyline , yychar , yytext()); }
    "ancho"                 { addToken(yytext(), "Palabra Reservada ancho"); return new Symbol(sym.ancho , yyline , yychar , yytext()); }
    
    {numero}                { addToken(yytext(), "Numero"); return new Symbol(sym.numero , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_IMAGEN_CIERRE>{
    "<"                     { addToken(yytext(), "menor que"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }

    "imagen"                { addToken(yytext(), "Palabra Reservada imagen"); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.imagen , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_BOTON>{
    ">"                     { addToken(yytext(), "mayor que"); yybegin(ETIQUETA_BOTON_CIERRE); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    "\""                    { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS_BOTON); }

    "id"                    { addToken(yytext(), "Palabra Reservada id"); return new Symbol(sym.id , yyline , yychar , yytext()); }
    "texto"                 { addToken(yytext(), "Palabra Reservada texto"); return new Symbol(sym.texto , yyline , yychar , yytext()); }    
    
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_BOTON_CIERRE>{
    "<"                     { addToken(yytext(), "menor que cierre"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra cierre"); return new Symbol(sym.barra , yyline , yychar , yytext()); }

    "boton"                 { addToken(yytext(), "Palabra Reservada boton cierre"); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.boton , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_CON_TEXTO>{
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo"); yybegin(YYINITIAL);  return new Symbol(sym.titulo , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(YYINITIAL); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "alineacion"            { addToken(yytext(), "Palabra Reservada alineacion"); return new Symbol(sym.alineacion , yyline , yychar , yytext()); }    
    "\"izquierda\""         { addToken(yytext(), "Palabra Reservada izquierda"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"derecha"\"           { addToken(yytext(), "Palabra Reservada derecha"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"centrado"\"          { addToken(yytext(), "Palabra Reservada centrado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"justificado"\"       { addToken(yytext(), "Palabra Reservada justificado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }    
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoA"); yybegin(YYINITIAL); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.textoA , yyline , yychar , yytext()); }
    "textob"                { addToken(yytext(), "Palabra Reservada textoB"); yybegin(YYINITIAL); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.textoB , yyline , yychar , yytext()); }

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

<TEXTO_ENTRE_COMILLAS_BOTON>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(ETIQUETA_BOTON); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

<TEXTO_ENTRE_COMILLAS_IMAGEN>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(ETIQUETA_IMAGEN); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

<ETIQUETA_TABLA>{
    ">"                     { addToken(yytext(), "mayor que"); yybegin(CONTENIDO_TABLA); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    
    "borde"                 { addToken(yytext(), "Palabra Reservada borde"); return new Symbol(sym.borde , yyline , yychar , yytext()); }
    "true"                  { addToken(yytext(), "Palabra Reservada true"); return new Symbol(sym.booleano , yyline , yychar , yytext()); }
    "false"                 { addToken(yytext(), "Palabra Reservada false"); return new Symbol(sym.booleano , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<CONTENIDO_TABLA>{
    ">"                     { addToken(yytext(), "mayor que"); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "<"                     { addToken(yytext(), "menor que"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }

    "fila"                  { addToken(yytext(), "Palabra Reservada fila"); return new Symbol(sym.fila , yyline , yychar , yytext()); }   
    "columnac"              { addToken(yytext(), "Palabra Reservada columnac"); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.columnaC , yyline , yychar , yytext()); }
    "columna"               { addToken(yytext(), "Palabra Reservada columna"); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.columna , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(ETIQUETA_CON_TEXTO_TABLA); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "imagen"                { addToken(yytext(), "Palabra Reservada imagen"); yybegin(ETIQUETA_IMAGEN_TABLA); return new Symbol(sym.imagen , yyline , yychar , yytext()); }
    "boton"                 { addToken(yytext(), "Palabra Reservada boton"); yybegin(ETIQUETA_BOTON_TABLA); return new Symbol(sym.boton , yyline , yychar , yytext()); }
    "tabla"                 { addToken(yytext(), "Palabra Reservada tabla"); yybegin(ETIQUETA_ESPECIAL); return new Symbol(sym.tabla , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_ESPECIAL_TABLA>{
    {textoEntreEtiquetas}   { yybegin(CONTENIDO_TABLA); return validarTextoEntreLLaves(yytext()); }
}

<ETIQUETA_CON_TEXTO_TABLA>{
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    
    "titulo"                { addToken(yytext(), "Palabra Reservada titulo"); yybegin(CONTENIDO_TABLA);  return new Symbol(sym.titulo , yyline , yychar , yytext()); }
    "parrafo"               { addToken(yytext(), "Palabra Reservada parrafo"); yybegin(CONTENIDO_TABLA); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.parrafo , yyline , yychar , yytext()); }
    "alineacion"            { addToken(yytext(), "Palabra Reservada alineacion"); return new Symbol(sym.alineacion , yyline , yychar , yytext()); }    
    "\"izquierda\""         { addToken(yytext(), "Palabra Reservada izquierda"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"derecha"\"           { addToken(yytext(), "Palabra Reservada derecha"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"centrado"\"          { addToken(yytext(), "Palabra Reservada centrado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }
    "\"justificado"\"       { addToken(yytext(), "Palabra Reservada justificado"); return new Symbol(sym.tipoAlineacion , yyline , yychar , yytext()); }    
    "salto"                 { addToken(yytext(), "Palabra Reservada salto"); return new Symbol(sym.salto , yyline , yychar , yytext()); }
    "textoa"                { addToken(yytext(), "Palabra Reservada textoA"); yybegin(CONTENIDO_TABLA); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.textoA , yyline , yychar , yytext()); }
    "textob"                { addToken(yytext(), "Palabra Reservada textoB"); yybegin(CONTENIDO_TABLA); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.textoB , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {textoEntreEtiquetas}   { addToken(yytext(), "texto Entre Etiquetas"); return new Symbol(sym.textoEntreEtiquetas , yyline , yychar , yytext()); }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_IMAGEN_TABLA>{
    ">"                     { addToken(yytext(), "mayor que"); yybegin(ETIQUETA_IMAGEN_CIERRE_TABLA); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    "\""                    { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS_IMAGEN_TABLA);}

    "path"                  { addToken(yytext(), "Palabra Reservada path"); return new Symbol(sym.path , yyline , yychar , yytext()); }
    "alto"                  { addToken(yytext(), "Palabra Reservada alto"); return new Symbol(sym.alto , yyline , yychar , yytext()); }
    "ancho"                 { addToken(yytext(), "Palabra Reservada ancho"); return new Symbol(sym.ancho , yyline , yychar , yytext()); }
    
    {numero}                { addToken(yytext(), "Numero"); return new Symbol(sym.numero , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_IMAGEN_CIERRE_TABLA>{
    "<"                     { addToken(yytext(), "menor que"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra"); return new Symbol(sym.barra , yyline , yychar , yytext()); }

    "imagen"                { addToken(yytext(), "Palabra Reservada imagen"); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.imagen , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_BOTON_TABLA>{
    ">"                     { addToken(yytext(), "mayor que"); yybegin(ETIQUETA_BOTON_CIERRE_TABLA); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "="                     { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    "\""                    { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS_BOTON_TABLA); }

    "id"                    { addToken(yytext(), "Palabra Reservada id"); return new Symbol(sym.id , yyline , yychar , yytext()); }
    "texto"                 { addToken(yytext(), "Palabra Reservada texto"); return new Symbol(sym.texto , yyline , yychar , yytext()); }    
    
    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<ETIQUETA_BOTON_CIERRE_TABLA>{
    "<"                     { addToken(yytext(), "menor que cierre"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "\/"                    { addToken(yytext(), "barra cierre"); return new Symbol(sym.barra , yyline , yychar , yytext()); }

    "boton"                 { addToken(yytext(), "Palabra Reservada boton cierre"); yybegin(ETIQUETA_ESPECIAL_TABLA); return new Symbol(sym.boton , yyline , yychar , yytext()); }

    {finDeLinea}            { yychar=1; }
    {espacioEnBlanco}       {  }
    {comentarioSTRUCT}      {  }
}

<TEXTO_ENTRE_COMILLAS_BOTON_TABLA>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(ETIQUETA_BOTON_TABLA); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

<TEXTO_ENTRE_COMILLAS_IMAGEN_TABLA>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(ETIQUETA_IMAGEN_TABLA); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

<ETIQUETA_HS>{
    "\""                            { string.setLength(0); yybegin(TEXTO_ENTRE_COMILLAS_HSCRIPT); }
    "?>"                            { addToken(yytext(), "Palabra Reservada etiqueta final hs"); yybegin(YYINITIAL); return new Symbol(sym.finHS , yyline , yychar , yytext()); }
    "$"                             { addToken(yytext(), "dolar"); return new Symbol(sym.dolar , yyline , yychar , yytext()); }
    "="                             { addToken(yytext(), "igual"); return new Symbol(sym.igual , yyline , yychar , yytext()); }
    ";"                             { addToken(yytext(), "punto y coma"); return new Symbol(sym.puntoYComa , yyline , yychar , yytext()); }
    "+"                             { addToken(yytext(), "mas"); return new Symbol(sym.mas , yyline , yychar , yytext()); }
    "-"                             { addToken(yytext(), "menos"); return new Symbol(sym.menos , yyline , yychar , yytext()); }
    "*"                             { addToken(yytext(), "multiplicacion"); return new Symbol(sym.multiplicacion , yyline , yychar , yytext()); } 
    "\/"                            { addToken(yytext(), "division"); return new Symbol(sym.division , yyline , yychar , yytext()); }
    "."                             { addToken(yytext(), "punto"); return new Symbol(sym.punto , yyline , yychar , yytext()); }
    "("                             { addToken(yytext(), "parentesis abre"); return new Symbol(sym.parentesisAbre , yyline , yychar , yytext()); }
    ")"                             { addToken(yytext(), "parentesis cierra"); return new Symbol(sym.parentesisCierra , yyline , yychar , yytext()); }
    "{"                             { addToken(yytext(), "llave abre"); return new Symbol(sym.llaveAbre , yyline , yychar , yytext()); }
    "}"                             { addToken(yytext(), "llave cierra"); return new Symbol(sym.llaveCierra , yyline , yychar , yytext()); }
    ">"                             { addToken(yytext(), "mayor que"); return new Symbol(sym.mayorQue , yyline , yychar , yytext()); }                     
    "<"                             { addToken(yytext(), "menor que"); return new Symbol(sym.menorQue , yyline , yychar , yytext()); }
    "=="                            { addToken(yytext(), "igual igual"); return new Symbol(sym.igualIgual , yyline , yychar , yytext()); }
    "<="                            { addToken(yytext(), "menor igual"); return new Symbol(sym.menorIgual , yyline , yychar , yytext()); }
    ">="                            { addToken(yytext(), "mayor igual"); return new Symbol(sym.mayorIgual , yyline , yychar , yytext()); }
    "!="                            { addToken(yytext(), "no igual"); return new Symbol(sym.noIgual , yyline , yychar , yytext()); }
    "&&"                            { addToken(yytext(), "and"); return new Symbol(sym.and , yyline , yychar , yytext()); }
    "||"                            { addToken(yytext(), "or"); return new Symbol(sym.or , yyline , yychar , yytext()); }
    "!"                             { addToken(yytext(), "not"); return new Symbol(sym.not , yyline , yychar , yytext()); }

    "true"                          { addToken(yytext(), "Palabra Reservada true"); return new Symbol(sym.booleano , yyline , yychar , yytext()); }
    "false"                         { addToken(yytext(), "Palabra Reservada false"); return new Symbol(sym.booleano , yyline , yychar , yytext()); }
    "echo"                          { addToken(yytext(), "Palabra Reservada echo"); return new Symbol(sym.booleano , yyline , yychar , yytext()); }
    "if"                            { addToken(yytext(), "Palabra Reservada if"); return new Symbol(sym.controlIf , yyline , yychar , yytext()); }
    "else"                          { addToken(yytext(), "Palabra Reservada else"); return new Symbol(sym.controlElse , yyline , yychar , yytext()); }
    "repetir"                       { addToken(yytext(), "Palabra Reservada repetir"); return new Symbol(sym.repetir , yyline , yychar , yytext()); }

    {numero}                        { addToken(yytext(), "numero entero"); return new Symbol(sym.entero , yyline , yychar , yytext()); }
    {numeroDecimal}                 { addToken(yytext(), "numero decimal"); return new Symbol(sym.decimal , yyline , yychar , yytext()); }
    
    {comentarioHSCRIPT}             {  }
    {identificador}                 { addToken(yytext(), "identificador"); return new Symbol(sym.identificador , yyline , yychar , yytext()); }
    {finDeLinea}                    { yychar=1; }
    {espacioEnBlanco}               {  }
}

<TEXTO_ENTRE_COMILLAS_HSCRIPT>{
    "\""                            { addToken(string.toString(), "texto Entre Comillas"); yybegin(ETIQUETA_HS); return new Symbol(sym.textoEntreComillas , yyline , yychar , string.toString()); }
    [^\n\r\"\\]+                    { string.append( yytext() ); }
    \\t                             { string.append( '\t' ); }
    \\n                             { string.append( '\n' ); }
    \\r                             { string.append( '\r' ); }
    \\\"                            { string.append( '\"' ); }
    \\                              { string.append( '\\' ); }
}

.                           { addError(yytext(), "NO RECONOCIDO - ANALIZADOR LEXICO");}