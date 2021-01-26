<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Comentario"%>
<%@page import="classes.Likes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="feed">
    <h2>Busca</h2>
    <form id="formstd" action="busca.jsp" method="POST">
	    <div class="busca-area">
	    	<button class="busca-icon" type="submit">➤</button>
	        <%
				String busca = request.getParameter("busca");
				ResultSet topic = null;
	     	   	int found = 0;	
	        
				if( busca == null ) {
					out.println("<input class='busca' name='busca' type='text' placeholder='Buscar'>");
				} else {
					topic = new Topico().selectCondition("* FROM Topico WHERE titulo LIKE '%" + busca + "%'");
					out.println("<input class='busca' name='busca' type='text' placeholder='Buscar' value='" + busca + "'>");
					if(topic.next()) {
						found = 1;
					}
				}
			%>
	    </div>
	</form>
    
    <h2>Tópicos</h2>
    
    <ul>
    	<%
    		if(found == 1) {
    			do {
    				ResultSet op = new Usuario().select("idUsuario='" + topic.getString("idUsuario") + "'");
    				op.next();
    				
    				ResultSet commentAmount = new Comentario().selectCount("idTopico='" + topic.getString("idTopico") + "'");
    				ResultSet likeAmount = new Likes().selectCount("idTopico='" + topic.getString("idTopico") + "'");
    				commentAmount.next();
    				likeAmount.next();
    				
    				out.println("<li class='lista'>");
    				out.println("	<div class='title'>");
    				out.println("		<a href='topic.jsp?id=" + topic.getString("idTopico") + "'>");
    				out.println(		topic.getString("titulo") + "<br>");
    				out.println("		<cite>by " + op.getString("apelido") + "</cite>");
    				out.println("	</a></div>");
    				
    				out.println("	<div class='stats'>");
    				out.println("		<div class='comments'>");
    				out.println(			commentAmount.getString("count(*)") + "<br>");
    				out.println("			<img src='img/icon/comments.png'>");
    				out.println("		</div>");
    				out.println("		<div class='likes'>");
    				out.println(			likeAmount.getString("count(*)") + "<br>");
    				out.println("			<img src='img/icon/like.png'>");
    				out.println("		</div>");
    				out.println("</div></li>");
    			} while (topic.next());
    		} else {
    			out.println("<li class='lista'>Nenhum tópico encontrado</li>");
    		}
    	%>
    </ul>