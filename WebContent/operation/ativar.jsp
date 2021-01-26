<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int userLogin = 0; 
	
	userLogin 		= (int) session.getAttribute("userlogin");
	String apelido 	= request.getParameter("apelido");
	String cod 		= request.getParameter("cod");
	
	ResultSet usuario = new Usuario().select("apelido='" + apelido + "' AND cod='" + cod + "'");
	usuario.next();
	
	
	if ( userLogin != Integer.valueOf(usuario.getString("idUsuario")) ){
		response.sendRedirect("../login.html");
	}
	else {
		if( Integer.valueOf(usuario.getString("ativo")) == 0 ) {
			String idUsuario		= usuario.getString("idUsuario");
			String password			= usuario.getString("password");
			String email			= usuario.getString("email");
			String idNivelUsuario	= usuario.getString("idNivelUsuario");
			String idConquista		= usuario.getString("idConquista");
			String bio				= usuario.getString("bio");
			String gender			= usuario.getString("gender");
			String dataNasc			= usuario.getString("dataNasc");
			String dataInsc			= usuario.getString("dataInsc");
			String ultimaSessao		= usuario.getString("ultimaSessao");
			String foto				= usuario.getString("foto");
			String exp				= usuario.getString("exp");
			String ativo			= "1";
			String banido			= usuario.getString("banido");
			String privado			= usuario.getString("privado");
			
			Usuario user = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
			user.save();
		}
		
		response.sendRedirect("../check.html");
	}
%>
