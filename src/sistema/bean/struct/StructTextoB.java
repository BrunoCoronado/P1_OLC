package sistema.bean.struct;

import sistema.ui.Principal;

public class StructTextoB {
    private String contenido;

    public StructTextoB() {
        contenido = "";
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public StructTextoB(String contenido) {
        this.contenido = contenido;
    }

    public  void insertar(){
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<h2> " + contenido + "</h2>\n");
    }
}
