<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Conquista"%>
<%@page import="classes.Conquistado"%>
<%@page import="classes.Level"%>
<%@page import="classes.Seguir"%>
<%@page import="classes.LogEXP"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String idUsuario = request.getParameter("idUsuario");	

	ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
	user.next();
	
	ResultSet lvl = new Level().select("exp <= '" + user.getString("exp") + "' ORDER BY exp DESC");
	lvl.next();
	
	int lv = Integer.valueOf(lvl.getString("idLevel")) + 1;
	
	ResultSet nextLvl = new Level().select("idLevel ='" + lv + "'");
	if(nextLvl.next()) {
		//Pegar 1 level acima do usuário para comparar o exp que falta para subir de level
	} else {
		nextLvl = new Level().select("idLevel='" + lvl.getString("idLevel") + "'");
		nextLvl.next();
		//Usuário alcançou level máximo
	}
	
	
	float expDif = ( Float.valueOf(user.getString("exp")) / Float.valueOf(nextLvl.getString("exp")) * 100 );
	//calcular a % da barra de exp
%>

<div class="alertArea"></div>

<div class="box">
    <h2>Perfil do <% out.write(user.getString("apelido")); %></h2>

    <div class="container">
        <div class="user-btns">
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
	        			if( Integer.valueOf(usuario.getString("idNivelUsuario")) > 1) {
	        				if( Integer.valueOf(user.getString("idNivelUsuario")) > 1 ) {
	        					
	        				}
	        				else {
	        					if( user.getString("banido").equals("1") ) {
		        					out.println("<img class='icon' id='ban' src='img/icon/unban.png' title='Desbanir Usuário'>");
		        				} else {
		        					out.println("<img class='icon' id='ban' src='img/icon/ban.png' title='Banir Usuário'>");
		        				}
	        				}
	        				
	        				if(Integer.valueOf(usuario.getString("idNivelUsuario")) == 3) {
	        					if( user.getString("idNivelUsuario").equals("1") ) {
		        					out.println("<img class='icon' id='promote' src='img/icon/crown.png' title='Promover Usuário a Moderador'>");
		        				} else {
		        					out.println("<img class='icon' id='promote' src='img/icon/crown2.png' title='Remover Moderador'>");
		        				}
	        				}
	        				else {
	        					if( user.getString("idNivelUsuario").equals("1") ) {
		        				} else {
		        					out.println("<img class='icon' src='img/icon/crown2.png' title='Moderador'>");
		        				}
	        				}
	        				
	        			}
	        			else {
	        			}
	        		}
	        	}
	        	else {
	        		
	        	}
        	
        		out.println("<img class='icon' id='report' src='img/icon/flag.png' title='Reportar Usuário'>");
        	%>
        </div>

       <div id="profile">
            <div class="owner">
                <a>
                    <div class="owner-pic">
                        <img class="foto" src="img/profile/<% out.write(user.getString("foto")); %>.jpg" title="<% out.write(user.getString("apelido")); %>">
                        
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
	        	        			
	        	        			if( user.getString("idUsuario").equals(userLogin + "") ) {
	        	        				out.println("<img class='icon' id='editBtn' src='img/icon/edit2.png' title='Alterar Imagem'>");
	        	        			} else {
	        	        				
	        	        			}
	        	        		}
	        	        	}
	        	        	else {
	        	        		
	        	        	}
                        %>
                    </div>
                    <div class="owner-data">
                        <div class="owner-name"><% out.write(user.getString("apelido")); %></div>
                       	<% 
                       		if( user.getString("idConquista").equals("0") ) {
                       			
                       		}
                       		else {
                       			ResultSet userTitle = new Conquista().select("idConquista='" + user.getString("idConquista") + "'");
                       			userTitle.next();
                       			out.println("<div class='owner-title'>" + userTitle.getString("nome") + "</div>");
                       		}
                       	%>
						
                        <div class="owner-level">Lv <% out.write(lvl.getString("idLevel")); %></div>
                        <div class="owner-exp">
                            Exp: <% out.write(user.getString("exp")); %>/<% out.write(nextLvl.getString("exp")); %>
                            <div class="owner-exp-bar"></div> 
                        </div>
                    </div>
                    
                </a>
            </div>

            <div class="owner-info">
            	<div class="owner-personal">
                	<% 
                		int logado;
                		int userF = 0;
	                	if (session.getAttribute("userlogin") != null) {
	    	        		
	    	        	  	int userLogin = 0;
	    	        		userLogin = (int) session.getAttribute("userlogin");
	    	        		if ( ! (userLogin > 0 )){
	    	        			logado = 0;
	    	        		}
	    	        		else {
	    	        			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
	    	        			usuario.next();
	    	        			
	    	        			if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
	    	        				response.sendRedirect("ativo.jsp");
	    	        			}
	    	        			
	    	        			if( user.getString("idUsuario").equals(userLogin + "") ) {
	    	        				logado = userLogin;
	    	        			} else {
	    	        				logado = 0;
	    	        				userF = userLogin;
	    	        			}
	    	        		}
	    	        	}
	    	        	else {
	    	        		logado = 0;
	    	        	}
                	
                		if( user.getString("privado").equals("0") || logado > 0 ) {
                			out.println("	<div class='owner-personal-data'>");
                			out.println("		<div class='owner-tag'>Data de Nascimento</div>");
                			out.println("		<div class='owner-tag-data'>" + user.getString("dataNasc") + "</div>");
                			out.println("	</div>");
                			
                			out.println("	<div class='owner-personal-data'>");
                			out.println("		<div class='owner-tag'>Gênero</div>");
                			out.println("		<div class='owner-tag-data'>" + user.getString("gender") + "</div>");
                			out.println("	</div>");
                			
                			out.println("	<div class='owner-personal-data'>");
                			out.println("		<div class='owner-tag'>Última vez online</div>");
                			out.println("		<div class='owner-tag-data'>" + user.getString("ultimaSessao") + "</div>");
                			out.println("	</div>");
                			
                			out.println("	<div class='owner-personal-data'>");
                			out.println("		<div class='owner-tag'>Registrou-se em</div>");
                			out.println("		<div class='owner-tag-data'>" + user.getString("dataInsc") + "</div>");
                			out.println("</div>");
                		}
                		else {
                			
                		}
                		
                		if( logado > 0 ) {
	        				
	        			} else {
	        				ResultSet follow = new Seguir().select("idUsuario='" + userF + "' AND idSeguido='" + idUsuario + "'");
    	        			if(follow.next()) {
    	        				out.println("<button class='followed2' id='btnFollow' type='button'>Seguindo</button>");
    	        			} else {
    	        				out.println("<button class='follow2' id='btnFollow' type='button'>Seguir</button>");
    	        			}
	        			}
                	%>
                </div>
                <div class="owner-bio">
                    <div class="owner-tag" id="bio-tag">Bio</div>
                    <div class="owner-tag-data" id="bio-data">
                        <% out.write(user.getString("bio")); %>
                    </div>
                </div>
            </div>
       </div>
    </div>  
</div>

<div id="columns">
    <aside>
        <h2>Navegação</h2>
        
        <ul>
            <li class="lista">
                <a href="#" class="profile-option-selected">Conquistas</a>
            </li>
            <li class="lista">
                <a href="profilePost.jsp?id=<% out.write(idUsuario); %>">Postagens</a>
            </li>
            <li class="lista">
                <a href="profileComment.jsp?id=<% out.write(idUsuario); %>">Comentários</a>
            </li>
            <li class="lista">
                <a href="profileFollowing.jsp?id=<% out.write(idUsuario); %>">Seguindo</a>
            </li>
            <li class="lista">
                <a href="profileFollowed.jsp?id=<% out.write(idUsuario); %>">Seguidores</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2>Títulos</h2>

        <div class="container" id="owner-history">
        	<%
            	if (session.getAttribute("userlogin") != null) {
        		
		       	  	int userLogin = 0;
		       		userLogin = (int) session.getAttribute("userlogin");
		       		if ( ! (userLogin > 0 )){
		       			
		       		}
		       		else {
		       			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
		       			usuario.next();
		       			
		       			if( user.getString("idUsuario").equals(userLogin + "") ) {
		       				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		       				LocalDateTime now = LocalDateTime.now();
		       				
		       				out.println("<table class='achievement'>");
		       				out.println("	<tr>");
		       				out.println("		<td colspan='2'><strong>Missões Diárias</strong></td>");
		       				out.println("	</tr>");
		       				
		       				out.println("	<tr>");
		       				out.println("		<td><strong>EXP Diário</strong></td>");
		       				out.println("		<td><strong>Situação</strong></td>");
		       				out.println("	</tr>");
		       				
		       				out.println("	<tr>");
		       				out.println("		<td>Login</td>");
		       				ResultSet log = new LogEXP().selectCount("idUsuario='" + userLogin + "' AND qtd='3' AND data='" + dtf.format(now) + "'");
		       				log.next();
		       				out.println("		<td>" + log.getString("count(*)") + "/1</td>");
		       				out.println("	</tr>");
		       				out.println("	<tr>");
		       				out.println("		<td>Gostar de Tópicos</td>");
		       				log = new LogEXP().selectCount("idUsuario='" + userLogin + "' AND qtd='5' AND data='" + dtf.format(now) + "'");
		       				log.next();
		       				out.println("		<td>" + log.getString("count(*)") + "/5</td>");
		       				out.println("	</tr>");
		       				out.println("	<tr>");
		       				out.println("		<td>Criar Tópicos</td>");
		       				log = new LogEXP().selectCount("idUsuario='" + userLogin + "' AND qtd='10' AND data='" + dtf.format(now) + "'");
		       				log.next();
		       				out.println("		<td>" + log.getString("count(*)") + "/2</td>");
		       				out.println("	</tr>");
		       				out.println("</table>");
		       			}
		       		}
		       	}
		       	else {
	        		
	        	}
              %>
        
            <table class="achievement">
            	<tr>
        			<td colspan="2"><strong>Conquista</strong></td>
        		</tr>
            
                <tr>
                    <td><strong>Título</strong></td>
                    <td><strong>Objetivo</strong></td>
                </tr>
                
                <%
	                ResultSet title = new Conquista().select("");
                	
	            	while(title.next()) {
	            		ResultSet titleAcquired = new Conquistado().select("idUsuario ='" + idUsuario + "' AND idConquista ='" + title.getString("idConquista") + "'");
	            		
	            		out.println("<tr>");
	            		out.println("	<td>" + title.getString("nome") + "</td>");
	            		
            			if( titleAcquired.next() ) {
            				out.println("	<td>Obtido</td>");
            			} else {
            				out.println("	<td>" + title.getString("descricao") + "<br> </td>");
            			}
            			
            			out.println("</tr>");
	            	}
                %>
            </table>       	
        </div>
    </div>
</div>

<form id="form">
	<input type="hidden" name="id" value="<% out.write(idUsuario); %>">
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
			var progressBar = document.querySelector('.owner-exp-bar');
			progressBar.style.width = '<% out.write(Math.round(expDif) + ""); %>%';

			$("#btnFollow").click(
				function() {
					var formData = $("#form").serialize();
					$.post( "operation/seguir.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						var btFollow = document.querySelector('#btnFollow');
						
						if ( objReturn.follow == "true" ){
							btFollow.setAttribute('class', 'followed2');
							btFollow.innerHTML = 'Seguindo';
						} else {
							btFollow.setAttribute('class', 'follow2');
							btFollow.innerHTML = 'Seguir';
						}
					});	
					
				}
			);
			
			$("#report").click(
				function() {
					window.location.href = "report.jsp?id=<% out.write(idUsuario); %>";
				}
			);
			
			$(".owner-pic #editBtn").click(
				function() {
					window.location.href = "changePic.jsp?id=<% out.write(idUsuario); %>";
				}
			);
			
			$("#promote").click(
				function() {
					var formData = $("#form").serialize();
					$.post( "operation/promover.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						var btMod = document.querySelector('#promote');
						
						if ( objReturn.mod == "true" ){
							btMod.setAttribute('src', 'img/icon/crown2.png');
						} else if( objReturn.mod == "false" ) {
							btMod.setAttribute('src', 'img/icon/crown.png');
						} else {
							alertFunc("Não pode fazer isso");
						}
					});	
					
				}
			);
			
			$("#ban").click(
				function() {
					var formData = $("#form").serialize();
					$.post( "operation/banir.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						var btBan = document.querySelector('#ban');
						
						if ( objReturn.ban == "true" ){
							btBan.setAttribute('src', 'img/icon/unban.png');
							btBan.setAttribute('title', 'Desbanir Usuário');
						} else  {
							btBan.setAttribute('src', 'img/icon/ban.png');
							btBan.setAttribute('title', 'Banir Usuário');
						}
					});	
					
				}
			);
			
		} 
	);
	
</script>