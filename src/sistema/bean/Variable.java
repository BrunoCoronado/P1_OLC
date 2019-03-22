package sistema.bean;

public class Variable {
    private String tipo;
    private String identificador;
    private Object valor;

    public Variable() {
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getIdentificador() {
        return identificador;
    }

    public void setIdentificador(String identificador) {
        this.identificador = identificador;
    }

    public Object getValor() {
        return valor;
    }

    public void setValor(Object valor) {
        this.valor = valor;
    }

    public Variable(String tipo, String identificador, Object valor) {
        this.tipo = tipo;
        this.identificador = identificador;
        this.valor = valor;
    }
}
