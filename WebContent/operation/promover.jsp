<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Seguir"%>
<%@page import="classes.Conquistado"%>
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
			
			String idUsuario = request.getParameter("id");
			
			ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
			user.next();
			
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
			String banido			= user.getString("banido");	
			String privado			= user.getString("privado");		
			String cod 				= user.getString("cod");
			String idNivelUsuario = "";
			
			String saida = "";
			
			if( user.getString("idNivelUsuario").equals("3") ) {
				saida = "{ \"mod\": \"admin\"}";
			}
			else {
				if( user.getString("idNivelUsuario").equals("1") ) {
					idNivelUsuario = "2";
					saida = "{ \"mod\": \"true\"}";
				} else {
					idNivelUsuario = "1";
					saida = "{ \"mod\": \"false\"}";
					
					ResultSet conquistado = new Conquistado().select("idUsuario='" + idUsuario + "' AND idConquista='2'");
					if(conquistado.next()) {
						Conquistado clear = new Conquistado( conquistado.getString("idConquistado") );
						clear.delete();
						//remoção da conquista de moderador em caso de demoção
					}
					
				} 
				
				Usuario mod = new Usuario(idUsuario, apelido, password, email, idNivelUsuario, idConquista, bio, gender, dataNasc, dataInsc, ultimaSessao, foto, exp, ativo, banido, privado, cod);
				mod.save();
			}	
			out.write(saida);
		}
	}
	else {
		response.sendRedirect("../login.html");
	}
%>
