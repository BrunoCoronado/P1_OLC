package sistema.bean.struct.tabla;

import java.util.ArrayList;

public class FilaTabla {
    private ArrayList<String> columnas;

    public FilaTabla() {
        columnas = new ArrayList<>();
    }

    public ArrayList<String> getColumnas() {
        return columnas;
    }

    public void setColumnas(String valor) {
        this.columnas.add(valor);
    }
}
