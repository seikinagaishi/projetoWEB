<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="box">
    <h2>Criar novo Tópico</h2>

    <div class="container">
        <form id="formstd">
            <label for="titulo">Título do Tópico</label>
            <input class="proj-form" type="text" name="titulo" id="titulo" maxlength="100">
            
            <label for="mensagem">Mensagem</label>
            <textarea class="proj-form" name="mensagem" id="mensagem"></textarea>
            
            <label for="idCategoria">Categoria</label>
            <select class="proj-form" id="idCategoria" name="idCategoria">
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
							
							ResultSet categoria = new Categoria().select("");
							while(categoria.next()) {
								out.println("<option value='" + categoria.getString("idCategoria") + "'>" + categoria.getString("descricao") + "</option>");
							}
						}
					}
				   	else {
				   		response.sendRedirect("login.jsp");
				   	}
				%>
            </select>
            <br>

            <div class="form-btn-column">
                <button class="form-btn" id="btnSend" type="button">Enviar</button>
                <button class="form-btn" id="btnCancel" type="button">Cancelar</button>
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
					$.post( "operation/criarTopico.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						
						if ( objReturn.criar == "true" ){
							alertFunc("Tópico criado!")
							setTimeout(function() { window.location.href = "topic.jsp?id=" + objReturn.topico }, 4000)
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