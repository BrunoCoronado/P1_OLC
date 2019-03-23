package sistema.bean.struct;

import sistema.ui.Principal;

public class StructParrafo {
    private  String contenido;
    private String alineacion;

    public StructParrafo() {
        contenido = "";
        alineacion = "";
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public String getAlineacion() {
        return alineacion;
    }

    public void setAlineacion(String alineacion) {
        this.alineacion = alineacion;
    }

    public StructParrafo(String contenido, String alineacion) {
        this.contenido = contenido;
        this.alineacion = alineacion;
    }

    public void insertar(){
        if(!alineacion.equals(""))
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<p align=" + traducirAlineacion(alineacion) + " > " + contenido + "</p>\n");
        else
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<p> " + contenido + "</p>\n");
    }

    private String traducirAlineacion(String alineacion){
        switch (alineacion.toLowerCase()){
            case "\"izquierda\"":
                return  "\"left\"";
            case "\"derecha\"":
                return  "\"right\"";
            case "\"centrado\"":
                return  "\"center\"";
            case "\"justificado\"":
                return  "\"justify\"";
        }
        return "";
    }
}
