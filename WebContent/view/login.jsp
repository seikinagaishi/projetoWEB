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
    <h2>Login</h2>
    <div class="container">
        <form id="formstd">
            <fieldset>
                <input class="proj-form-login" name="email" id="email" type="email" maxlength="50" placeholder="E-mail"><br>
                <input class="proj-form-login" name="senha" id="senha" type="password" maxlength="90" placeholder="Senha"><br>
                <div class="link-area">
                    <a class="form-link" href="signup.html">Registre-se</a>
                    <a class="form-link" href="recovery.html">Esqueci minha senha</a>
                </div> 
            </fieldset>

            <button class="form-btn" id="btnSendFrmLogin" type="button">Entrar</button>
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
			$("#btnSendFrmLogin").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/verificar.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.login == "true" ){
							alertFunc("Login realizado com Sucesso!")
							window.location.href = "index.html";
						} else {
							alertFunc("Usuário ou Senha inválido!");
						}
					});	
					
				}
			);
		} 
	);
	
</script>