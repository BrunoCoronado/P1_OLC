package sistema.bean.struct;

import sistema.ui.Principal;

public class StructImagen {
    private String path;
    private String alto;
    private String ancho;

    public StructImagen() {
        path = "";
        alto = "";
        ancho = "";
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getAlto() {
        return alto;
    }

    public void setAlto(String alto) {
        this.alto = alto;
    }

    public String getAncho() {
        return ancho;
    }

    public void setAncho(String ancho) {
        this.ancho = ancho;
    }

    public StructImagen(String path) {
        this.path = path;
    }

    public StructImagen(String path, String alto) {
        this.path = path;
        this.alto = alto;
    }

    public StructImagen(String path, String alto, String ancho) {
        this.path = path;
        this.alto = alto;
        this.ancho = ancho;
    }

    public void insertar(){
        String etiquetaImagen = "\n<img src=\"" + path + "\" ";
        if(!ancho.equals(""))
            etiquetaImagen += "width=\"" + ancho + "\" ";
        if(!alto.equals(""))
            etiquetaImagen += "heigth=\"" + alto + "\" ";
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  etiquetaImagen + ">\n");
    }
}
