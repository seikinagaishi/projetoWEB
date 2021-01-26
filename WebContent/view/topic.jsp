<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Comentario"%>
<%@page import="classes.Categoria"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Likes"%>
<%@page import="classes.Conquista"%>
<%@page import="classes.Level"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div id="directory">
	<a href="index.html">home</a> /
	<a href="categorias.html">categorias</a> /
	<%
		String idTopico = request.getParameter("idTopico");
	
		ResultSet topic = new Topico().select("idTopico='" + idTopico + "'");
		
		topic.next();
		
		ResultSet categoria = new Categoria().select("idCategoria='" + topic.getString("idCategoria") + "'");
		categoria.next();
		
		ResultSet op = new Usuario().select("idUsuario='" + topic.getString("idUsuario") + "'");
		op.next();
		
		ResultSet lvl = new Level().select("exp <= '" + op.getString("exp") + "' ORDER BY exp DESC");
		lvl.next();
		
		ResultSet qtdComentarioOP = new Comentario().selectCount("idTopico = '" + topic.getString("idTopico") + "'");
		qtdComentarioOP.next();
		
		ResultSet qtdLikesOP = new Likes().selectCount("idTopico = '" + topic.getString("idTopico") + "'");
		qtdLikesOP.next();
		
		ResultSet comentario = new Comentario().select("idTopico = '" + topic.getString("idTopico") + "'");
		
		out.println("<a href='listaTopicos.jsp?id=" + categoria.getString("idCategoria") + "'>" + categoria.getString("descricao") + "</a> /");
		out.println("<a href='#'>" + topic.getString("titulo") + "</a>");
		
	%>

</div>

<div class="box">
	
    <h2><% out.write(topic.getString("titulo")); %></h2>

    <div class="container">
        <div class="user-btns">
            <img class="icon" id="opReport" src="img/icon/flag.png" title="Reportar Usuário">
            <%
	            if (session.getAttribute("userlogin") != null) {
	            	int userLogin = 0;
		    		userLogin = (int) session.getAttribute("userlogin");
		    		if ( ! (userLogin > 0 )){
		    		}
		    		else {
		    			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
		    			usuario.next();
		    			
		    			if( Integer.valueOf(usuario.getString("idNivelUsuario")) > 1 ) {
		    				out.println("<img class='icon' id='opTransfer' src='img/icon/transfer.png' title='Mover Tópico'>");
		    			}
		    			
		    			if( topic.getString("idUsuario").equals(usuario.getString("idUsuario")) ) {
		    				
		    				out.println("<img class='icon' id='opEdit' src='img/icon/edit.png' title='Editar'>");
		    				out.println("<img class='icon' id='opDelete' src='img/icon/delete.png' title='Deletar'>");
		    			}
		    			else if ( usuario.getInt("idNivelUsuario") > 1 ) {
		    				out.println("<img class='icon' id='opDelete' src='img/icon/delete.png' title='Deletar'>");
		    			}
		    		}
	            }
	            else {
	            	
	            } 
            %>
        </div>

        <div class="info">
            <div class="owner">
                <a href="profile.jsp?id=<% out.write(op.getString("idUsuario")); %>">
                    <div class="owner-pic">
                        <img class="owner-pic" src="img/profile/<% out.write(op.getString("foto")); %>.jpg">
                    </div>
                    <div class="owner-data">
                        <div class="owner-name"><% out.write(op.getString("apelido")); %></div>
                        <div class="owner-level">Lv <% out.write(lvl.getString("idLevel")); %>
                        </div>
                       	<% 
                       		if( op.getString("idConquista").equals("0") ) {
                       			
                       		}
                       		else {
                       			ResultSet opTitle = new Conquista().select("idConquista='" + op.getString("idConquista") + "'");
                       			opTitle.next();
                       			out.println("<div class='owner-title'>" + opTitle.getString("nome") + "</div>");
                       		}
                       	%>
                    </div>
                </a>
            </div>

            <textarea class="message" readonly><% out.write(topic.getString("mensagem")); %></textarea>
        </div>

        <div class="stats">
        	<span class="day"><% out.write(topic.getString("data")); %></span>
        
            <a class="reply" id="opReply" href="reply.jsp?id=<% out.write(topic.getString("idTopico")); %>">Responder</a>

            <div class="comments">
                <span id="numComments"><% out.write(qtdComentarioOP.getString("count(*)")); %></span>
                <br>
                <img src="img/icon/comments.png" title="Comentários">
            </div>

            <div class="likes">
                <span id="numLikesMain"><% out.write(qtdLikesOP.getString("count(*)")); %></span>
                <br>
                
                <%
		            if (session.getAttribute("userlogin") != null) {
		            	int userLogin = 0;
			    		userLogin = (int) session.getAttribute("userlogin");
			    		if ( ! (userLogin > 0 )){
			    			out.println("<img class='icon' id='opLike' src='img/icon/like.png' title='Gostei'>");
			    		}
			    		else {
			    			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			    			usuario.next();
			    			
			    			ResultSet opLiked = new Likes().select("idUsuario='" + userLogin + "' AND idTopico='" + topic.getString("idTopico") + "'");
			    			if(opLiked.next()) {
			    				out.println("<img class='icon' id='opLike' src='img/icon/like2.png' title='Gostei'>");
			    			}
			    			else {
			    				out.println("<img class='icon' id='opLike' src='img/icon/like.png' title='Gostei'>");
			    			}
			    		}
		            }
		            else {
		            	out.println("<img class='icon' id='opLike' src='img/icon/like.png' title='Gostei'>");
		            } 
	            %>
            </div>
        </div>
    </div>
        
</div>

<div class="box">
	<% 
		if( Integer.valueOf(qtdComentarioOP.getString("count(*)")) > 0 ) {
			out.println("<h2>Comentários</h2>");
			out.println("<div id='comments'>");
		}
	
		int comentarioIndex = 0;
		out.println("<script type='text/javascript'>var comentarios = [], users = []; </script>");
		
		while(comentario.next()) {
			out.println("<script type='text/javascript'>comentarios.push('" + comentario.getString("idComentario") + "'); users.push('" + comentario.getString("idUsuario") + "'); </script>");
			comentarioIndex++;
			
			ResultSet commentUser = new Usuario().select("idUsuario='" + comentario.getString("idUsuario") + "'");
			commentUser.next();
			
			ResultSet commentLvl = new Level().select("exp <= '" + commentUser.getString("exp") + "' ORDER BY exp DESC");
			commentLvl.next();
			
			ResultSet qtdLikesComment = new Likes().selectCount("idComentario = '" + comentario.getString("idComentario") + "'");
			qtdLikesComment.next();
			
			
			out.println("<div class='container' id='c" + comentario.getString("idComentario") + "'>");
			out.println("	<h2 class='comentario'>#" + comentarioIndex + "</h2> <br>");
			
			out.println("	<div class='user-btns'>");
			out.println("		<img class='icon' id='report" + comentario.getString("idUsuario") + "' src='img/icon/flag.png' title='Reportar Usuário'>");
			
			
			if (session.getAttribute("userlogin") != null) {
            	int userLogin = 0;
	    		userLogin = (int) session.getAttribute("userlogin");
	    		if ( ! (userLogin > 0 )){
	    		}
	    		else {
	    			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
	    			usuario.next();
	    			
	    			if( comentario.getString("idUsuario").equals(usuario.getString("idUsuario")) ) {
	    				out.println("<img class='icon' id='edit" + comentario.getString("idComentario") + "' src='img/icon/edit.png' title='Editar'>");
	    				out.println("<img class='icon' id='delete" + comentario.getString("idComentario") + "' src='img/icon/delete.png' title='Deletar'>");
	    			} else if ( usuario.getInt("idNivelUsuario") > 1 ) {
	    				out.println("<img class='icon' id='delete" + comentario.getString("idComentario") + "' src='img/icon/delete.png' title='Deletar'>");
	    			}
	    		}
            }
            else {
            }
			
			out.println("	</div>");
			
			out.println("	<div class='info'>");
			out.println("		<div class='owner'><a href='profile.jsp?id=" + commentUser.getString("idUsuario") + "'>");
			out.println("			<div class='owner-pic'> <img class='foto' src='img/profile/" + commentUser.getString("foto") + ".jpg'> </div>");
			
			out.println("			<div class='owner-data'>");
			out.println("				<div class='owner-name'>" + commentUser.getString("apelido") + "</div>");
			out.println("				<div class='owner-level'>Lv " + commentLvl.getString("idLevel") + "</div>");
			
			if( commentUser.getString("idConquista").equals("0") ) {
       			
       		}
       		else {
       			ResultSet commentTitle = new Conquista().select("idConquista='" + commentUser.getString("idConquista") + "'");
       			commentTitle.next();
       			out.println("			<div class='owner-title'>" + commentTitle.getString("nome") + "</div>");
       		}
			
			
			out.println("			</div>");
			out.println("		</a></div>");
			
			out.println("		<div class='message'>" + comentario.getString("mensagem") + "</div>");
			out.println("	</div>");
			
			out.println("	<div class='stats-topic'>");
			out.println("		<span class='day'>" + comentario.getString("data") + "</span>");
			out.println("		<div class='likes'>");
			out.println("			<span id='numLikes" + comentario.getString("idComentario") + "'>" + qtdLikesComment.getString("count(*)") + "</span> <br>");
			
			if (session.getAttribute("userlogin") != null) {
            	int userLogin = 0;
	    		userLogin = (int) session.getAttribute("userlogin");
	    		if ( ! (userLogin > 0 )){
	    			out.println("<img class='icon' id='like" + comentario.getString("idComentario") + "' src='img/icon/like.png' title='Gostei'>");
	    		}
	    		else {
	    			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
	    			usuario.next();
	    			
	    			ResultSet commentLiked = new Likes().select("idUsuario='" + userLogin + "' AND idComentario='" + comentario.getString("idComentario") + "'");
	    			if(commentLiked.next()) {
	    				out.println("<img class='icon' id='like" + comentario.getString("idComentario") + "' src='img/icon/like2.png' title='Gostei'>");
	    			}
	    			else {
	    				out.println("<img class='icon' id='like" + comentario.getString("idComentario") + "' src='img/icon/like.png' title='Gostei'>");
	    			}
	    		}
            }
            else {
            	out.println("<img class='icon' id='like" + comentario.getString("idComentario") + "' src='img/icon/like.png' title='Gostei'>");
            } 
			out.println("</div></div></div>");
		}
		
		if( Integer.valueOf(qtdComentarioOP.getString("count(*)")) > 0 ) {
			out.println("</div>");
		}
	%>    
    </div>     
</div>

<form id="formLike">
	<input type="hidden" id="id" name="id">
	<input type="hidden" id="tipo" name="tipo">
</form>

<form id="formDel">
	<input type="hidden" id="id2" name="id">
	<input type="hidden" id="tipo2" name="tipo">
</form>

<script type="text/javascript">
	function alertFunc(message) {
		var alertBox = document.createElement('div')
	    alertBox.setAttribute('class', 'alertMsg')
	    alertBox.appendChild(document.createTextNode(message))
	    document.querySelector('.alertArea').appendChild(alertBox);
	    setTimeout(function() { document.querySelector('.alertArea').removeChild(alertBox) }, 4000)
	}

	$(document).ready(
			
		function() {
			users.map(function (user) {
				$("#report" + user).click(
	           		function() {
	           			window.location.href = "report.jsp?id=" + user;
	           		}
	            );
		    });
			
			comentarios.map(function (comentario) {
				$("#like" + comentario).click(
	           		function() {
	           			document.querySelector('#id').setAttribute('value', comentario);
	           			document.querySelector('#tipo').setAttribute('value', 2);
	           			
	           			var formData = $("#formLike").serialize();
						$.post( "operation/gostar.jsp", formData, function( data, status ) {
							var objReturn = $.parseJSON( data );
							var likeButton = document.querySelector("#like" + comentario);
							var likeNumber = document.querySelector("#numLikes" + comentario);
							var n = parseInt(likeNumber.innerHTML);
							
							if ( objReturn.like == "true" ){
								likeButton.setAttribute('src', 'img/icon/like2.png');
								likeNumber.innerHTML = n + 1;
							} else {
								likeButton.setAttribute('src', 'img/icon/like.png');
								likeNumber.innerHTML = n - 1;
							}
						});	
	           		}
	            );
				
				$("#edit" + comentario).click(
					function() {
						window.location.href = "editReply.jsp?id=" + comentario;
					}
				);
				
				$("#delete" + comentario).click(
					function() {	
						document.querySelector('#id2').setAttribute('value', comentario);
	           			document.querySelector('#tipo2').setAttribute('value', 2);
	           			var formData = $("#formDel").serialize();
						$.post( "operation/deletar.jsp", formData, function( data, status ) {
							alertFunc("Comentário Deletado!");
							document.querySelector('#comments').removeChild(document.querySelector('#c' + comentario));
							var n = document.querySelector('#numComments');
							n.innerHTML = parseInt(n.innerHTML) - 1;
							
							if( parseInt(n.innerHTML) == 0 ) {
								document.querySelectorAll(".box")[1].innerHTML = "";
							}
						});	
	           		}
				);
		    });
			
			$("#opLike").click(
           		function() {
           			document.querySelector('#id').setAttribute('value', <% out.write(topic.getString("idTopico")); %>);
           			document.querySelector('#tipo').setAttribute('value', 1);
           			
           			var formData = $("#formLike").serialize();
					$.post( "operation/gostar.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						var likeButton = document.querySelector("#opLike");
						var likeNumber = document.querySelector("#numLikesMain");
						var n = parseInt(likeNumber.innerHTML);
						
						if ( objReturn.like == "true" ){
							likeButton.setAttribute('src', 'img/icon/like2.png');
							likeNumber.innerHTML = n + 1;
						} else {
							likeButton.setAttribute('src', 'img/icon/like.png');
							likeNumber.innerHTML = n - 1;
						}
					});	
           		}
            );
			
			$("#opReport").click(
				function() {
					window.location.href = "report.jsp?id=<% out.write(op.getString("idUsuario")); %>";
				}
			);
			
			$("#opTransfer").click(
				function() {
					window.location.href = "moverCategoria.jsp?id=<% out.write(topic.getString("idTopico")); %>";
				}
			);
			
			$("#opEdit").click(
				function() {
					window.location.href = "editTopic.jsp?id=<% out.write(topic.getString("idTopico")); %>";
				}
			);
			
			$("#opDelete").click(
				function() {	
					document.querySelector('#id2').setAttribute('value', <% out.write(topic.getString("idTopico")); %>);
           			document.querySelector('#tipo2').setAttribute('value', 1);
           			var formData = $("#formDel").serialize();
					$.post( "operation/deletar.jsp", formData, function( data, status ) {
						alertFunc("Tópico Deletado!");
						setTimeout(function() { window.location.href = "index.html" }, 4000);
					});	
           		}
			);
		} 
	);
	
</script>