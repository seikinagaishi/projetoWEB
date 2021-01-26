<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Comentario"%>
<%@page import="classes.Likes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("userlogin") != null) {
		
	  	int userLogin = 0;
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
		}
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
				response.sendRedirect("ativo.jsp");
			}
		}
	}
	else {
	}

	String idCategoria = request.getParameter("idCategoria");
	String idUsuario   = request.getParameter("idUser");
    String tipo 	   = request.getParameter("tipo");
    
    ResultSet topic = null;
	int caso = 0;
	
	if( idCategoria == null && idUsuario == null && tipo == null ) {
		//Se não houver parâmetros, todos os tópicos serão mostrados
		topic = new Topico().select("idTopico > 0 ORDER BY idTopico DESC");
		caso = 1;
	} else {

		
		if( idCategoria != null) {
	       	ResultSet category = new Categoria().select("idCategoria='" + idCategoria + "'");
	        category.next();
	        	
	        topic = new Topico().select("idCategoria='" + idCategoria + "' ORDER BY idTopico DESC");
	        	
	        out.println("<div id='directory'>");
	        out.println("	<a href='index.html'>home</a> /");
	        out.println("	<a href='categorias.html'>categorias</a> /");
	        out.println("	<a href='#'>" + category.getString("descricao") + "</a>");
	        out.println("</div>");
	        
	        caso = 1;
		} else if( idUsuario != null && tipo != null ) {
			ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
	        user.next();
	        
	        if(tipo.equals("1")) {
	        	//mostrar tópicos criados pelo usuário
	        	topic = new Topico().select("idUsuario='" + idUsuario + "' ORDER BY idTopico DESC");
	        	caso = 1;
	        } else if (tipo.equals("2")) {
	        	//mostrar tópicos em que o usuário comentou
	        	ResultSet comment = new Comentario().select("idUsuario='" + idUsuario + "'");
	        	
	        	
	        	out.println("<div id='content'>");
	    	   	out.println("	<div id='feed'>");
	    	   	out.println("		<h2>Tópicos</h2>");
	    		out.println("		<ul>");
	    		
	    		if (comment.next()) {
	    			do {
		    			topic = new Topico().select("idTopico='" + comment.getString("idTopico") + "'");
		    			
		    			if(topic.next()) {
		    	    		ResultSet op = new Usuario().select("idUsuario='" + topic.getString("idUsuario") + "'");
		    	    		op.next();
		    	    				
		    	    		ResultSet qtdLikes = new Likes().selectCount("idTopico ='" + topic.getString("idTopico") + "'");
		    	    		qtdLikes.next();
		    	    		
		    	    		ResultSet qtdComm = new Comentario().selectCount("idTopico='" + topic.getString("idTopico") + "'");
		    	    		qtdComm.next();
		    	    		
		    	    		out.println("<li class='lista'>");
		    	    		out.println("	<div class='title'>");
		    	    		out.println("		<a href='topic.jsp?id=" + topic.getString("idTopico") + "'>");
		    	    		out.println(			topic.getString("titulo") + "<br>");
		    	    		out.println("			<cite>by " + op.getString("apelido") + "</cite>");
		    	    		out.println("	</div></a>");
		    	    		
		    	    		out.println("Criado em <br>" + topic.getString("data"));
		    	    		
		    	    		out.println("<div class='stats'>");
		    	    		out.println("	<div class='comments'>");
		    	    		out.println(		qtdComm.getString("count(*)") + "<br>");
		    	    		out.println("		<img src='img/icon/comments.png'>");
		    	    		out.println("	</div>");
		    	    		
		    	    		out.println("	<div class='likes'>");
		    	    		out.println(		qtdLikes.getString("count(*)") + "<br>");
		    	    		out.println("		<img src='img/icon/like.png'>");
		    	    		out.println("</div></div></li>");
			    	    } else {
			    	    }
	    			} while(comment.next());	
	    		}
	    		
	    		out.println("</ul></div></div>");
	        }
	        
	    }
		else {
			topic = new Topico().select("idTopico > 0 ORDER BY idTopico DESC");
			caso = 1;
		}
	}
		
	if(caso == 1) {
		out.println("<div id='content'>");
	   	out.println("	<div id='feed'>");
	   	out.println("		<h2>Tópicos</h2>");
		out.println("		<ul>");
		        	
	    if(topic.next()) {
	    	do {
	    		ResultSet op = new Usuario().select("idUsuario='" + topic.getString("idUsuario") + "'");
	    		op.next();
	    				
	    		ResultSet qtdLikes = new Likes().selectCount("idTopico ='" + topic.getString("idTopico") + "'");
	    		qtdLikes.next();
	    		
	    		ResultSet qtdComm = new Comentario().selectCount("idTopico='" + topic.getString("idTopico") + "'");
	    		qtdComm.next();
	    		
	    		out.println("<li class='lista'>");
	    		out.println("	<div class='title'>");
	    		out.println("		<a href='topic.jsp?id=" + topic.getString("idTopico") + "'>");
	    		out.println(			topic.getString("titulo") + "<br>");
	    		out.println("			<cite>by " + op.getString("apelido") + "</cite>");
	    		out.println("	</div></a>");
	    		
	    		out.println("<div>Criado em <br>" + topic.getString("data") + "</div>");
	    		
	    		out.println("<div class='stats'>");
	    		out.println("	<div class='comments'>");
	    		out.println(		qtdComm.getString("count(*)") + "<br>");
	    		out.println("		<img src='img/icon/comments.png'>");
	    		out.println("	</div>");
	    		
	    		out.println("	<div class='likes'>");
	    		out.println(		qtdLikes.getString("count(*)") + "<br>");
	    		out.println("		<img src='img/icon/like.png'>");
	    		out.println("</div></div></li>");
	    				
	    	} while(topic.next());
	    } else {
	    	out.println("<li class='lista'>Nenhum tópico encontrado.</li>");
	    }
	    
	    out.println("</ul></div></div>");
	} else {
		
	}
%>