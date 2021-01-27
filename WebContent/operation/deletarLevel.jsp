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
			
			String idLevel = request.getParameter("id");
			
			if(idLevel != null) {
				ResultSet lvl = new Level().select("idLevel='" + idLevel + "'");
				if(lvl.next()) {
					Level lvDel = new Level(idLevel);
					lvDel.delete();
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
