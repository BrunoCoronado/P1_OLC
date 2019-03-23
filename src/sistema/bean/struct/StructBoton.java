package sistema.bean.struct;

import sistema.ui.Principal;

public class StructBoton {
    private String id;
    private String texto;
    private String funcion = "";

    public StructBoton() {
        id = "";
        texto = "";
        funcion = "";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public StructBoton(String id, String texto) {
        this.id = id;
        this.texto = texto;
    }

    public void insertar(){
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<input type=\"submit\" name=\"" + id + "\" value=\"" + texto + "\"");
        if(!funcion.equals("")){
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  " onClick=\"" + funcion + "()\"");
        }
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  " />\n");
    }

    public void click(String texto){
        funcion = "fnc" + id + "";
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<script>\nfunction " + funcion + "() {\n alert(\"" + texto + "\");\n}\n  </script>\n");
    }
}
