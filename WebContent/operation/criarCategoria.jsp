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
			response.sendRedirect("login.html");
		}
		
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("idNivelUsuario")) != 3) {
				response.sendRedirect("login.html");
			}
			
			String descricao = request.getParameter("descricao");
			
			String saida = ""; 
			
			if( descricao.equals("") ) {
				saida = "{ \"criar\": \"false\"}";
			} else {
				Categoria categoria = new Categoria(0, descricao);
				if(categoria.check()) {
					saida = "{ \"criar\": \"error\"}";
				}
				else {
					categoria.save();
					saida = "{ \"criar\": \"true\"}";
				}
			}
			
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("login.html");
	}
%>
