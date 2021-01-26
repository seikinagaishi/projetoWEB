<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div id="columns">
    <aside>
        <h2>Navegação</h2>
        
        <ul>
            <li class="lista">
                <a href="profileConfig.html" class="profile-option-selected">Perfil</a>
            </li>
            <li class="lista">
                <a href="profilePrivacy.html">Privacidade</a>
            </li>
            <li class="lista">
                <a href="profilePassword.html">Mudar Senha</a>
            </li>
            <li class="lista">
                <a href="#">Modificar Título</a>
            </li>
            <li class="lista">
                <a href="operation/sair.jsp">Sair</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Mudar Dados
        </h2>

        <div class="container">
            <form id="formstd">
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
							
							String generos[] = {"masculino", "feminino", "outro"};
							
							out.println("<label for='nome'>Nome</label>");
							out.println("<input class='proj-form' name='nome' id='nome' type='text' value='" + usuario.getString("apelido") + "' readonly>");
							
									
							out.println("<label for='gender'>Gênero</label>");
							out.println("<div class='input-grid'>");
							for(int i = 0; i < 3; i++) {
								out.println("<div>");
								
								if(generos[i].equals(usuario.getString("gender"))) {
									out.println("<input class='proj-form' name='gender' id='gender' type='radio' value='" + generos[i] + "' checked>");
								}
								else {
									out.println("<input class='proj-form' name='gender' id='gender' type='radio' value='" + generos[i] + "'>");
								}
								out.println("<p class='description'>" + generos[i] + "</p>");
								out.println("</div>");
							}
							out.println("</div>");
							
							
							out.println("<label for='dataNasc'>Data de Nascimento</label>");
							out.println("<input class='proj-form' name='dataNasc' id='dataNasc' type='date' max='2021-12-31' value='" + usuario.getString("dataNasc") + "'>");
									
									
							out.println("<label for='bio'>Bio</label>");
							out.println("<textarea class='proj-form' name='bio' id='bio'>" + usuario.getString("bio") + "</textarea>");
						}
					}
				   	else {
				   		response.sendRedirect("login.jsp");
				   	}
				%>
                <div class="form-btn-column">
                    <button class="form-btn" type="button" id="btnChange">Alterar</button>
                    <button class="form-btn" type="button" id="btnCancel">Cancelar</button>
                </div>  
            </form>
        </div>
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
			$("#btnChange").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/alterarDados.jsp", formData, function( data, status ) {
						alertFunc("Informações alteradas!")
						setTimeout(function() { window.location.href = "profileConfig.html" }, 4000)
					});	
					
				}
			);
			
			$("#btnCancel").click(
				function() {
					window.location.href = "profileConfig.html";
				}
			);
		} 
	);
	
</script>