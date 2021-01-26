package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class NivelUsuarios {
	
	private int 	idNivelUsuario;
	private String	nivel;
	
	private String	tableName = "forum.nivelusuarios";
	private String	fieldsName = "idNivelUsuario, nivel";
	private String	keyField = "idNivelUsuario";
	
	//private String	where = "";
	private DBQuery	dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public NivelUsuarios() {
	}
	
	public NivelUsuarios(String idNivelUsuario) {
		this.setIdNivelUsuario(((idNivelUsuario == null)?0:Integer.valueOf(idNivelUsuario)));
	}
	
	public NivelUsuarios(int idNivelUsuario, String nivel) {
		this.setIdNivelUsuario(idNivelUsuario);
		this.setNivel(nivel);
	}
	
	public NivelUsuarios(String idNivelUsuario, String nivel) {
		this.setIdNivelUsuario(((idNivelUsuario == null)?0:Integer.valueOf(idNivelUsuario)));
		this.setNivel(nivel);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdNivelUsuario(),
					""+this.getNivel()
			}
		);
	}
	
	public void save() {
		if ((this.getIdNivelUsuario() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdNivelUsuario() > 0) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public String listAll() {
		ResultSet rs = this.dbQuery.select("");
		String saida = "<tbody>";
		
		try {
			while (rs.next()) {
				saida += "<tr>";
				saida += "<td>" + rs.getString("idNivelUsuario") + "</td>";
				saida += "<td>" + rs.getString("nivel") + "</td>";
				saida += "<td> <div class='float-right'> <a class='btn btn-info' href='alterarNivelUsuario.jsp?id=" +  rs.getString("idNivelUsuario") + "'>Alterar</a>";
				saida += "<a class='btn btn-danger' href='deletarNivelUsuario.jsp?id=" + rs.getString("idNivelUsuario") + "'>Deletar</a> </div> </td>";
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
			ResultSet resultSet = this.select("nivel='"+ this.getNivel() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idNivelUsuario");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}
	
	public int getIdNivelUsuario() {
		return idNivelUsuario;
	}
	public void setIdNivelUsuario(int idNivelUsuario) {
		this.idNivelUsuario = idNivelUsuario;
	}
	public String getNivel() {
		return nivel;
	}
	public void setNivel(String nivel) {
		this.nivel = nivel;
	}
	
}
