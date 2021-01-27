<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Seguir"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("userlogin") != null) {
		int userLogin = 0; 
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
			response.sendRedirect("../login.html");
		}
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
				response.sendRedirect("../check.html");
			}
			
			String idSeguido = request.getParameter("id");
			
			String saida = "";
			
			ResultSet seguido = new Seguir().select("idUsuario='" + userLogin + "' AND idSeguido='" + idSeguido + "'");

			
			if(seguido.next()) {
				Seguir follow = new Seguir( seguido.getString("idSeguir") );
				follow.delete();
				saida = "{ \"follow\": \"false\"}";
			} else {
				Seguir follow = new Seguir(0, userLogin, Integer.valueOf(idSeguido));
				follow.save();
				saida = "{ \"follow\": \"true\"}";
			}
			
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("login.html");
	}
%>
