package sistema.graficas;

import java.io.BufferedWriter;
import java.io.FileWriter;

public class ArchivoHTML {
    private static  String codigoHTML;

    public  ArchivoHTML(){
        codigoHTML = "";
        iniciarPagina();
    }

    public void limpiarCodigo(){
        codigoHTML = "";
        iniciarPagina();
    }

    public void iniciarPagina(){
        codigoHTML += "<!DOCTYPE html>\n<html>\n";
    }

    public void finalizarPagina(){
        codigoHTML += "</html>\n";
    }

    public void iniciarHead(){
        codigoHTML += "<head>\n";
    }

    public void finalizarHead(){
        codigoHTML += "</head>\n";
    }

    public void escribirTitulo(String titulo){
        codigoHTML += "<title"+titulo+"/title>\n";
    }

    public void iniciarBody(){
        codigoHTML += "<body ";
    }

    public void cerrarEtiquetaInicialBody(){
        codigoHTML += ">\n";
    }

    public void finalizarBody(){
        codigoHTML += "</body>\n";
    }

    public void agregarBGColor(String color){
        codigoHTML += "bgcolor=\""+color+"\" ";
    }

    public void iniciarDiv(){
        codigoHTML += "<div>\n";
    }

    public void finalizarDiv(){
        codigoHTML += "</div>\n";
    }

    public void iniciarParrafo(){
        codigoHTML += "<p ";
    }

    public void finalizarParrafo(){
        codigoHTML += "/p>\n";
    }

    public void agregarAlineacion(String alineacion){
        codigoHTML += "align=" + traducirAlineacion(alineacion) + " ";
    }

    public void agregarTextoParrafo(String texto){
        codigoHTML += texto;
    }

    public void agreagarSalto(String salto){
        codigoHTML += salto;
    }

    public void iniciarH1(){
        codigoHTML += "<h1";
    }

    public void finalizarH1(){
        codigoHTML += "/h1>\n";
    }

    public void agregarTextoH1(String texto){
        codigoHTML += texto;
    }

    public void iniciarH2(){
        codigoHTML += "<h2";
    }

    public void finalizarH2(){
        codigoHTML += "/h2>\n";
    }

    public void agregarTextoH2(String texto){
        codigoHTML += texto;
    }

    public void iniciarImagen(){
        codigoHTML += "<img ";
    }

    public void finalizarImagen(){
        codigoHTML += ">\n";
    }

    public void agregarPathImagen(String path){
        codigoHTML += " src=\""+path+"\"";
    }

    public void agregarAltoImagen(String alto){
        codigoHTML += " height=\""+alto+"\"";
    }

    public void agregarAnchoImagen(String ancho){
        codigoHTML += " width=\""+ancho+"\"";
    }

    public void iniciarBoton(){
        codigoHTML += "<input type=\"submit\" ";
    }

    public void finalizarBoton(){
        codigoHTML += ">\n";
    }

    public void agregarId(String id){
        codigoHTML += " name=\""+id+"\"";
    }

    public void agregarTexto(String texto){
        codigoHTML += " value=\""+texto+"\"";
    }

    public void agregarTextoEntreEtiquetas(String texto){
        codigoHTML += texto+"\n";
    }

    public void  iniciarTabla(){
        codigoHTML += "<table style=\"width:100%\" ";
    }

    public void finalizarTabla(){
        codigoHTML += "</table>\n";
    }

    public void agregarBorde(String valor){
        codigoHTML += "border=\""+((valor.toLowerCase().equals("true"))?"1":"0")+"\"";
    }

    public void cerrarEtiquetaTabla(){
        codigoHTML += ">\n";
    }

    public void iniciarFila(){
        codigoHTML += "<tr>\n";
    }

    public void finalizarFila(){
        codigoHTML += "</tr>\n";
    }

    public void iniciarColumnaC(){
        codigoHTML += "<td><b>";
    }

    public void finalizarColumnaC(){
        codigoHTML += "</b></td>\n";
    }

    public void iniciarColumna(){
        codigoHTML += "<td>";
    }

    public void finalizarColumna(){
        codigoHTML += "</td>\n";
    }

    public void crearArchivo(){
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter("pagina.html", false));
            writer.write(codigoHTML);
            writer.close();
            String [] comando = {"bash","xdg-open", "pagina.html" };
            Runtime.getRuntime().exec(comando);
        } catch (Exception ex) {
            System.out.println("Error Escribiendo Pagina HTML...");
        }
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
