package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Conquistado {
	
	private int 	idConquistado;
	private int		idConquista;
	private int		idUsuario;
	private String  aquisicao;
	
	private String	tableName = "forum.conquistado";
	private String	fieldsName = "idConquistado, idConquista, idUsuario, aquisicao";
	private String	keyField = "idConquistado";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Conquistado() {
	}
	
	public Conquistado(String idConquistado) {
		this.setIdConquistado(((idConquistado == null)?0:Integer.valueOf(idConquistado)));
	}
	
	public Conquistado(int idConquistado, int idConquista, int idUsuario, String aquisicao) {	
		this.setIdConquistado(idConquistado);
		this.setIdConquista(idConquista);
		this.setIdUsuario(idUsuario);
		this.setAquisicao(aquisicao);
	}
	
	public Conquistado(String idConquistado, String idConquista, String idUsuario, String aquisicao) {	
		this.setIdConquistado(((idConquistado == null)?0:Integer.valueOf(idConquistado)));
		this.setIdConquista(((idConquista == null)?0:Integer.valueOf(idConquista)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setAquisicao(aquisicao);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdConquistado(),
					""+this.getIdConquista(),
					""+this.getIdUsuario(),
					""+this.getAquisicao()
			}
		);
	}
	
	public void save() {
		if ((this.getIdConquistado() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdConquistado() > 0) {
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
			ResultSet resultSet = this.select("aquisicao ='"+ this.getAquisicao() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idConquistado");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}

	public int getIdConquistado() {
		return idConquistado;
	}

	public void setIdConquistado(int idConquistado) {
		this.idConquistado = idConquistado;
	}

	public int getIdConquista() {
		return idConquista;
	}

	public void setIdConquista(int idConquista) {
		this.idConquista = idConquista;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getAquisicao() {
		return aquisicao;
	}

	public void setAquisicao(String aquisicao) {
		this.aquisicao = aquisicao;
	}	
}
