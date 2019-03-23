package sistema.bean.struct;

import sistema.ui.Principal;

public class StructTextoA {
    private String contenido;

    public StructTextoA() {
        contenido = "";
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public StructTextoA(String contenido) {
        this.contenido = contenido;
    }

    public  void insertar(){
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<h1> " + contenido + "</h1>\n");
    }
}
