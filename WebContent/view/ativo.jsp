<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="small-box">
    <h2>Conta</h2>
    <!-- <h2>Conta banida</h2> -->
    <div class="container">
    
    	<%
	    	if(session.getAttribute("userlogin") != null) {
	    		System.out.println("");
	    		System.out.println("teste");
	    		int userLogin = 0; 
				userLogin = (int) session.getAttribute("userlogin");
				if ( ! (userLogin > 0 )){
					response.sendRedirect("login.jsp");
				}
				else {
					ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
					usuario.next();
					
					if( Integer.valueOf(usuario.getString("ativo")) == 0 ) {
						out.println("Essa conta ainda não foi ativada.<br>Para ativar, verifique o endereço de email utilizado para registrar.");
					}
					else if( Integer.valueOf(usuario.getString("ativo")) == 1 && Integer.valueOf(usuario.getString("banido")) == 0 ) {
						out.println("Sua conta foi ativada com sucesso.");
					}
					else {
						out.println("Essa conta foi banida.");
					}
				}
	    	}
	    	else {
	    		response.sendRedirect("login.jsp");
	    	}
		%>
    </div>        
</div>