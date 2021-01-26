<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Comentario"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Likes"%>
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
			
			String id   = request.getParameter("id");
			String tipo = request.getParameter("tipo");
			
			if( tipo.equals("1") ) {
				//deletar tópico
				
				int check = 0;
				ResultSet topic = new Topico().select("idUsuario='" + userLogin + "' AND idTopico='" + id + "'");
				
				if(topic.next()) {
					check = 1;
					//garantir que a remoção está sendo pedida pelo usuário que criou o tópico
					
				} else if( usuario.getInt("idNivelUsuario") > 1 ) {
					//ou caso ele seja um moderador ou superior
					topic = new Topico().select("idTopico='" + id + "'");
					if(topic.next()) {
						check = 1;
					}
					
				}
				if(check == 1) {
					ResultSet likesFound = new Likes().select("idTopico='" + id + "'");
					if(likesFound.next()) {
						Likes like = new Likes(likesFound.getString("idLike"));
						like.delete();
						//deletar todos os likes deixados no tópico
					}
					
					ResultSet comment = new Comentario().select("idTopico='" + id + "'");
					while(comment.next()) {
						likesFound = new Likes().select("idComentario='" + comment.getString("idComentario") + "'");
						while(likesFound.next()) {
							Likes like = new Likes(likesFound.getString("idLike"));
							like.delete();
							//deletar todos os likes deixados nos comentários do tópico
						}
						Comentario delCom = new Comentario(comment.getString("idComentario"));
						delCom.delete();
						//deletar todos os comentários do tópico
					}
					Topico delTopico = new Topico(id);
					delTopico.delete();
				}	
			}
			else {
			//deletar comentário
				int check = 0;
				ResultSet comment = new Comentario().select("idUsuario='" + userLogin + "' AND idComentario='" + id + "'");
				
				if(comment.next()) {
					check = 1;
					//garantir que o dono do comentário esteja excluindo-o
				} else if ( usuario.getInt("idNivelUsuario") > 1 ) {
					comment = new Comentario().select("idComentario='" + id + "'");
					check = 1;
					//ou algum moderador ou superior
				}
				
				if(check == 1) {
					ResultSet likesFound = new Likes().select("idComentario='" + id + "'");
					while(likesFound.next()) {
						Likes like = new Likes(likesFound.getString("idLike"));
						like.delete();
						//deletar todos os likes deixados no comentários
					}
					
					Comentario delCom = new Comentario(id);
					delCom.delete();
				}
			}
		}
	}
   	else {
   		response.sendRedirect("../login.html");
   	}
%>
