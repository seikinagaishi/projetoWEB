package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Topico {
	
	private int 	idTopico;
	private int		idUsuario;
	private int		idCategoria;
	private String  titulo;
	private String 	mensagem;
	private String 	data;
	
	private String	tableName = "forum.topico";
	private String	fieldsName = "idTopico, idUsuario, idCategoria, titulo, mensagem, data";
	private String	keyField = "idTopico";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Topico() {
	}
	
	public Topico(String idTopico) {
		this.setIdTopico(((idTopico == null)?0:Integer.valueOf(idTopico)));
	}
	
	public Topico(int idTopico, int idUsuario, int idCategoria, String titulo, String mensagem, String data) {	
		this.setIdTopico(idTopico);
		this.setIdUsuario(idUsuario);
		this.setIdCategoria(idCategoria);
		this.setTitulo(titulo);
		this.setMensagem(mensagem);
		this.setData(data);
	}
	
	public Topico(String idTopico, String idUsuario, String idCategoria, String titulo, String mensagem, String data) {
		this.setIdTopico(((idTopico == null)?0:Integer.valueOf(idTopico)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setIdCategoria(((idCategoria == null)?0:Integer.valueOf(idCategoria)));
		this.setTitulo(titulo);
		this.setMensagem(mensagem);
		this.setData(data);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdTopico(),
					""+this.getIdUsuario(),
					""+this.getIdCategoria(),
					""+this.getTitulo(),
					""+this.getMensagem(),
					""+this.getData()
			}
		);
	}
	
	public void save() {
		if ((this.getIdTopico() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdTopico() > 0) {
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
	
	public ResultSet selectCondition( String condition ) {
		ResultSet resultset = this.dbQuery.selectCondition(condition);
		return(resultset);
	}
	
	public boolean check() {
		int id = 0;
		try {
			ResultSet resultSet = this.select("data ='"+ this.getData() + "' AND mensagem ='" + this.getMensagem() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idTopico");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
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
	
	public int getIdCategoria() {
		return idCategoria;
	}

	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
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
