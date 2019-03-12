package main;

import java.util.ArrayList;

import sistema.bean.Token;
import sistema.ui.Principal;

public class Main {
	public static ArrayList<Token> tokens;
	public static ArrayList<Token> errores;

	public static void main(String[] args) {
		Principal principal = new Principal();
		principal.setVisible(true);
	}

}
