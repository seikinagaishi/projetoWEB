<%@page import="java.sql.ResultSet"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="mail.SendMail"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String email 	= request.getParameter("email");
	String saida = "";

	ResultSet usuario = new Usuario().select("email='" + email + "'");
	
	if(usuario.next()) {
		String idUsuario		= usuario.getString("idUsuario");
		String apelido 			= usuario.getString("apelido");
		String senha			= usuario.getString("password");
		String idNivelUsuario	= usuario.getString("idNivelUsuario");
		String idConquista 		= usuario.getString("idConquista");
		String bio				= usuario.getString("bio");
		String gender			= usuario.getString("gender");
		String dataNasc			= usuario.getString("dataNasc");
		String dataInsc			= usuario.getString("dataInsc");
		String ultimaSessao		= usuario.getString("ultimaSessao");
		String foto				= usuario.getString("foto");
		String exp				= usuario.getString("exp");
		String ativo			= usuario.getString("ativo");
		String privado 			= usuario.getString("privado");
		String banido			= usuario.getString("banido");		
		String cod 				= new Usuario(email).newPassword();
		
		saida = "{ \"exist\": \"true\"}";
		
		Usuario user = new Usuario(idUsuario, apelido, senha, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
		user.save();
		
		String smtpHost = "smtp.gmail.com"; 
		String smtpPort = "587"; 
		String username = "email@gmail.com";
		String password = "senha";
		String auth     = "tls";  
		SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );
		
		String mailFrom 	= "email@gmail.com"; 
	 	String mailTo 		= email;
	 	String mailSubject 	= "Recuperação"; 
	 	String mailBody 	= "Para recuperar sua conta, acesse o link: http://localhost:8080/forum/novaSenha.jsp?idUsuario=" + idUsuario + "&cod=" + cod; 
		sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
	} 
	else {
		saida = "{ \"exist\": \"false\"}";
	}

	out.write(saida);
%>