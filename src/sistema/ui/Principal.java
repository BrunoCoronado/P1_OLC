package sistema.ui;

import main.Main;
import sistema.administracion.AdministracionArchivos;
import sistema.analisis.Parser;
import sistema.analisis.Scanner;
import sistema.bean.Struct;
import sistema.bean.Token;
import sistema.bean.Variable;
import sistema.bean.struct.*;
import sistema.graficas.ArchivoHTML;
import sistema.graficas.GraficaTokens;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.StringReader;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;

public class Principal extends JFrame{
	//declaracion de componenetes visuales
	private JMenuBar menuBar;
	private JMenu menu;
	private JMenuItem menuItem;
	private JTextArea txtEditor;
	public static  JTextArea txtConsola, txtVariables, txtStructs, txtTextoPlano;
	private JComboBox<String> cmbReportes;
	private JButton btnReportar;
	private JFileChooser fileChooser;

	AdministracionArchivos administracionArchivos;

	public static ArrayList<Token> tokens;
	public static ArrayList<Token> errores;
	public static ArrayList<Variable> variables;
	public static ArchivoHTML archivoHTML = new ArchivoHTML();
	public static ArrayList<Struct> structs;


	public Principal(){
		iniciarComponentes();
		inicializarEstructuras();
	}
	
	private void iniciarComponentes() {
		//parametros de la ventana
		this.setSize(1000, 800);
		this.setLayout(new BorderLayout());
		this.setDefaultCloseOperation(this.EXIT_ON_CLOSE);
		//creacion del menu bar
		administracionArchivos = new AdministracionArchivos();
		fileChooser = new JFileChooser();
		FileNameExtensionFilter filtro = new FileNameExtensionFilter(".uweb", "uweb");
		fileChooser.setFileFilter(filtro);
		menuBar = new JMenuBar();
		menu = new JMenu("Menú Archivo");
		menuItem = new JMenuItem("Nuevo Archivo");
		menuItem.addActionListener(e -> {
			crearArchivoNuevo(e);
		});
		menu.add(menuItem);
		menuItem = new JMenuItem("Abrir Archivo");
		menuItem.addActionListener(e -> {
			abrirArchivo(e);
		});
		menu.add(menuItem);
		menuItem = new JMenuItem("Guardar");
		menuItem.addActionListener(e -> {
			guardarArchivo(e, 1);
		});
		menu.add(menuItem);
		menuItem = new JMenuItem("Guardar Como");
		menuItem.addActionListener(e -> {
			guardarArchivo(e, 2);
		});
		menu.add(menuItem);
		menu.addSeparator();
		menuItem = new JMenuItem("Compilar");
		menuItem.addActionListener(e -> {
			compilar(e);
		});
		menu.add(menuItem);
		menuBar.add(menu);
		menu = new JMenu("Menú Ayuda");
		menuItem = new JMenuItem("Manual de Usuario");
		menuItem.addActionListener(e -> {
			manualUsuario(e);
		});
		menu.add(menuItem);
		menuItem = new JMenuItem("Manual Técnico");
		menuItem.addActionListener(e -> {
			manualTecnico(e);
		});
		menu.add(menuItem);
		menuItem = new JMenuItem("Acerca de");
		menuItem.addActionListener(e -> {
			acercaDe(e);
		});
		menu.add(menuItem);
		menuBar.add(menu);
		this.setJMenuBar(menuBar);
		//creacion area del editor y salida
		JPanel panelEdicion = new JPanel(new BorderLayout());
		JPanel panelResultados = new JPanel(new FlowLayout(FlowLayout.LEFT));
		JPanel panelConsola = new JPanel(new BorderLayout());
		JPanel panelVariables = new JPanel(new BorderLayout());
		JPanel panelStructs = new JPanel(new BorderLayout());
		txtEditor = new JTextArea();//apartado para el editor
		JScrollPane scrollEditor = new JScrollPane(txtEditor);
		scrollEditor.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelEdicion.add(scrollEditor, BorderLayout.CENTER);
		cmbReportes = new JComboBox();//apartado para los resultados
		cmbReportes.addItem("Página Web");
		cmbReportes.addItem("Análsis Léxico (Reporte Tokens)");
		cmbReportes.addItem("Errores Léxicos/Sintácticos");
		btnReportar = new JButton("Ver Reporte en Navegador");
		btnReportar.addActionListener(e -> {
			verResultado(e);
		});
		panelResultados.add(cmbReportes);
		panelResultados.add(btnReportar);
		txtConsola = new JTextArea();//apartado para la consola
		txtConsola.setEditable(false);
		txtConsola.setRows(15);
		JScrollPane scrollConsola = new JScrollPane(txtConsola);
		scrollConsola.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelConsola.add(scrollConsola, BorderLayout.CENTER);
		txtVariables = new JTextArea();//apartado para las variables
		txtVariables.setEditable(false);
		txtVariables.setRows(15);
		JScrollPane scrollVariables = new JScrollPane(txtVariables);
		scrollVariables.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelVariables.add(scrollVariables, BorderLayout.CENTER);
		txtStructs = new JTextArea();//apartado para los structs
		txtStructs.setEditable(false);
		txtStructs.setRows(15);
		JScrollPane scrollStructs = new JScrollPane(txtStructs);
		scrollStructs.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelStructs.add(scrollStructs, BorderLayout.CENTER);
		//seccion para ver el texto plano
		JPanel panelTextoPlano = new JPanel(new BorderLayout());
		txtTextoPlano = new JTextArea();
		txtTextoPlano.setEditable(false);
		JScrollPane scrollTextoPlano = new JScrollPane(txtTextoPlano);
		scrollTextoPlano.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelTextoPlano.add(scrollTextoPlano, BorderLayout.CENTER);
		//creacion de los Tabbed Pane
		JTabbedPane tabbedPaneEditor = new JTabbedPane();
		tabbedPaneEditor.add("Edición", panelEdicion);
		tabbedPaneEditor.add("Resultados", panelResultados);
		tabbedPaneEditor.add("Texto Plano", panelTextoPlano);
		JTabbedPane tabbedPaneSalida = new JTabbedPane();
		tabbedPaneSalida.add("Consola", panelConsola);
		tabbedPaneSalida.add("Variables", panelVariables);
		tabbedPaneSalida.add("Structs", panelStructs);
		this.add(tabbedPaneEditor, BorderLayout.CENTER);
		this.add(tabbedPaneSalida, BorderLayout.SOUTH);
	}

	private void crearArchivoNuevo(ActionEvent evt){
		try{
			if(fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION){
				this.setTitle(fileChooser.getSelectedFile().getPath());
				administracionArchivos.nuevoArchivo(fileChooser.getSelectedFile().getPath()+".uweb");
				txtEditor.setText("");
			}
		}catch (Exception ex){
			System.err.println("ERROR AL CREAR ARCHIVO");
			ex.printStackTrace();
		}
	}

	private void abrirArchivo(ActionEvent evt){
		try{
			if(fileChooser.showOpenDialog(this) == JFileChooser.APPROVE_OPTION){
				this.setTitle(fileChooser.getSelectedFile().getPath());
				txtEditor.setText(administracionArchivos.abrirArchivo(fileChooser.getSelectedFile().getPath()));
			}
		}catch (Exception ex){
			System.err.println("ERROR AL ABRIR ARCHIVO");
			ex.printStackTrace();
		}
	}

	private void guardarArchivo(ActionEvent evt, int tipo){
		try{
			switch (tipo){
				case 1:
					if(!this.getTitle().equals(""))
						administracionArchivos.guardarArchivo(this.getTitle() + ".uweb", txtEditor.getText(), tipo);
					else
						JOptionPane.showMessageDialog(this, "No existe referencia a un archivo", "Error al Guardar", JOptionPane.WARNING_MESSAGE);
					break;
				case 2:
					if(fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION){
						this.setTitle(fileChooser.getSelectedFile().getPath());
						administracionArchivos.guardarArchivo(fileChooser.getSelectedFile().getPath() + ".uweb", txtEditor.getText(), tipo);
					}
					break;
			}
		}catch (Exception ex){
			System.err.println("ERROR AL GUARDAR ARCHIVO");
			ex.printStackTrace();
		}
	}

	private void compilar(ActionEvent evt){
		try{
			archivoHTML.limpiarCodigo();
			inicializarEstructuras();
			StringReader strReader = new StringReader(txtEditor.getText()+ "~");
			Scanner scanner = new Scanner(strReader);
			Parser parser = new Parser(scanner);
			parser.parse();
			if(errores.size() > 0)
				JOptionPane.showMessageDialog(this, "SE ENCONTRARON " + errores.size() + " ERRORES", "ERROR", JOptionPane.ERROR_MESSAGE);
			txtTextoPlano.setText(archivoHTML.getCodigoHTML());
		}catch (Exception ex){
			ex.printStackTrace();
		}
	}

	private void verResultado(ActionEvent evt){
		switch (cmbReportes.getSelectedIndex()){
			case 0:
				if(!archivoHTML.getCodigoHTML().equals("<!DOCTYPE html>\n<html>\n")){
					if(errores.size() > 0)
						JOptionPane.showMessageDialog(this, "SE ENCONTRARON ERRORES", "ERROR", JOptionPane.ERROR_MESSAGE);
					else
						archivoHTML.crearArchivo();

				}else
					JOptionPane.showMessageDialog(this, "NO EXISTE CONTENIDO HTML", "ERROR", JOptionPane.WARNING_MESSAGE);
				break;
			case 1:
				if(tokens.size() > 0){
					if(errores.size() > 0)
						JOptionPane.showMessageDialog(this, "SE ENCONTRARON ERRORES", "ERROR", JOptionPane.ERROR_MESSAGE);
					else{
						GraficaTokens graficarTokens = new GraficaTokens();
						graficarTokens.graficarListaTokens();
					}
				}else
					JOptionPane.showMessageDialog(this, "NO EXISTE CONTENIDO", "ERROR", JOptionPane.WARNING_MESSAGE);
				break;
			case 2:
					if(errores.size() > 0) {
						GraficaTokens graficarTokens = new GraficaTokens();
						graficarTokens.graficarListaErrores();
					}else
						JOptionPane.showMessageDialog(this, "NO EXISTE CONTENIDO", "ERROR", JOptionPane.WARNING_MESSAGE);
				break;
		}
	}

	private void manualUsuario(ActionEvent evt){
		try {
			String [] comando = {"bash","xdg-open", "manualUsuario.pdf" };
			Runtime.getRuntime().exec(comando);
		} catch (Exception ex) {
			System.out.println("Error abriendo manual");
		}
	}

	private void manualTecnico(ActionEvent evt){
		try {
			String [] comando = {"bash","xdg-open", "manualTecnico.pdf" };
			Runtime.getRuntime().exec(comando);
		} catch (Exception ex) {
			System.out.println("Error abriendo manual");
		}
	}

	private void acercaDe(ActionEvent evt){
		JOptionPane.showMessageDialog(this, " Bruno Coronado \n 201709362 \n OLC1 \n USAC", "Acerca de", JOptionPane.INFORMATION_MESSAGE);
	}

	private void inicializarEstructuras(){
		tokens = new ArrayList<>();
		errores = new ArrayList<>();
		variables = new ArrayList<>();
		archivoHTML.limpiarCodigo();
		structs= new ArrayList<>();
		txtVariables.setText("");
		txtConsola.setText("");
		txtStructs.setText("");
	}

	public static String retornarValorCadenaVariable(String identificador){
		for (Variable var: variables) {
			if(var.getIdentificador().equals(identificador)){
				switch (var.getTipo()){
					case "cadena":
						return var.getValor().toString();
					case "decimal":
						return truncateDecimal((Double)var.getValor(), 3).toString();
					case "entero":
						return var.getValor().toString();
					case "booleano":
						return Boolean.valueOf(var.getValor().toString()).toString();
				}
			}
		}
		Principal.errores.add(new Token(identificador, "ERROR SINTACTICO - NO ENCONTRADO",0,0));
		return "";
	}

	public static  Variable retornarVariable(String identificador){
		for (Variable var: variables) {
			if(var.getIdentificador().equals(identificador))
				return  var;
		}
		Principal.errores.add(new Token(identificador, "ERROR SINTACTICO - NO ENCONTRADO",0,0));
		return null;
	}

	private static BigDecimal truncateDecimal(double x, int decimales){
		if ( x > 0)
			return new BigDecimal(String.valueOf(x)).setScale(decimales, BigDecimal.ROUND_FLOOR);
		else
			return new BigDecimal(String.valueOf(x)).setScale(decimales, BigDecimal.ROUND_CEILING);
	}

	public static Struct retornarStruct(String identificador){
		for (Struct struct : structs) {
			if(struct.getIdentificador().equals(identificador))
				return struct;
		}
		Principal.errores.add(new Token(identificador, "ERROR SINTACTICO - NO ENCONTRADO",0,0));
		return null;
	}

	public static int indiceStruct(String identificador){
		for (int i = 0; i < structs.size(); i++) {
			if(structs.get(i).getIdentificador().equals(identificador))
				return i;
		}
		return -1;
	}

	public static int actualizarVariable(String identificador, Object valor){
		for (int i = 0; i < variables.size(); i++) {
			if(variables.get(i).getIdentificador().equals(identificador)){
				variables.get(i).setValor(valor);
				return 1;
			}
		}
		return 0;
	}
}
