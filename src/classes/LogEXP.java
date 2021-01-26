package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class LogEXP {
	
	private int 	idLogEXP;
	private int		idUsuario;
	private int		qtd;
	private String 	data;
	
	private String	tableName = "forum.logexp";
	private String	fieldsName = "idLogEXP, idUsuario, qtd, data";
	private String	keyField = "idLogEXP";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public LogEXP() {
	}
	
	public LogEXP(String idLogEXP) {
		this.setIdLogEXP(((idLogEXP == null)?0:Integer.valueOf(idLogEXP)));
	}
	
	public LogEXP(int idLogEXP, int idUsuario, int qtd, String data) {	
		this.setIdLogEXP(idLogEXP);
		this.setIdUsuario(idUsuario);
		this.setQtd(qtd);
		this.setData(data);
	}
	
	public LogEXP(String idLogEXP, String idUsuario, String qtd, String data) {	
		this.setIdLogEXP(((idLogEXP == null)?0:Integer.valueOf(idLogEXP)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setQtd(((qtd == null)?0:Integer.valueOf(qtd)));
		this.setData(data);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdLogEXP(),
					""+this.getIdUsuario(),
					""+this.getQtd(),
					""+this.getData()
			}
		);
	}
	
	public void save() {
		if ((this.getIdLogEXP() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdLogEXP() > 0) {
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

	public int getIdLogEXP() {
		return idLogEXP;
	}

	public void setIdLogEXP(int idLogEXP) {
		this.idLogEXP = idLogEXP;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getQtd() {
		return qtd;
	}

	public void setQtd(int qtd) {
		this.qtd = qtd;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}
