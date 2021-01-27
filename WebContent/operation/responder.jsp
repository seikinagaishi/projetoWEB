<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Comentario"%>
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
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			
			String idTopico    = request.getParameter("idTopico");
			String mensagem    = request.getParameter("mensagem");
			String data 	   = dtf.format(now) + "";
			
			String saida = ""; 
			
			if( mensagem.equals("") ) {
				saida = "{ \"criar\": \"false\"}";
			} 
			else {
				Comentario comentario = new Comentario(0, Integer.valueOf(idTopico), userLogin, mensagem, data);
				comentario.save();
				saida = "{ \"criar\": \"true\"}";
			}
			
			out.write(saida);
		}
	}
   	else {
   		response.sendRedirect("../login.html");
   	}
%>
