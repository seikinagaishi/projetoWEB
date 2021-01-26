<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
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
			
			if( !(Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1) ) {
				response.sendRedirect("index.jsp");
			}
		}
   	}
   	else {
   		
   	}
%>

<div class="alertArea"></div>

<div class="small-box">
    <h2>Registro</h2>
    <div class="container">
        <form id="formstd">
            <fieldset>
                <input class="proj-form-login" name="apelido" id="apelido" type="text" maxlength="50" placeholder="Usuário">
                <input class="proj-form-login" name="email" id="email" type="email" maxlength="50" placeholder="E-mail"><br>
                <p class="description">Data de Nascimento</p>
                <input class="proj-form-login" name="dataNasc" id="dataNasc" max="2021-12-31" type="date">
                <input class="proj-form-login" name="senha" id="senha" type="password" maxlength="90" placeholder="Senha"><br>
                <input class="proj-form-login" name="senhaConfirm" id="senhaConfirm" type="password" maxlength="90" placeholder="Confirmar Senha"><br>
            
                <a class="form-link" href="login.html">Já tem conta?</a>
            </fieldset>

            <button class="form-btn" id="btnSendFrmSignup" type="button">Criar</button>
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
			$("#btnSendFrmSignup").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/registrar.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.cadastro == "true" ){
							alertFunc("Link para ativação enviado para o seu email!")
							setTimeout(function() { window.location.href = "login.html" }, 4000)
							
						} else if( objReturn.cadastro == "erro" ) {
							alertFunc("Senhas não coincidem!");
						} else {
							alertFunc("E-mail ou Apelido já em uso!");
						}
					});	
					
				}
			);
		} 
	);
	
</script>