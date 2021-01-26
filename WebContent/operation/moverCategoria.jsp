<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Topico"%>
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
			
			if( !(usuario.getInt("idNivelUsuario") > 1) ) {
				response.sendRedirect("login.html");
			}
			
			String idTopico    = request.getParameter("idTopico");
			String idCategoria = request.getParameter("idCategoria");
			
			if( !(idTopico.equals("") || idCategoria.equals("")) ) {
				ResultSet check = new Topico().select("idTopico='" + idTopico + "'");
				if(check.next()) {
					String idUsuario = check.getString("idUsuario");
					String titulo 	 = check.getString("titulo");
					String mensagem  = check.getString("mensagem");
					String data 	 = check.getString("data");
					
					Topico topic = new Topico(idTopico, idUsuario, idCategoria, titulo, mensagem, data);
					topic.save();
				}
			}
		}
	}
	else {
		response.sendRedirect("login.html");
	}
%>
