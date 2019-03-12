package sistema.administracion;

import java.io.*;
import java.util.Objects;

public class AdministracionArchivos {

    public String abrirArchivo(String ruta){
        try {
            BufferedReader reader = new BufferedReader(new FileReader(ruta));
            String texto = "";
            String linea = reader.readLine();
            while(linea != null){
                texto += linea + "\n";
                linea = reader.readLine();
            }
            reader.close();
            return  texto;
        }catch (Exception ex){
            System.err.println("ERROR AL ABRIR ARCHIVO");
            ex.printStackTrace();
        }
        return "";
    }

    public void guardarArchivo(String ruta, String texto, int tipo){
        try {
            BufferedWriter writer;
            if(tipo == 1)
                writer = new BufferedWriter(new FileWriter(ruta, true));
            else
                writer = new BufferedWriter(new FileWriter(ruta, false));
            writer.write(texto);
            writer.close();
        }catch (Exception ex){
            System.err.println("ERROR AL GUARDAR EL ARCHIVO");
            ex.printStackTrace();
        }
    }

    public void nuevoArchivo(String ruta){
        try {
            File archivo = new File(ruta);
            archivo.createNewFile();
        }catch (Exception ex){
            System.err.println("ERROR AL CREAR NUEVO ARCHIVO");
            ex.printStackTrace();
        }
    }
}
