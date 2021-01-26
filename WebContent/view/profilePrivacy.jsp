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
                <a href="profileConfig.html">Perfil</a>
            </li>
            <li class="lista">
                <a href="#" class="profile-option-selected">Privacidade</a>
            </li>
            <li class="lista">
                <a href="profilePassword.html">Mudar Senha</a>
            </li>
            <li class="lista">
                <a href="profileTitle.html">Modificar Título</a>
            </li>
            <li class="lista">
                <a href="operation/sair.jsp">Sair</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Privacidade
        </h2>

        <ul>
            <li class="lista">
                <p class="lista-item">Visibilidade das minhas informações</p>
                <form id="formPrivate">
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
							
							if( Integer.valueOf(usuario.getString("privado")) == 0 ) {
								out.println("<img class='icon' src='img/icon/view.png' id='btnChange' title='Público'>");
								out.println("<input type='hidden' name='privado' id='privado' value='1'>");
							}
							else {
								out.println("<img class='icon' src='img/icon/private.png' id='btnChange' title='Somente Eu'>");
								out.println("<input type='hidden' name='privado' id='privado' value='0'>");
							}
						}
				   	}
				   	else {
				   		response.sendRedirect("login.jsp");
				   	}
				%>
				</form>
            </li>
        </ul>
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
					var formData = $("#formPrivate").serialize();
					$.post( "operation/alterarPrivado.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						
						var privacyStatus = document.querySelector('#btnChange');
						var privacyValue  = document.querySelector('#privado');
						
						if ( objReturn.privado == "false" ){
							alertFunc("Todos podem ver");
							privacyStatus.setAttribute('src', 'img/icon/view.png');
							privacyStatus.setAttribute('title', 'Público');
							privacyValue.setAttribute('value', '1');
						} else {
							alertFunc("Somente eu posso ver");
							privacyStatus.setAttribute('src', 'img/icon/private.png');
							privacyStatus.setAttribute('title', 'Somente Eu');
							privacyValue.setAttribute('value', '0');
						}
					});	
					
				}
			);
		} 
	);
	
</script>