<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Comentario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

<div class="box">
    <h2>Editar</h2>

    <div class="container">
        <form id="formstd">
            <label for="editable-content">Editar</label>
            
            <%
	            String idComentario = request.getParameter("idComentario");
				
				ResultSet comment = new Comentario().select("idComentario='" + idComentario + "'");
				comment.next();
				
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
						
						out.println("<input type='hidden' name='idComentario' value='" + idComentario + "'>");
						out.println("<input type='hidden' name='idTopico' value='" + comment.getString("idTopico") + "'>");
						out.println("<textarea class='proj-form' name='mensagem' id='mensagem'>" + comment.getString("mensagem") + "</textarea>");
					}
				}
			   	else {
			   		response.sendRedirect("login.jsp");
			   	}
            %>

            <div class="form-btn-column">
                <button class="form-btn" type="button" id="btnEdit">Editar</button>
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
			$("#btnEdit").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/editarResposta.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.editar == "true" ){
							alertFunc("Resposta editada!")
							setTimeout(function() { window.location.href = "topic.jsp?id=<% out.write(comment.getString("idTopico")); %>" }, 4000)
						}
						else  {
							alertFunc("Preencha os campos!");
						}	
					});	
					
				}
			);
			
			$("#btnCancel").click(
				function() {
					window.location.href = "topic.jsp?id=<% out.write(comment.getString("idTopico")); %>";
				}
			);
		} 
	);
	
</script>