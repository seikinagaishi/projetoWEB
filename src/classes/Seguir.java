package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Seguir {
	
	private int 	idSeguir;
	private int		idUsuario;
	private int		idSeguido;
	
	private String	tableName = "forum.seguir";
	private String	fieldsName = "idSeguir, idUsuario, idSeguido";
	private String	keyField = "idSeguir";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Seguir() {
	}
	
	public Seguir(String idSeguir) {
		this.setIdSeguir(((idSeguir == null)?0:Integer.valueOf(idSeguir)));
	}
	
	public Seguir(int idSeguir, int idUsuario, int idSeguido) {	
		this.setIdSeguir(idSeguir);
		this.setIdUsuario(idUsuario);
		this.setIdSeguido(idSeguido);
	}
	
	public Seguir(String idSeguir, String idUsuario, String idSeguido) {
		this.setIdSeguir(((idSeguir == null)?0:Integer.valueOf(idSeguir)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setIdSeguido(((idSeguido == null)?0:Integer.valueOf(idSeguido)));
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdSeguir(),
					""+this.getIdUsuario(),
					""+this.getIdSeguido()
			}
		);
	}
	
	public void save() {
		if ((this.getIdSeguir() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdSeguir() > 0) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public String listAll() {
		ResultSet rs = this.dbQuery.select("");
		String saida = "<tbody>";
		try {
			while (rs.next()) {
				saida += "<tr>";
				saida += "</tr>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		saida += "</tbody>";
		return (saida);
	}
	
	public ResultSet select( String where ) {
		ResultSet resultset = this.dbQuery.select(where);
		return(resultset);
	}
	
	public int getIdSeguir() {
		return idSeguir;
	}
	public void setIdSeguir(int idSeguir) {
		this.idSeguir = idSeguir;
	}
	
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	
	public int getIdSeguido() {
		return idSeguido;
	}
	public void setIdSeguido(int idSeguido) {
		this.idSeguido = idSeguido;
	}
	
}
