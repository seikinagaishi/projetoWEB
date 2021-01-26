package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Likes {
	
	private int 	idLike;
	private int		idTopico;
	private int		idComentario;
	private int 	idUsuario;
	private int 	tipo;
	private String  data;
	
	private String	tableName = "forum.likes";
	private String	fieldsName = "idLike, idTopico, idComentario, idUsuario, tipo, data";
	private String	keyField = "idLike";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Likes() {
	}
	
	public Likes(String idLike) {
		this.setIdLike(((idLike == null)?0:Integer.valueOf(idLike)));
	}
	
	public Likes(int idLike, int idTopico, int idComentario, int idUsuario, int tipo, String data) {	
		this.setIdLike(idLike);
		this.setIdTopico(idTopico);
		this.setIdComentario(idComentario);
		this.setIdUsuario(idUsuario);
		this.setTipo(tipo);
		this.setData(data);
	}
	
	public Likes(String idLike, String idTopico, String idComentario, String idUsuario, String tipo, String data) {	
		this.setIdLike(((idLike == null)?0:Integer.valueOf(idLike)));
		this.setIdTopico(((idTopico == null)?0:Integer.valueOf(idTopico)));
		this.setIdComentario(((idComentario == null)?0:Integer.valueOf(idComentario)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setTipo(((tipo == null)?0:Integer.valueOf(tipo)));
		this.setData(data);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdLike(),
					""+this.getIdTopico(),
					""+this.getIdComentario(),
					""+this.getIdUsuario(),
					""+this.getTipo(),
					""+this.getData()
			}
		);
	}
	
	public void save() {
		if ((this.getIdLike() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdLike() > 0) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public String listAll() {
		ResultSet rs = this.dbQuery.select("");
		String saida = "<tbody>";
		try {
			while (rs.next()) {
				saida += "<tr>";
				saida += "<td>" + rs.getString("") + "</td>";
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
	
	public ResultSet selectCount( String where ) {
		ResultSet resultset = this.dbQuery.selectCount(where);
		return(resultset);
	}
	
	public ResultSet selectCountGroup( String className ) {
		ResultSet resultset = this.dbQuery.selectCountGroup(className);
		return(resultset);
	}

	public int getIdLike() {
		return idLike;
	}

	public void setIdLike(int idLike) {
		this.idLike = idLike;
	}

	public int getIdTopico() {
		return idTopico;
	}

	public void setIdTopico(int idTopico) {
		this.idTopico = idTopico;
	}

	public int getIdComentario() {
		return idComentario;
	}

	public void setIdComentario(int idComentario) {
		this.idComentario = idComentario;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}
