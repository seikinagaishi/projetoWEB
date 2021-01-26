<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Topico"%>
<%@page import="classes.Categoria"%>
<%@page import="classes.Level"%>
<%@page import="classes.Conquista"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="box">
    <h2>Título da Discussão</h2>

    <div class="container">

        <div class="info">
            <%
              	String idTopico = request.getParameter("idTopico");
				ResultSet topic = new Topico().select("idTopico='" + idTopico + "'");
				topic.next();
				
				ResultSet categoria = new Categoria().select("idCategoria='" + topic.getString("idCategoria") + "'");
				categoria.next();
			              	
				if (session.getAttribute("userlogin") != null) {
			   		int userLogin = 0; 
					userLogin = (int) session.getAttribute("userlogin");
					if ( ! (userLogin > 0 )){
						response.sendRedirect("login.jsp");
					}
					else {
						ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
						usuario.next();
						
						if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
							response.sendRedirect("ativo.jsp");
						}
						
						if( usuario.getInt("idNivelUsuario") > 1 ) {
							//moderadores ou superiores podem mover tópicos para outras categorias
							ResultSet topicUser = new Usuario().select("idUsuario='" + topic.getString("idUsuario") + "'");
							topicUser.next();
							
							ResultSet lvl = new Level().select("exp <= '" + topicUser.getString("exp") + "' ORDER BY exp DESC");
							lvl.next();
							
							out.println("<div class='owner'>");
							out.println("	<a href='profile.jsp?id=" + topicUser.getString("idUsuario") + "'>");
							
							out.println("		<div class='owner-pic'>");
							out.println("			<img class='foto' src='img/profile/" + topicUser.getString("foto") + ".jpg'>");
							out.println("		</div>");
							out.println("		<div class='owner-data'>");
							out.println("			<div class='owner-name'>" + topicUser.getString("apelido") +"</div>");
							out.println("			<div class='owner-level'>Lv " + lvl.getString("idLevel") + "</div>");
							if(topicUser.getInt("idConquista") != 0) {
								ResultSet userTitle = new Conquista().select("idConquista='" + topicUser.getString("idConquista") + "'");
			                    			userTitle.next();
			                    			out.println("		<div class='owner-title'>" + userTitle.getString("nome") + "</div>");
							}
							out.println("</div></a></div>");
							
							out.println("<textarea class='message' readonly>" + topic.getString("mensagem") + "</textarea>");
						}
						else {
							response.sendRedirect("index.html");
						}
					}
				}
			   	else {
			   		response.sendRedirect("login.jsp");
			   	}
			%>
        </div>
    </div>
        
</div>

<div class="box">
    <h2>Mover essa postagem para outra categoria</h2>

    <div class="container">
        <form id="formstd">
            <div class="moveMsg">
                Mover postagem de <strong><% out.write( categoria.getString("descricao") ); %></strong> para
	
				<% out.println("<input type='hidden' name='idTopico' value='" + idTopico + "'>"); %>
	
            	<select class="proj-form" name="idCategoria" id="idCategoria">
            	<% 
	             	ResultSet categorias = new Categoria().select("");
					while(categorias.next()) {
						if( categorias.getInt("idCategoria") == categoria.getInt("idCategoria") ) {
							out.println("<option value='" + categorias.getInt("idCategoria") + "' selected>" + categorias.getString("descricao") + "</option>");
						} else {
							out.println("<option value='" + categorias.getInt("idCategoria") + "'>" + categorias.getString("descricao") + "</option>");
						}
					}
            	%>
            </select>
            </div>
           
            <div class="form-btn-column">
                <button class="form-btn" type="button" id="btnSend">Mover</button>
                <button class="form-btn" type="button" id="btnCancel">Cancelar</button>
            </div> 
        </form>
    </div>     
</div>

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
			$("#btnSend").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/moverCategoria.jsp", formData, function( data, status ) {
						alertFunc("Movido com sucesso!")
						setTimeout(function() { window.location.href = "topic.jsp?id=<% out.write(idTopico); %>"}, 4000)
					});	
				}
			);
			
			$("#btnCancel").click(
				function() {
					window.location.href = "topic.jsp?id=<% out.write(idTopico); %>";
				}
			);
		} 
	);
	
</script>