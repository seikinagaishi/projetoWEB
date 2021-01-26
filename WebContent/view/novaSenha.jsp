<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="small-box">
    <h2>Login</h2>
    <div class="container">
        <form id="formstd">
            <fieldset>
            	<%
					String idUsuario = request.getParameter("idUsuario");
					String cod 		 = request.getParameter("cod");
					
					if( idUsuario == null || cod == null ) {
						response.sendRedirect("index.html");
					} else {
						ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "' && cod='" + cod + "'");
						if(user.next()) {
							out.println("<input type='hidden' name='idUsuario' value='" + idUsuario + "'>");
							out.println("<input type='hidden' name='cod' value='" + cod + "'>");
						} else {
							response.sendRedirect("index.html");
						}
					}
				%>
            
                <input class="proj-form-login" name="senhaNova" id="senhaNova" type="password" maxlength="90" placeholder="Nova Senha"><br>
                <input class="proj-form-login" name="senhaConfirm" id="senhaConfirm" type="password" maxlength="90" placeholder="Confirmar Senha"><br>
            </fieldset>

            <button class="form-btn" id="btnSend" type="button">Mudar Senha</button>
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
						$.post( "operation/alterarSenhaPerdida.jsp", formData, function( data, status ) {
							var objReturn = $.parseJSON( data );
							if ( objReturn.alterar == "true" ){
								alertFunc("Senha Alterada!")
								setTimeout(function() { window.location.href = "login.html" }, 4000)
							}
							else if ( objReturn.alterar == "false" ) {
								alertFunc("Senhas não coincidem!")
							}
							else {
								alertFunc("Preencha os campos!")
							}
						});	
						
					}
				);
		} 
	);
	
</script>