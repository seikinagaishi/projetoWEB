package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Level {
	
	private int 	idLevel;
	private int		exp;
	
	private String	tableName = "forum.level";
	private String	fieldsName = "idLevel, exp";
	private String	keyField = "idLevel";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, keyField);
	
	public Level() {
	}
	
	public Level(String idLevel) {
		this.setIdLevel(((idLevel == null)?0:Integer.valueOf(idLevel)));
	}
	
	public Level(int idLevel, int exp) {	
		this.setIdLevel(idLevel);
		this.setExp(exp);
	}
	
	public Level(String idLevel, String exp) {
		this.setIdLevel(((idLevel == null)?0:Integer.valueOf(idLevel)));
		this.setExp(((exp == null)?0:Integer.valueOf(exp)));
	}
	
	public String[] toArray() {
		return (
			new String[] {
					""+this.getIdLevel(),
					""+this.getExp()
			}
		);
	}
	
	public void save() {
			this.dbQuery.insert(this.toArray());
	}
	
	public void update() {
		this.dbQuery.update(this.toArray());
}
	
	public void delete() {
		if (this.getIdLevel() > 0) {
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
			ResultSet resultSet = this.select("exp='"+ this.getExp() + "' OR idLevel='" + this.getIdLevel() + "'");
			while (resultSet.next()) {
				id = resultSet.getInt("idLevel");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}
	
	public int getIdLevel() {
		return idLevel;
	}
	public void setIdLevel(int idLevel) {
		this.idLevel = idLevel;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	
}
