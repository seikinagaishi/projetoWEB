<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Conquista"%>
<%@page import="classes.Conquistado"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div id="columns">
    <aside>
        <h2>Navegação</h2>
        
        <ul>
            <li class="lista">
                <a href="profileConfig.html">Perfil</a>
            </li>
            <li class="lista">
                <a href="profilePrivacy.html">Privacidade</a>
            </li>
            <li class="lista">
                <a href="profilePassword.html">Mudar Senha</a>
            </li>
            <li class="lista">
                <a href="#" class="profile-option-selected">Modificar Título</a>
            </li>
            <li class="lista">
                <a href="operation/sair.jsp">Sair</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Escolher Título
        </h2>

        <ul>
        	<%
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
						
						ResultSet titulo = new Conquista().select("");
						int titulosObtidos = 0;
						
						out.println("<script> var titles = []; </script>");
						while(titulo.next()) {
							ResultSet obtido = new Conquistado().select("idUsuario ='" + userLogin + "'");
							while(obtido.next()) {
								if(titulo.getString("idConquista").equals(obtido.getString("idConquista"))) {
									out.println("<li class='lista'>");
									out.println("<p class='lista-title' id='" + titulo.getString("idConquista") + "'>" + titulo.getString("nome") + "</p>");
									out.println("Obtido em: " + obtido.getString("aquisicao"));
									out.println("</li>");
									
									
									out.println("<script type='text/javascript'>titles.push('" + titulo.getString("idConquista") + "'); </script>");
									titulosObtidos++;
								}
							}
						}
						
						if(titulosObtidos == 0) {
							out.println("<li class='lista'>");
							out.println("<p class='lista-item'>Nenhuma conquista obtida</p>");
							out.println("</li>");
						}
					}
				}
				else {
					response.sendRedirect("login.jsp");
				}
			%>
        </ul>
    </div>
</div>

<form id="formTitle">
	<input type="hidden" id="idConquista" name="idConquista">
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
			
			titles.map(function (title) {
				$("#" + title).click(
		           		function() {
		           			document.querySelector('#idConquista').setAttribute('value', title);
		           			
		           			var formData = $("#formTitle").serialize();
							$.post( "operation/alterarTitulo.jsp", formData, function( data, status ) {
								alertFunc("Título Alterado!");
							});	
		           		}
		            );
		    });
		} 
	);
	
</script>