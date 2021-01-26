<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Topico"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="box">
    <h2>Responder</h2>

    <div class="container">
        <form id="formstd">
        	<label for="topico">Mensagem de Origem</label>
        	<%
        		String idTopico = request.getParameter("idTopico");
        			
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
						
						ResultSet topic = new Topico().select("idTopico ='" + idTopico + "'");
						topic.next();
						out.println("<textarea class='proj-form-readonly' name='topico' id='topico' readonly>" + topic.getString("mensagem") + "</textarea>");
						out.println("<input name='idTopico' id='idTopico' type='hidden' value='" + idTopico + "'>");
					}
				}
			   	else {
			   		response.sendRedirect("login.jsp");
			   	}
			%>
            <label for="mensagem">Resposta</label>
            <textarea class="proj-form" name="mensagem" id="mensagem"></textarea>

            <div class="form-btn-column">
                <button class="form-btn" type="button" id="btnSend">Enviar</button>
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
					$.post( "operation/responder.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.criar == "true" ){
							alertFunc("Resposta enviada!")
							setTimeout(function() { window.location.href = "topic.jsp?id=<% out.write(idTopico); %>" }, 4000)
						}
						else  {
							alertFunc("Preencha os campos!");
						}	
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