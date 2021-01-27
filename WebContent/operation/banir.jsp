<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Seguir"%>
<%@page import="classes.LogBan"%>
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
			
			if( !(Integer.valueOf(usuario.getString("idNivelUsuario")) > 1) ) {
				response.sendRedirect("../login.html");
			}
			
			String idUsuario = request.getParameter("id");
			
			ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
			user.next();
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			
			String apelido 			= user.getString("apelido");
			String password			= user.getString("password");
			String email			= user.getString("email");
			String idConquista 		= user.getString("idConquista");
			String bio				= user.getString("bio");
			String gender			= user.getString("gender");
			String dataNasc			= user.getString("dataNasc");
			String dataInsc			= user.getString("dataInsc");
			String ultimaSessao		= user.getString("ultimaSessao");
			String foto				= user.getString("foto");
			String exp				= user.getString("exp");
			String ativo			= user.getString("ativo");
			String idNivelUsuario	= user.getString("idNivelUsuario");	
			String privado			= user.getString("privado");		
			String cod 				= user.getString("cod");
			
			String banido = "";
			String saida  = "";
			if( user.getString("banido").equals("0") ) {
				banido = "1";
				saida = "{ \"ban\": \"true\"}";
				LogBan log = new LogBan(0, userLogin, "Banido por" + usuario.getString("apelido"), dtf.format(now));
				log.save();
			} else {
				banido = "0";
				saida = "{ \"ban\": \"false\"}";
				LogBan log = new LogBan(0, userLogin, "Desbanido por " + usuario.getString("apelido"), dtf.format(now));
				log.save();
			} 
			
			Usuario ban = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
			ban.save();
			
			
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("../login.html");
	}
%>
