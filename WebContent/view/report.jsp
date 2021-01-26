<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="small-box">
    <h2>Reportar</h2>
    <div class="container">
        <form id="formstd">
            <fieldset>
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
							
							String idUsuario = request.getParameter("idUsuario");
							
							ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
							user.next();
							
							out.println("<input name='idUsuario' id='idUsuario' type='hidden' value='" + idUsuario + "'> <br>");
							out.println("<input class='proj-form-login' name='apelido' id='apelido' type='text' value='" + user.getString("apelido") + "' readonly> <br>");
						}
					}
				   	else {
				   		response.sendRedirect("login.jsp");
				   	}
				%>
            	
                <select class="proj-form-login" name="tipo" id="tipo">
                    <option value="0">Spam</option>
                    <option value="1">Abuso</option>
                    <option value="2">Direitos Autorais</option>
                    <option value="3">Conteúdo Sensível</option>
                </select>
                <p class="description">Motivo</p>    
                <br>
                
                <label for="descricao">Descrição</label><br>
                <textarea class="proj-form" name="descricao" id="descricao"></textarea>
            </fieldset>

            <div class="form-btn-column">
                <button class="form-btn" type="button" id="btnSend">Denunciar</button>
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
					$.post( "operation/reportar.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						
						if ( objReturn.criar == "true" ){
							alertFunc("Reportado!")
							setTimeout(function() { window.location.href = "index.html"}, 4000)
						} else {
							alertFunc("Preencha os campos!");
						}
					});	
				}
			);
			
			$("#btnCancel").click(
				function() {
					window.location.href = "index.html";
				}
			);
		} 
	);
	
</script>