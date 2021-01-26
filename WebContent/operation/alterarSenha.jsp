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
			
			String senhaAtual 	= request.getParameter("senhaAtual");
			String password 	= request.getParameter("senhaNova");
			String senhaConfirm = request.getParameter("senhaConfirm");
			
			String saida = ""; 
			
			if( senhaAtual.equals("") || password.equals("") || senhaConfirm.equals("") ) {
				saida = "{ \"alterar\": \"empty\"}";
			}
			else {
				if( senhaAtual.equals(usuario.getString("password")) ) {
					if( password.equals(senhaConfirm) ) {
						String idUsuario		= usuario.getString("idUsuario");
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
						String cod 				= usuario.getString("cod");
						
						Usuario user = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
						user.save();
						
						saida = "{ \"alterar\": \"true\"}";
					}
					else {
						saida = "{ \"alterar\": \"false\"}";
					}
				}
				else {
					saida = "{ \"alterar\": \"error\"}";
				}
			}
	
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("login.html");
	}
%>
