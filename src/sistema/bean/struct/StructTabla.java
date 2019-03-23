package sistema.bean.struct;

import sistema.bean.struct.tabla.FilaTabla;
import sistema.ui.Principal;

import java.util.ArrayList;

public class StructTabla {
    private ArrayList<FilaTabla> filas;
    private String borde;
    private FilaTabla fila;

    public StructTabla() {
        filas = new ArrayList<>();
        borde = "";
    }

    public ArrayList<FilaTabla> getFilas() {
        return filas;
    }

    public void setFilas(FilaTabla fila) {
        this.filas.add(fila);
    }

    public String getBorde() {
        return borde;
    }

    public void setBorde(String borde) {
        this.borde = borde;
    }

    public void crearFila(){
        fila = new FilaTabla();
    }

    public void agregarElementoAFila(String elemento){
        fila.setColumnas(elemento);
    }

    public void agregarFila(){
        this.filas.add(this.fila);
    }

    public void insertar(){
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "\n<table style=\"width:100%\" ");
        if(!borde.equals("")){
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "border=\""+((borde.toLowerCase().equals("true"))?"1":"0")+"\"");
        }
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  ">\n");
        for (FilaTabla fila: filas) {
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "<tr>\n");
            for (String columna: fila.getColumnas()) {
                Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "<td>" + columna + "</td>");
            }
            Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "</tr>\n");
        }
        Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() +  "</table>\n");
    }
}
