<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("userlogin") != null) {
		int userLogin = 0; 
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
			response.sendRedirect("login.html");
		}
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
				response.sendRedirect("../check.html");
			}
			
			String idConquista = request.getParameter("idConquista");
			
			String idUsuario		= usuario.getString("idUsuario");
			String apelido 			= usuario.getString("apelido");
			String password			= usuario.getString("password");
			String email			= usuario.getString("email");
			String idNivelUsuario	= usuario.getString("idNivelUsuario");
			String bio				= usuario.getString("bio");
			String gender			= usuario.getString("gender");
			String dataNasc			= usuario.getString("dataNasc");
			String dataInsc			= usuario.getString("dataInsc");
			String ultimaSessao		= usuario.getString("ultimaSessao");
			String foto				= usuario.getString("foto");
			String exp				= usuario.getString("exp");
			String ativo			= usuario.getString("ativo");
			String banido			= usuario.getString("banido");
			String privado 			= usuario.getString("privado");
			String cod 				= usuario.getString("cod");
			
			Usuario user = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
			user.save();
		}
	}
	else {
		response.sendRedirect("login.html");
	}
%>
