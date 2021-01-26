<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String email = request.getParameter("email");
	String senha = request.getParameter("senha");
	
	String saida = ""; 

	Usuario usuario = new Usuario (email, senha);
	if (usuario.checkLogin()){
		session.setAttribute("userlogin", usuario.getIdUsuario());
		saida = "{ \"login\": \"true\", \"user\": \"" + usuario.getIdUsuario()+"\"}";
		
	}else{
		session.setAttribute("userlogin", 0);
		saida = "{ \"login\": \"false\", \"user\": \"0\"}";
	}
	out.write(saida);
%>