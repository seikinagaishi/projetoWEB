<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

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
		}
	}
	else {
		response.sendRedirect("login.jsp");
	}
%>

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
                <a href="#" class="profile-option-selected">Mudar Senha</a>
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
            Mudar Senha
        </h2>

        <div class="container">
            <form id="formstd">
                <label for="senhaAtual">Senha Atual</label>
                <input class="proj-form" name="senhaAtual" id="senhaAtual" maxlength="90" type="password" required>

                <label for="senhaNova">Nova senha</label>
                <input class="proj-form" name="senhaNova" id="senhaNova" maxlength="90" type="password" required>

                <label for="senhaConfirm">Confirmar Senha</label>
                <input class="proj-form" name="senhaConfirm" id="senhaConfirm" maxlength="90" type="password">

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
					$.post( "operation/alterarSenha.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.alterar == "true" ){
							alertFunc("Senha Alterada!")
							setTimeout(function() { window.location.href = "profileConfig.html" }, 4000)
						}
						else if ( objReturn.alterar == "false" ) {
							alertFunc("Senhas não coincidem!")
						}
						else if ( objReturn.alterar == "empty" ) {
							alertFunc("Preencha os campos!")
						}
						else {
							alertFunc("Senha Incorreta!");
						}
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