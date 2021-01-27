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
			
			if( Integer.valueOf(usuario.getString("idNivelUsuario")) != 3) {
				response.sendRedirect("../login.html");
			}
			
			String idCategoria = request.getParameter("idCategoria");
			String descricao   = request.getParameter("descricao");
			
			String saida = ""; 
			
			if( descricao.equals("") && idCategoria.equals("") ) {
				saida = "{ \"alterar\": \"false\"}";
			} else {
				ResultSet category = new Categoria().select("idCategoria='" + idCategoria + "'");
				if(category.next()) {
					Categoria categoria = new Categoria(idCategoria, descricao);
					categoria.save();
					saida = "{ \"alterar\": \"true\"}";
				}
				else {
					saida = "{ \"alterar\": \"false\"}";
				}
			}
			
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("../login.html");
	}
%>
