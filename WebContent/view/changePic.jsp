<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>

<div class="alertArea"></div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="small-box">
    <h2>Alterar Foto</h2>
    <div class="container">
        <form id="formstd" enctype="multipart/form-data">
        	<input type="hidden" id="pic" name="foto">
            	<%
	            	String idUsuario = request.getParameter("idUsuario");
	            	
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
	            			
	            			if( !(idUsuario.equals(userLogin + "")) ) {
	            				response.sendRedirect("login.jsp");
	            			} 
	            			else {
	            				out.println("<script type='text/javascript'>var pics = []; </script>");
	            				
	            				out.println("<div id='pics-showcase'>");
	            				for(int i = 0; i < 5; i++) {
	            					if( !(usuario.getString("foto").equals("foto" + i)) ) {
	            						out.println("<div class='owner-pic'> <img class='foto' id='foto" + i +"' src='img/profile/foto" + i + ".jpg'> </div>");
	            						out.println("<script type='text/javascript'>pics.push('" + i + "'); </script>");
	            					}
	            				}
	            				out.println("</div>");
	            			}
	    					
	            		}
	            	}
	            	else {
	            		response.sendRedirect("login.jsp");
	            	}
            	%>

            <button class="form-btn" type="button" id="btnCancel">Cancelar</button>
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
			pics.map(function (pic) {
				$("#foto" + pic).click(
	           		function() {
	           			document.querySelector("#pic").setAttribute('value', 'foto' + pic);
	           			
	           			var formData = $("#formstd").serialize();
						$.post( "operation/trocaFoto.jsp", formData, function( data, status ) {
							var objReturn = $.parseJSON( data );
							if ( objReturn.alterar == "true" ){
								alertFunc("Imagem Alterada!");
								setTimeout(function() { window.location.href = "profile.jsp?id=" + <% out.write(idUsuario); %> }, 4000)
							} else {
								alertFunc("Erro!");
							}
						});	
	           		}
	            );
		    });
			
			$("#btnCancel").click(
				function() {
					window.location.href = "profile.jsp?id=<% out.write(idUsuario); %>";
				}
			);
		} 
	);
	
</script>