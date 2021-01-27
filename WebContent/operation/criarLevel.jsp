<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Level"%>
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
			
			String idLevel = request.getParameter("idLevel");
			String exp 	   = request.getParameter("exp");
			
			String saida = ""; 
			
			if( idLevel.equals("") || exp.equals("") ) {
				saida = "{ \"criar\": \"false\"}";
			} else {
				Level lv = new Level(idLevel, exp);
				if(lv.check()) {
					saida = "{ \"criar\": \"error\"}";
				}
				else {
					lv.save();
					saida = "{ \"criar\": \"true\"}";
				}
			}
			
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("../login.html");
	}
%>
