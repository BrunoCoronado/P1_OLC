package sistema.ui;

import main.Main;
import sistema.administracion.AdministracionArchivos;
import sistema.analisis.Parser;
import sistema.analisis.Scanner;
import sistema.bean.Token;
import sistema.graficas.ArchivoHTML;
import sistema.graficas.GraficaTokens;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.StringReader;
import java.util.ArrayList;

import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;

public class Principal extends JFrame{
	//declaracion de componenetes visuales
	private JMenuBar menuBar;
	private JMenu menu;
	private JMenuItem menuItem;
	private JTextArea txtEditor, txtConsola, txtVariables;
	private JComboBox<String> cmbReportes;
	private JButton btnReportar;
	private JFileChooser fileChooser;

	AdministracionArchivos administracionArchivos;

	public static ArrayList<Token> tokens;
	public static ArrayList<Token> errores;
	public static ArchivoHTML archivoHTML = new ArchivoHTML();

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
		menu.add(menuItem);
		menuItem = new JMenuItem("Manual Técnico");
		menu.add(menuItem);
		menuItem = new JMenuItem("Acerca de");
		menu.add(menuItem);
		menuBar.add(menu);
		this.setJMenuBar(menuBar);
		//creacion area del editor y salida
		JPanel panelEdicion = new JPanel(new BorderLayout());
		JPanel panelResultados = new JPanel(new FlowLayout(FlowLayout.LEFT));
		JPanel panelConsola = new JPanel(new BorderLayout());
		JPanel panelVariables = new JPanel(new BorderLayout());
		txtEditor = new JTextArea();//apartado para el editor
		JScrollPane scrollEditor = new JScrollPane(txtEditor);
		scrollEditor.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		panelEdicion.add(scrollEditor, BorderLayout.CENTER);
		cmbReportes = new JComboBox();//apartado para los resultados
		cmbReportes.addItem("Página Web");
		cmbReportes.addItem("Análsis Léxico");
		cmbReportes.addItem("Errores Léxicos");
		cmbReportes.addItem("Errores Sintácticos");
		btnReportar = new JButton("Ver Reporte en Navegador");
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
		//creacion de los Tabbed Pane
		JTabbedPane tabbedPaneEditor = new JTabbedPane();
		tabbedPaneEditor.add("Edición", panelEdicion);
		tabbedPaneEditor.add("Resultados", panelResultados);
		JTabbedPane tabbedPaneSalida = new JTabbedPane();
		tabbedPaneSalida.add("Consola", panelConsola);
		tabbedPaneSalida.add("Variables", panelVariables);
		this.add(tabbedPaneEditor, BorderLayout.CENTER);
		this.add(tabbedPaneSalida, BorderLayout.SOUTH);
	}

	private void crearArchivoNuevo(ActionEvent evt){
		try{
			if(fileChooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION){
				this.setTitle(fileChooser.getSelectedFile().getPath());
				administracionArchivos.nuevoArchivo(fileChooser.getSelectedFile().getPath()+".uweb");
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
			StringReader strReader = new StringReader(txtEditor.getText()+ "~");
			Scanner scanner = new Scanner(strReader);
			Parser parser = new Parser(scanner);
			parser.parse();
			GraficaTokens graficarTokens = new GraficaTokens();
			if(errores.size() > 0){
				graficarTokens.graficarListaErrores();
			}
			graficarTokens.graficarListaTokens();
			archivoHTML.crearArchivo();
			archivoHTML.limpiarCodigo();
			errores =  new ArrayList<>();
			tokens =  new ArrayList<>();
		}catch (Exception ex){
			ex.printStackTrace();
		}
	}

	private void inicializarEstructuras(){
		tokens = new ArrayList<>();
		errores = new ArrayList<>();
	}
}
