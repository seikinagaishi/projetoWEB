<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Denuncia"%>
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
			
			String idDenunciado = request.getParameter("idUsuario");
			String tipo 	   	= request.getParameter("tipo");
			String descricao    = request.getParameter("descricao");
			
			String saida = ""; 
			
			if( descricao.equals("") ) {
				saida = "{ \"criar\": \"false\"}";
			} 
			else {
				Denuncia report = new Denuncia (0, userLogin, Integer.valueOf(idDenunciado), Integer.valueOf(tipo), descricao);
				report.save();
				
				saida = "{ \"criar\": \"true\"}";
			}
			
			out.write(saida);
		}
	}
   	else {
   		response.sendRedirect("login.html");
   	}
%>
