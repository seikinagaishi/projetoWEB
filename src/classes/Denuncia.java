package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Denuncia {
	
	private int 	idDenuncia;
	private int		idUsuario;
	private int 	idDenunciado;
	private int		tipo;
	private String  descricao;
	
	private String	tableName = "forum.denuncia";
	private String	fieldsName = "idDenuncia, idUsuario, idDenunciado, tipo, descricao";
	private String	keyField = "idDenuncia";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Denuncia() {
	}
	
	public Denuncia(String idDenuncia) {
		this.setIdDenuncia(((idDenuncia == null)?0:Integer.valueOf(idDenuncia)));
	}
	
	public Denuncia(int idDenuncia, int idUsuario, int idDenunciado, int tipo, String descricao) {	
		this.setIdDenuncia(idDenuncia);
		this.setIdUsuario(idUsuario);
		this.setIdDenunciado(idDenunciado);
		this.setTipo(tipo);
		this.setDescricao(descricao);
	}
	
	public Denuncia(String idDenuncia, String idUsuario, String idDenunciado, String tipo, String descricao) {	
		this.setIdDenuncia(((idDenuncia == null)?0:Integer.valueOf(idDenuncia)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setIdDenunciado(((idDenunciado == null)?0:Integer.valueOf(idDenunciado)));
		this.setTipo(((tipo == null)?0:Integer.valueOf(tipo)));
		this.setDescricao(descricao);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdDenuncia(),
					""+this.getIdUsuario(),
					""+this.getIdDenunciado(),
					""+this.getTipo(),
					""+this.getDescricao()
			}
		);
	}
	
	public void save() {
		if ((this.getIdDenuncia() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdDenuncia() > 0) {
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

	public int getIdDenuncia() {
		return idDenuncia;
	}

	public void setIdDenuncia(int idDenuncia) {
		this.idDenuncia = idDenuncia;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getIdDenunciado() {
		return idDenunciado;
	}

	public void setIdDenunciado(int idDenunciado) {
		this.idDenunciado = idDenunciado;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
