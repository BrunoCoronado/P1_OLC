package sistema.ui;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

public class Principal extends JFrame{
	//declaracion de componenetes visuales
	JMenuBar menuBar;
	JMenu menu, subMenu;
	JMenuItem menuItem;

	public Principal(){
		iniciarComponentes();
	}
	
	private void iniciarComponentes() {
		//parametros de la ventana
		this.setSize(800, 800);
		//creacion del menu bar
		menuBar = new JMenuBar();
		menu = new JMenu("menu A");
		menuItem = new JMenuItem("menu item A");
		menu.add(menuItem);
		menuItem = new JMenuItem("menu item B");
		menu.add(menuItem);
		menuItem = new JMenuItem("menu item C");
		menu.add(menuItem);
		menu.addSeparator();
		subMenu = new JMenu("sub menu");
		menuItem = new JMenuItem("menu item A");
		subMenu.add(menuItem);
		menuItem = new JMenuItem("menu item B");
		subMenu.add(menuItem);
		menuItem = new JMenuItem("menu item C");
		subMenu.add(menuItem);
		menu.add(subMenu);
		menuBar.add(menu);
		this.setJMenuBar(menuBar);
	}
}
