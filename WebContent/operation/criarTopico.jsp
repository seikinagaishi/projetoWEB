<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Topico"%>
<%@page import="classes.LogEXP"%>
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
			
			String idCategoria = request.getParameter("idCategoria");
			String titulo 	   = request.getParameter("titulo");
			String mensagem    = request.getParameter("mensagem");
			String data 	   = dtf.format(now) + "";
			
			String saida = ""; 
			
			if( titulo.equals("") || mensagem.equals("") ) {
				saida = "{ \"criar\": \"false\"}";
			} 
			else {
				Topico topic = new Topico (0, userLogin, Integer.valueOf(idCategoria), titulo, mensagem, data);
				topic.save();
				
				ResultSet created = new Topico().select("mensagem ='" + mensagem + "' ORDER BY data DESC");
				created.next();
				saida = "{ \"criar\": \"true\", \"topico\": \"" + created.getString("idTopico") + "\"}";
				
				
				if( usuario.getInt("exp") < 11000 ) {
				//Caso o usuário ainda não tenha atingido o level máximo
				
					dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					
					ResultSet checkDailyEXP = new LogEXP().select("idUsuario='" + userLogin + "' AND qtd='10' AND data='" + dtf.format(now) + "'");
					//Criação de tópico garante 10 de EXP
					
					if(checkDailyEXP.next()) {
						int index = 0;
						do {
							index++;
						} while(checkDailyEXP.next() && index < 2);
						//Limite de duas vezes por dia
						
						if(index < 2) {
							Usuario dailyEXP = new Usuario(userLogin, 10);
							dailyEXP.save();
							
							LogEXP log = new LogEXP(0, userLogin, 10, dtf.format(now));
							log.save();
						}
					} else {
						Usuario dailyEXP = new Usuario(userLogin, 10);
						dailyEXP.save();
						
						LogEXP log = new LogEXP(0, userLogin, 10, dtf.format(now));
						log.save();
					}
				}
			}
			
			out.write(saida);
		}
	}
   	else {
   		response.sendRedirect("../login.html");
   	}
%>
