package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;
import multitool.RandomCode;

public class Usuario {
	private int	   	idUsuario;
	private String	apelido;
	private String 	password;
	private String 	email;
	private int 	idNivelUsuario;
	private int		idConquista;
	private String 	bio;
	private String 	gender;
	private String 	dataNasc;
	private String	dataInsc;
	private String	ultimaSessao;
	private String 	foto;
	private int		exp;
	private int 	ativo;
	private int 	banido;
	private int		privado;
	private String	cod;
	
	private String tableName	= "forum.usuario"; 
	private String fieldsName	= "idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod";  
	private String fieldKey		= "idUsuario";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	
	public Usuario() {
	}
	
	public Usuario(int idUsuario, String apelido, String password, String email, int idNivelUsuario, int idConquista, String bio, String gender, String dataNasc, String dataInsc, String ultimaSessao, String foto, int exp, int ativo, int banido, int privado, String cod) {
		this.setIdUsuario(idUsuario);
		this.setApelido(apelido);
		this.setPassword(password);
		this.setEmail(email);
		this.setIdNivelUsuario(idNivelUsuario);
		this.setIdConquista(idConquista);
		this.setBio(bio);
		this.setGender(gender);
		this.setDataNasc(dataNasc);
		this.setDataInsc(dataInsc);
		this.setUltimaSessao(ultimaSessao);
		this.setFoto(foto);
		this.setExp(exp);
		this.setAtivo(ativo);
		this.setBanido(banido);
		this.setPrivado(privado);
		this.setCod(cod);
	}
	
	public Usuario(String idUsuario, String apelido, String password, String email, String idNivelUsuario, String idConquista, String bio, String gender, String dataNasc, String dataInsc, String ultimaSessao, String foto, String exp, String ativo, String banido, String privado, String cod) {
		this.setIdUsuario(((idUsuario == null)?0:Integer.valueOf(idUsuario)));
		this.setApelido(apelido);
		this.setPassword(password);
		this.setEmail(email);
		this.setIdNivelUsuario(idNivelUsuario);
		this.setIdConquista(((idConquista == null)?0:Integer.valueOf(idConquista)));
		this.setBio(bio);
		this.setGender(gender);
		this.setDataNasc(dataNasc);
		this.setDataInsc(dataInsc);
		this.setUltimaSessao(ultimaSessao);
		this.setFoto(foto);
		this.setExp(exp);
		this.setAtivo(((ativo == null)?0:Integer.valueOf(ativo)));
		this.setBanido(((banido == null)?0:Integer.valueOf(banido)));
		this.setPrivado(((privado == null)?0:Integer.valueOf(privado)));
		this.setCod(cod);
	}
	
	public Usuario( String email, String password) {
		this.setIdUsuario(0);
		this.setEmail(email);
		this.setPassword(password);
	}
	
	public Usuario(String email) {
		this.setIdUsuario(0);
		this.setEmail(email);
	}
	
	public Usuario(String email, String password, String apelido, String cod, String dataInsc, String dataNasc) {
		this.setIdUsuario(0);
		this.setEmail(email);
		this.setPassword(password);
		this.setApelido(apelido);
		this.setCod(cod);
		this.setDataInsc(dataInsc);
		this.setDataNasc(dataNasc);
		
		this.setUltimaSessao("2020-01-16");
		this.setIdNivelUsuario(1);
		this.setIdConquista(0);
		this.setBio("Olá");
		this.setGender("Não informado");
		this.setFoto("foto0");
		this.setExp(0);
		this.setAtivo(0);
		this.setBanido(0);
		this.setPrivado(0);
		
	}
	
	public Usuario(int idUsuario, int exp) {
		try {
			ResultSet resultSet = this.selectBy("idUsuario", ""+idUsuario);
			while (resultSet.next()) {
				this.setIdUsuario(idUsuario);
				this.setApelido(resultSet.getString("apelido"));
				this.setPassword(resultSet.getString("password"));
				this.setEmail(resultSet.getString("email"));
				this.setIdNivelUsuario(resultSet.getString("idNivelUsuario"));
				this.setIdConquista(resultSet.getInt("idConquista"));
				this.setBio(resultSet.getString("bio"));
				this.setGender(resultSet.getString("gender"));
				this.setDataNasc(resultSet.getString("dataNasc"));
				this.setDataInsc(resultSet.getString("dataInsc"));
				this.setUltimaSessao(resultSet.getString("ultimaSessao"));
				this.setFoto(resultSet.getString("foto"));
				this.setExp( resultSet.getInt("exp") + exp );
				this.setAtivo(resultSet.getInt("ativo"));
				this.setBanido(resultSet.getInt("banido"));
				this.setPrivado(resultSet.getInt("privado"));
				this.setCod(resultSet.getString("cod"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Usuario(int idUsuario, String email, String ultimaSessao) {
		try {
			ResultSet resultSet = this.selectBy("idUsuario", ""+idUsuario);
			while (resultSet.next()) {
				this.setIdUsuario(idUsuario);
				this.setApelido(resultSet.getString("apelido"));
				this.setPassword(resultSet.getString("password"));
				this.setEmail(email);
				this.setIdNivelUsuario(resultSet.getString("idNivelUsuario"));
				this.setIdConquista(resultSet.getInt("idConquista"));
				this.setBio(resultSet.getString("bio"));
				this.setGender(resultSet.getString("gender"));
				this.setDataNasc(resultSet.getString("dataNasc"));
				this.setDataInsc(resultSet.getString("dataInsc"));
				this.setUltimaSessao(ultimaSessao);
				this.setFoto(resultSet.getString("foto"));
				this.setExp( resultSet.getInt("exp"));
				this.setAtivo(resultSet.getInt("ativo"));
				this.setBanido(resultSet.getInt("banido"));
				this.setPrivado(resultSet.getInt("privado"));
				this.setCod(resultSet.getString("cod"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String toString() {
		return(
				this.getIdUsuario() + " | " +
				this.getApelido() + " | " +
				"********" + " | " +
				this.getEmail() + " | " +
				this.getIdNivelUsuario() + " | " +
				this.getIdConquista() + " | " +
				this.getBio() + " | " +
				this.getGender() + " | " +
				this.getDataNasc() + " | " +
				this.getDataInsc() + " | " +
				this.getUltimaSessao() + " | " +
				this.getFoto() + " | " +
				this.getExp() + " | " +
				this.getAtivo() + " | " +
				this.getBanido() + " | " +
				this.getPrivado() + " | " +
				this.getCod() + " | "
		);
	}
	
	private String[] toArray() {
		
		String[] temp =  new String[] {
				this.getIdUsuario() + "",
				this.getApelido(),
				this.getPassword(),
				this.getEmail(),
				this.getIdNivelUsuario() + "",
				this.getIdConquista() + "",
				this.getBio(),
				this.getGender() + "",
				this.getDataNasc(),
				this.getDataInsc(),
				this.getUltimaSessao(),
				this.getFoto(),
				this.getExp() + "",
				this.getAtivo() + "",
				this.getBanido() + "",
				this.getPrivado() + "",
				this.getCod() + "",
		};
		return(temp);
	}
	
	public void save() {
		if( this.getIdUsuario() > 0 ) {
			this.dbQuery.update(this.toArray());
		}else {
			this.dbQuery.insert(this.toArray());
		}
	}
	
	public void delete() {
		if( this.getIdUsuario() > 0 ) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public ResultSet selectAll() {
		ResultSet resultset = this.dbQuery.select("");
		return(resultset);
	}
	
	public ResultSet selectBy( String field, String value ) {
		ResultSet resultset = this.dbQuery.select( " "+field+"='"+value+"'");
		return(resultset);
	}
	
	public ResultSet select( String where ) {
		ResultSet resultset = this.dbQuery.select(where);
		return(resultset);
	}
	
	public String newPassword() {
		
		if (this.getEmail() != "" && this.getEmail()!= null) {
			if ( this.getIdUsuario() > 0 ) {
				try {
					ResultSet resultset = this.select(" email ='"+this.getEmail()+"' OR apelido = '" + this.getApelido() + "'");
					boolean existe = resultset.next();
					if ( existe ) {
						this.setPassword(  new RandomCode().generate(32) );
						this.save();
						return( this.getPassword());
					}
					resultset.getInt("idUsuario");
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			} else {
				this.setPassword(  new RandomCode().generate(32));
				return(  this.getPassword() );
			}
		} else {
			// Sem email não deve gerar senha
		}
		return this.getPassword(); 
	}

	public boolean checkLogin() {
		int id = 0, nivelUsuario = 0;
		try {
			ResultSet resultSet = this.select(" email='"+ this.getEmail()+ "' AND password = '"+this.getPassword()+"'");
			while (resultSet.next()) {
				System.out.println( "\n"+resultSet.getString("apelido"));
				id = resultSet.getInt("idUsuario");
				nivelUsuario = resultSet.getInt("idNivelUsuario");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		this.setIdUsuario(id);
		this.setIdNivelUsuario(nivelUsuario);
		return(id > 0);	
	}
	
	public boolean check() {
		int id = 0;
		try {
			ResultSet resultSet = this.select(" email='"+ this.getEmail() + "' OR apelido='" + this.getApelido() + "'");
			while (resultSet.next()) {
				System.out.println( "\n"+resultSet.getString("apelido"));
				id = resultSet.getInt("idUsuario");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return(id > 0);	
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getApelido() {
		return apelido;
	}

	public void setApelido(String apelido) {
		this.apelido = apelido;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getIdNivelUsuario() {
		return idNivelUsuario;
	}

	public void setIdNivelUsuario(int idNivelUsuario) {
		this.idNivelUsuario = idNivelUsuario;
	}
	
	public void setIdNivelUsuario(String idNivelUsuario) {
		this.idNivelUsuario = ((idNivelUsuario == "") ? 0 : Integer.parseInt(idNivelUsuario));
	}
	
	public int getIdConquista() {
		return idConquista;
	}

	public void setIdConquista(int idConquista) {
		this.idConquista = idConquista;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDataNasc() {
		return dataNasc;
	}

	public void setDataNasc(String dataNasc) {
		this.dataNasc = dataNasc;
	}
	
	public String getDataInsc() {
		return dataInsc;
	}

	public void setDataInsc(String dataInsc) {
		this.dataInsc = dataInsc;
	}
	
	public String getUltimaSessao() {
		return ultimaSessao;
	}

	public void setUltimaSessao(String ultimaSessao) {
		this.ultimaSessao = ultimaSessao;
	}

	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}

	public int getExp() {
		return exp;
	}

	public void setExp(int exp) {
		this.exp = exp;
	}
	
	public void setExp(String exp) {
		this.exp = ((exp == "") ? 0 : Integer.parseInt(exp));
	}

	public int getAtivo() {
		return ativo;
	}

	public void setAtivo(int ativo) {
		this.ativo = ativo;
	}
	
	public int getBanido() {
		return banido;
	}

	public void setBanido(int banido) {
		this.banido = banido;
	}
	
	public int getPrivado() {
		return privado;
	}

	public void setPrivado(int privado) {
		this.privado = privado;
	}
	
	public String getCod() {
		return cod;
	}

	public void setCod(String cod) {
		this.cod = cod;
	}
}
