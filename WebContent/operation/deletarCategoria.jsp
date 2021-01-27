<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
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
			
			if( Integer.valueOf(usuario.getString("idNivelUsuario")) != 3) {
				response.sendRedirect("../login.html");
			}
			
			String idCategoria = request.getParameter("id");
			
			if(idCategoria != null) {
				ResultSet category = new Categoria().select("idCategoria='" + idCategoria + "'");
				if(category.next()) {
					Categoria catDel = new Categoria(idCategoria);
					catDel.delete();
				}
			}
			else {
				response.sendRedirect("../index.html");
			}
		}
	}
   	else {
   		response.sendRedirect("../login.html");
   	}
%>
