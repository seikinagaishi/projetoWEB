package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Categoria {
	
	private int 	idCategoria;
	private String	descricao;
	
	private String	tableName = "forum.categoria";
	private String	fieldsName = "idCategoria, descricao";
	private String	keyField = "idCategoria";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Categoria() {
	}
	
	public Categoria(String idCategoria) {
		this.setIdCategoria(((idCategoria == null)?0:Integer.valueOf(idCategoria)));
	}
	
	public Categoria(int idCategoria, String descricao) {	
		this.setIdCategoria(idCategoria);
		this.setDescricao(descricao);
	}
	
	public Categoria(String idCategoria, String descricao) {
		this.setIdCategoria(((idCategoria == null)?0:Integer.valueOf(idCategoria)));
		this.setDescricao(descricao);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdCategoria(),
					""+this.getDescricao()
			}
		);
	}
	
	public void save() {
		if ((this.getIdCategoria() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdCategoria() > 0) {
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
	
	public boolean check() {
		int id = 0;
		try {
			ResultSet resultSet = this.select("descricao='"+ this.getDescricao() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idCategoria");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}
	
	public int getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}
