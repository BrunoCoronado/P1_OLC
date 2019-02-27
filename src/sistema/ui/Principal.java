package sistema.ui;

import java.awt.BorderLayout;
import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;

public class Principal extends JFrame{
	//declaracion de componenetes visuales
	JMenuBar menuBar;
	JMenu menu;
	JMenuItem menuItem;
	JTextArea txtEditor, txtConsola, txtVariables;
	JComboBox<String> cmbReportes;
	JButton btnReportar;
	
	public Principal(){
		iniciarComponentes();
	}
	
	private void iniciarComponentes() {
		//parametros de la ventana
		this.setSize(1000, 800);
		this.setLayout(new BorderLayout());
		this.setDefaultCloseOperation(this.EXIT_ON_CLOSE);
		//creacion del menu bar
		menuBar = new JMenuBar();
		menu = new JMenu("Menú Archivo");
		menuItem = new JMenuItem("Nuevo Archivo");
		menu.add(menuItem);
		menuItem = new JMenuItem("Abrir Archivo");
		menu.add(menuItem);
		menuItem = new JMenuItem("Guardar");
		menu.add(menuItem);
		menuItem = new JMenuItem("Guardar Como");
		menu.add(menuItem);
		menu.addSeparator();
		menuItem = new JMenuItem("Compilar");
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
}
