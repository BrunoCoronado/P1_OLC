package sistema.bean.sentencias;

import sistema.ui.Principal;

import java.util.ArrayList;

public class SentenciaFor {
    private ArrayList<String> ejecuciones;
    private int repeticiones;

    public SentenciaFor() {
        ejecuciones = new ArrayList<>();
        repeticiones = 0;
    }

    public ArrayList<String> getEjecuciones() {
        return ejecuciones;
    }

    public void setEjecuciones(String ejecucion) {
        this.ejecuciones.add(ejecucion);
    }

    public void ejecutarSentencia(){
        for (int i = 0; i < repeticiones; i++) {
            for (String codigoHtml: ejecuciones) {
                Principal.archivoHTML.setCodigoHTML(Principal.archivoHTML.getCodigoHTML() + "\'n" + codigoHtml + "\n");
            }
        }
    }
}
