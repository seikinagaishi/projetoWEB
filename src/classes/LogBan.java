package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class LogBan {
	
	private int 	idLogBan;
	private int		idUsuario;
	private String  descricao;
	private String 	dataBan;
	
	private String	tableName = "forum.logban";
	private String	fieldsName = "idLogBan, idUsuario, descricao, dataBan";
	private String	keyField = "idLogBan";

	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public LogBan() {
	}
	
	public LogBan(String idLogBan) {
		this.setIdLogBan(((idLogBan == null)?0:Integer.valueOf(idLogBan)));
	}
	
	public LogBan(int idLogBan, int idUsuario, String descricao, String dataBan) {	
		this.setIdLogBan(idLogBan);
		this.setIdUsuario(idUsuario);
		this.setDescricao(descricao);
		this.setDataBan(dataBan);
	}
	
	public LogBan(String idLogBan, String idUsuario, String descricao, String dataBan) {	
		this.setIdLogBan(((idLogBan == null)?0:Integer.valueOf(idLogBan)));
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setDescricao(descricao);
		this.setDataBan(dataBan);
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdLogBan(),
					""+this.getIdUsuario(),
					""+this.getDescricao(),
					""+this.getDataBan()
			}
		);
	}
	
	public void save() {
		if ((this.getIdLogBan() == 0)) {
			this.dbQuery.insert(this.toArray());
		} 
		else {
			this.dbQuery.update(this.toArray());
		}
	}
	
	public void delete() {
		if (this.getIdLogBan() > 0) {
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
	
	public boolean check() {
		int id = 0;
		try {
			ResultSet resultSet = this.select("idUsuario ='"+ this.getIdUsuario() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idLogBan");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}

	public int getIdLogBan() {
		return idLogBan;
	}

	public void setIdLogBan(int idLogBan) {
		this.idLogBan = idLogBan;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getDataBan() {
		return dataBan;
	}

	public void setDataBan(String dataBan) {
		this.dataBan = dataBan;
	}
}
