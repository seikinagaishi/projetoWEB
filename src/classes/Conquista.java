package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Conquista {
	
	private int 	idConquista;
	private String	nome;
	private String  descricao;
	
	private String	tableName = "forum.conquista";
	private String	fieldsName = "idConquista, nome, descricao";
	private String	keyField = "idConquista";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Conquista() {
	}
	
	public Conquista(String idConquista) {
		this.setIdConquista(((idConquista == null)?0:Integer.valueOf(idConquista)));
	}
	
	public Conquista(int idConquista, String nome, String descricao) {	
		this.setIdConquista(idConquista);
		this.setNome(nome);
		this.setDescricao(descricao);
	}
	
	public Conquista(String idConquista, String nome, String descricao) {
		this.setIdConquista(((idConquista == null)?0:Integer.valueOf(idConquista)));
		this.setNome(nome);
		this.setDescricao(descricao);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdConquista(),
					""+this.getNome(),
					""+this.getDescricao()
			}
		);
	}
	
	public void save() {
		if ((this.getIdConquista() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdConquista() > 0) {
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
				saida += "<td> <div class='float-right'> <a class='btn btn-info' href='alterarCategoria.jsp?id=" +  rs.getString("idCategoria") + "'>Alterar</a>";
				saida += "<a class='btn btn-danger' href='deletarCategoria.jsp?id=" + rs.getString("idCategoria") + "'>Deletar</a> </div> </td>";
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
	
	public boolean check() {
		int id = 0;
		try {
			ResultSet resultSet = this.select("nome ='"+ this.getNome() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idConquista");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}

	public int getIdConquista() {
		return idConquista;
	}

	public void setIdConquista(int idConquista) {
		this.idConquista = idConquista;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	
}
