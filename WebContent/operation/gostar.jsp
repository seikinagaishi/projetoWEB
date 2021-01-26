<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Likes"%>
<%@page import="classes.LogEXP"%>
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
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			
			String id    = request.getParameter("id");
			String tipo  = request.getParameter("tipo");
			String data  = dtf.format(now) + "";
			
			String saida = ""; 


			if( tipo.equals("1") ) {
				//like para tópicos
				ResultSet likeCheck = new Likes().select("idUsuario='" + userLogin + "' AND idTopico='" + id + "'");
				
				if(likeCheck.next()) {
					Likes like = new Likes( likeCheck.getString("idLike") );
					like.delete();
					saida = "{ \"like\": \"false\"}";
				}
				else {
					Likes like = new Likes(0, Integer.valueOf(id), 0, userLogin, Integer.valueOf(tipo), data);
					like.save();
					saida = "{ \"like\": \"true\"}";
					
					if( usuario.getInt("exp") < 11000 ) {
					//caso o usuário ainda não esteja no level máximo
						dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						
						ResultSet checkDailyEXP = new LogEXP().select("idUsuario='" + userLogin + "' AND qtd='5' AND data='" + dtf.format(now) + "'");
						//likes em tópicos garantem 5 pontos de experiência
						if(checkDailyEXP.next()) {
							int index = 0;
							do {
								index++;
							} while(checkDailyEXP.next() && index < 5);
							//checar limite diário de 5 vezes
							
							if(index < 5) {
								Usuario dailyEXP = new Usuario(userLogin, 5);
								dailyEXP.save();
								
								LogEXP log = new LogEXP(0, userLogin, 5, dtf.format(now));
								log.save();
							}
						} else {
							Usuario dailyEXP = new Usuario(userLogin, 5);
							dailyEXP.save();
							
							LogEXP log = new LogEXP(0, userLogin, 5, dtf.format(now));
							log.save();
						}
					}
				}
			}
			else {
			//like para comentários
				ResultSet likeCheck = new Likes().select("idUsuario='" + userLogin + "' AND idComentario='" + id + "'");
				
				if(likeCheck.next()) {
					Likes like = new Likes( likeCheck.getString("idLike") );
					like.delete();
					saida = "{ \"like\": \"false\"}";
				}
				else {
					Likes like = new Likes(0, 0, Integer.valueOf(id), userLogin, Integer.valueOf(tipo), data);
					like.save();
					saida = "{ \"like\": \"true\"}";
				}
			}
			
			out.write(saida);
		}
	}
   	else {
   		response.sendRedirect("../login.html");
   	}
%>
