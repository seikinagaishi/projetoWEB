<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Comentario"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Likes"%>
<%@page import="classes.Level"%>
<%@page import="classes.Seguir"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	out.println("<script type='text/javascript'>var users = []; </script>");
	ResultSet hot = new Likes().selectCountGroup("idTopico");
	//obtém os dados dos tópicos com mais likes
	
	if(hot.next()) {
		out.println("<div id='feed'>");
		out.println("	<h2>Em alta</h2>");
		out.println("	<ul id='hot'>");
		
		int index = 0;
		do {
			index++;
			
			ResultSet hotTopic = new Topico().select("idTopico='" + hot.getString("idTopico") + "'");
			if(hotTopic.next()) {
				ResultSet hotTopicUser = new Usuario().select("idUsuario='" + hotTopic.getString("idUsuario") + "'");
				ResultSet hotTopicLikes = new Likes().selectCount("idTopico='" + hotTopic.getString("idTopico") + "'");
				ResultSet hotTopicComments = new Comentario().selectCount("idTopico='" + hotTopic.getString("idTopico") + "'");
				hotTopicUser.next();
				hotTopicLikes.next();
				hotTopicComments.next();
				
				
				out.println("<li class='lista'>");
				out.println("	<div class='title'>");
				out.println("		<a href='topic.jsp?id=" + hotTopic.getString("idTopico") + "'>");
				out.println(			hotTopic.getString("titulo") + "<br>");
				out.println("			<cite>by " + hotTopicUser.getString("apelido") + "</cite>");
				out.println("	</a></div>");
				
				out.println("	Criado em <br>" + hotTopic.getString("data"));
				
				out.println("	<div class='stats'>");
				out.println("		<div class='stats-item'>");
				out.println(			hotTopicComments.getString("count(*)") + "<br>");
				out.println("			<img src='img/icon/comments.png'>");
				out.println("		</div>");
				
				out.println("		<div class='stats-item'>");
				out.println(			hotTopicLikes.getString("count(*)") + "<br>");
				out.println("			<img src='img/icon/like.png'>");
				out.println("</div></div></li>");
			}
			
			
		} while(hot.next() && index < 4);
		
		out.println("</ul></div>");
	}
	else {
		
	}
%> 

<div id="columns">
    <div id="side">
        <h2>Discussões recentes</h2>
        
        <ul id="recent-topics">
        	<%
	        	ResultSet recentTopic = new Topico().select("idTopico > 0 ORDER BY data DESC");
				if(recentTopic.next()) {
					int index = 0;
					do {
						index++;
						
						ResultSet recentTopicUser = new Usuario().select("idUsuario='" + recentTopic.getString("idUsuario") + "'");
						ResultSet recentTopicLikes = new Likes().selectCount("idTopico='" + recentTopic.getString("idTopico") + "'");
						ResultSet recentTopicComments = new Comentario().selectCount("idTopico='" + recentTopic.getString("idTopico") + "'");
						recentTopicUser.next();
						recentTopicLikes.next();
						recentTopicComments.next();
						
						out.println("<li class='lista'>");
						out.println("	<div class='title'>");
						out.println("		<a href='topic.jsp?id=" + recentTopic.getString("idTopico") + "'>" + recentTopic.getString("titulo") + "</a>");
						out.println("	</div>");
						
						out.println("	Criado em " + recentTopic.getString("data"));
						
						out.println("	<div class='stats'>");
						out.println(		recentTopicComments.getString("count(*)"));
						out.println("		<img src='img/icon/comments.png'>");
						out.println(		recentTopicLikes.getString("count(*)"));
						out.println("		<img src='img/icon/like.png'>");
						out.println("</div></li>");
					} while( recentTopic.next() && index < 11 );
				}
				else {
					out.println("<li class='lista'>Nenhum tópico recente</li");
				}
			%> 
        </ul>

        <div id="discussion-btns">
            <a class="btns" href="listaTopicos.jsp">
                <div>
                    Ver mais
                </div>
            </a>
            
            <a class="btns" href="createTopic.html">
                <div>
                    Criar novo Tópico
                </div>
            </a>
        </div>
        
    </div>
    
    <aside>
    	<%
    		int logado = 0;
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
	    			
	    			logado = 1;
	    			
	    			ResultSet following = new Seguir().select("idUsuario='" + userLogin + "'");
	    			ResultSet recommend = new Topico().selectCondition("t.idUsuario as poster, l.idUsuario, count(l.idLike) FROM forum.topico t JOIN forum.likes l ON l.idTopico = t.idTopico AND l.idUsuario = " + userLogin + " AND l.idUsuario != t.idUsuario GROUP BY l.idUsuario, t.idUsuario ORDER BY count(l.idLike) DESC");
	    			//Mostra uma tabela contendo os usuários que o usuário logado mais gosta
	    			
	    			ResultSet recommendedTopic = null;
	    			
	    			int check = 0;
	    			
	    			if(following.next()) {
	    				recommendedTopic = new Topico().select("idUsuario='" + following.getString("idSeguido") + "'");
	    				if( recommendedTopic.next() ) {
	    					check = 1;
	    					//o usuário logado está seguindo alguém
	    				}
	    			}
	    			
	    			if(recommend.next()) {
	    				if(check == 1) {
	    					check = 3;
	    					//o usuário logado já interagiu com seguidas e likes
	    				} else {
	    					check = 2;
	    					//o usuário logado já deu like em alguns conteúdos
	    				}
	    			}
	    			
	    			if(check > 0) {
	    				out.println("<div id='recommended'>");
	    				out.println("	<h2>Recomendado</h2>");
	    				out.println("	<ul id='recommended-topics'>");
	    				
	    				
	    				int index = 0;
	    				int[] postList = new int[3];
	    				
	    				if(check != 2) {
	    					do {
	    						recommendedTopic = new Topico().select("idUsuario='" + following.getString("idSeguido") + "'");
	    						while (recommendedTopic.next() && index < 3) {
	    							postList[index] = recommendedTopic.getInt("idTopico");
	    							
	    							index++;

	    							ResultSet recommendedTopicUser = new Usuario().select("idUsuario='" + recommendedTopic.getString("idUsuario") + "'");
	    							recommendedTopicUser.next();
	    							
	    							ResultSet recommendedTopicComments = new Comentario().selectCount("idTopico='" + recommendedTopic.getString("idTopico") + "'");
	    							ResultSet recommendedTopicLikes = new Likes().selectCount("idTopico='" + recommendedTopic.getString("idTopico") + "'");
	    							recommendedTopicComments.next();
	    							recommendedTopicLikes.next();
	    							
	    							out.println("<li class='lista'>");
	    							out.println("	<div class='title'>");
	    							out.println("		<a href='topic.jsp?id=" + recommendedTopic.getString("idTopico") + "'>");
	    							out.println(			recommendedTopic.getString("titulo") + "<br>");
	    							out.println("			<cite>by " + recommendedTopicUser.getString("apelido") + "</cite>");
	    							out.println("	</a></div>");
	    							
	    							out.println("	<div class='stats'>");
	    							out.println(		recommendedTopicComments.getString("count(*)"));
	    							out.println("		<img src='img/icon/comments.png'>");
	    							out.println(		recommendedTopicLikes.getString("count(*)"));
	    							out.println("		<img src='img/icon/like.png'>");
	    							out.println("</div></li>");
	    						}
		    				} while(following.next() && index < 3 );
	    				}

	    				if(check > 1 && index < 3) {
		    				do {
		    					recommendedTopic = new Topico().select("idUsuario='" + recommend.getString("poster") + "'");
		    					if( recommendedTopic.next() ) {
		    						do {
		    							int checkDuplicity = 0;
		    							for(int i = 0; i < 3; i++) {
		    								if( recommendedTopic.getInt("idTopico") == postList[i] ) {
		    									checkDuplicity++;
		    								}
		    							}
		    							
		    							if(checkDuplicity > 0) {
		    								checkDuplicity--;
		    								//evitar repetir tópicos mostrados por usuários seguidos
		    								continue;
		    							}
		    							
		    							ResultSet recommendedTopicUser = new Usuario().select("idUsuario='" + recommendedTopic.getString("idUsuario") + "'");
		    							
		    							while(recommendedTopicUser.next()) {
		    								index++;
		    								
		    								ResultSet recommendedTopicComments = new Comentario().selectCount("idTopico='" + recommendedTopic.getString("idTopico") + "'");
			    							ResultSet recommendedTopicLikes = new Likes().selectCount("idTopico='" + recommendedTopic.getString("idTopico") + "'");
			    							recommendedTopicComments.next();
			    							recommendedTopicLikes.next();
			    							
			    							out.println("<li class='lista'>");
			    							out.println("	<div class='title'>");
			    							out.println("		<a href='topic.jsp?id=" + recommendedTopic.getString("idTopico") + "'>");
			    							out.println(			recommendedTopic.getString("titulo") + "<br>");
			    							out.println("			<cite>by " + recommendedTopicUser.getString("apelido") + "</cite>");
			    							out.println("	</a></div>");
			    							
			    							out.println("	<div class='stats'>");
			    							out.println(		recommendedTopicComments.getString("count(*)"));
			    							out.println("		<img src='img/icon/comments.png'>");
			    							out.println(		recommendedTopicLikes.getString("count(*)"));
			    							out.println("		<img src='img/icon/like.png'>");
			    							out.println("</div></li>");
		    							}
		    						} while( recommendedTopic.next() && index < 3);
		    					}
		    				} while(recommend.next() && index < 3 );
	    				}
	    				
	    				out.println("</ul></div>");
	    				
	    				if(check > 1) {
	    					index = 0;
	    					recommend = new Topico().selectCondition("t.idUsuario as poster, l.idUsuario, count(l.idLike) FROM forum.topico t JOIN forum.likes l ON l.idTopico = t.idTopico AND l.idUsuario = " + userLogin + " AND l.idUsuario != t.idUsuario GROUP BY l.idUsuario, t.idUsuario ORDER BY count(l.idLike) DESC");
	    					
	    					out.println("<div id='people'>");
	    					out.println("	<h2>Usuários Recomendados</h2>");
	    					out.println("	<ul id='recommended-users'>");
	    					while( recommend.next() && index < 2 ) {
	    						ResultSet recommendedUser = new Usuario().select("idUsuario='" + recommend.getString("poster") + "'");
	    						recommendedUser.next();
	    						
	    						ResultSet recommendedUserLvl = new Level().select("exp <= '" + recommendedUser.getString("exp") + "' ORDER BY exp DESC");
	    						recommendedUserLvl.next();
	    						
	    						out.println("<li class='user'>");
	    						out.println("	<div class='person'>");
	    						out.println("		<a href='profile.jsp?id=" + recommendedUser.getString("idUsuario") + "'>");
	    						out.println("			<div class='recommended-users-pic'>");
	    						out.println("				<img class='owner-image' src='img/profile/" + recommendedUser.getString("foto") + ".jpg'>");
	    						out.println("			</div>");
	    						out.println("			<div class='owner-data'>");
	    						out.println("				<div class='owner-name'>" + recommendedUser.getString("apelido") + "</div>");
	    						out.println("				<div class='owner-level'>Lv " + recommendedUserLvl.getString("idLevel") + "</div>");
	    						out.println("	</div></a></div>");
	    						
	    						ResultSet follow = new Seguir().select("idUsuario='" + userLogin + "' AND idSeguido='" + recommendedUser.getString("idUsuario") + "'");
	    						out.println("<script type='text/javascript'>users.push('" + recommendedUser.getString("idUsuario") + "'); </script>");
	    						if(follow.next()) {
	    							out.println("	<button class='followed' id='f" + recommendedUser.getString("idUsuario") + "' type='button'>Seguindo</button>");
	    						} else {
	    							out.println("	<button class='follow' id='f" + recommendedUser.getString("idUsuario") + "' type='button'>Seguir</button>");
	    							
	    						}
	    						out.println("</li>");
	    					}
	    					out.println("</ul></div>");
	    				}
	    			}
	    			else {
    					out.println("<div id='tips'>");
    			        out.println("	<h2>Recomendado</h2>");
    			        out.println("	<ul id='tip'>");
    			        out.println("		<li class='lista'>Interaja mais para receber recomendações</li>");
    			        out.println("</ul></div>");
    				}
	    			
	    		}
	    	}
	    	else {
	    	}
	    	
	    	if(logado == 0) {
		         out.println("<div id='tips'>");
		         out.println("	<h2>Recomendado</h2>");
		         out.println("	<ul id='tip'>");
		         out.println("		<li class='lista'>");
		         out.println("			<a href='login.html'>Acesse uma conta para receber recomendações</a>");
		         out.println("</li></ul></div>");
	    	}
    	%>
    </aside>
</div>

<form id="form">
	<input type="hidden" id="followInput" name="id">
</form>

<script type="text/javascript">
	$(document).ready(
			
		function() {
			users.map(function (user) {
				$("#f" + user).click(
	           		function() {
	           			document.querySelector("#followInput").setAttribute('value', user);
	           			
	           			var formData = $("#form").serialize();
						$.post( "operation/seguir.jsp", formData, function( data, status ) {
							var objReturn = $.parseJSON( data );
							var btFollow = document.querySelector('#f' + user);
							if ( objReturn.follow == "true" ){
								btFollow.setAttribute('class', 'followed');
								btFollow.innerHTML = 'Seguindo';
							} else {
								btFollow.setAttribute('class', 'follow');
								btFollow.innerHTML = 'Seguir';
							}
						});	
	           		}
	            );
		    });
		}
	)
</script>