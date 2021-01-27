<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("userlogin") != null) {
		int userLogin = 0; 
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
		}
		else {
			response.sendRedirect("../index.html");
		}
	}
	else {
	}

	String idUsuario 	= request.getParameter("idUsuario");
	String cod		 	= request.getParameter("cod");
	String password 	= request.getParameter("senhaNova");
	String senhaConfirm = request.getParameter("senhaConfirm");
	
	String saida = ""; 
	
	if( idUsuario.equals("") || cod.equals("") || password.equals("") || senhaConfirm.equals("") ) {
		saida = "{ \"alterar\": \"empty\"}";
	}
	else {
		ResultSet usuario = new Usuario().select("idUsuario='" + idUsuario + "' AND cod='" + cod + "'");
		if( usuario.next() ) {
			if( password.equals(senhaConfirm) ) {
				String apelido 			= usuario.getString("apelido");
				String email			= usuario.getString("email");
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
				String banido			= usuario.getString("banido");
				String privado			= usuario.getString("privado");
				
				Usuario user = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
				user.save();
				
				saida = "{ \"alterar\": \"true\"}";
			}
			else {
				saida = "{ \"alterar\": \"false\"}";
			}
		}
		else {
			response.sendRedirect("../login.html");
		}
	}
	
	out.write(saida);
%>
