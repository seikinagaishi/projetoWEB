package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Comentario {
	
	private int		idComentario;
	private int 	idTopico;
	private int		idUsuario;
	private String 	mensagem;
	private String 	data;
	
	private String	tableName = "forum.comentario";
	private String	fieldsName = "idComentario, idTopico, idUsuario, mensagem, data";
	private String	keyField = "idComentario";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Comentario() {
	}
	
	public Comentario(String idComentario) {
		this.setIdComentario(((idComentario == null)?0:Integer.valueOf(idComentario)));
	}
	
	public Comentario(int idComentario, int idTopico, int idUsuario, String mensagem, String data) {	
		this.setIdComentario(idComentario);
		this.setIdTopico(idTopico);
		this.setIdUsuario(idUsuario);
		this.setMensagem(mensagem);
		this.setData(data);
	}
	
	public Comentario(String idComentario, String idTopico, String idUsuario, String mensagem, String data) {	
		this.setIdComentario(((idComentario == null)?0:Integer.valueOf(idComentario)));
		this.setIdTopico(((idTopico == null)?0:Integer.valueOf(idTopico)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setMensagem(mensagem);
		this.setData(data);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdComentario(),
					""+this.getIdTopico(),
					""+this.getIdUsuario(),
					""+this.getMensagem(),
					""+this.getData()
			}
		);
	}
	
	public void save() {
		if ((this.getIdComentario() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdComentario() > 0) {
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

	public int getIdComentario() {
		return idComentario;
	}

	public void setIdComentario(int idComentario) {
		this.idComentario = idComentario;
	}

	public int getIdTopico() {
		return idTopico;
	}

	public void setIdTopico(int idTopico) {
		this.idTopico = idTopico;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getMensagem() {
		return mensagem;
	}

	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}
