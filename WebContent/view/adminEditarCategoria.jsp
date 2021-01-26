<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String idCategoria = request.getParameter("idCategoria");
	if(idCategoria == null) {
		response.sendRedirect("index.jsp");
	}
	ResultSet category = new Categoria().select("idCategoria='" + idCategoria + "'");
	category.next();

	if (session.getAttribute("userlogin") != null) {
		int userLogin = 0; 
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
			response.sendRedirect("login.jsp");
		}
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("idNivelUsuario")) != 3) {
				response.sendRedirect("login.jsp");
			}
		}
	}
	else {
		response.sendRedirect("login.jsp");
	}
%>

<div class="alertArea"></div>

<div id="columns">
    <aside>
        <h2>Navegação</h2>
        
        <ul>
            <li class="lista">
                <a href="adminTitle.html">Título</a>
            </li>
            <li class="lista">
                <a href="#" class="profile-option-selected">Categoria</a>
            </li>
            <li class="lista">
                <a href="adminLevel.html">Level</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Editar Categoria
        </h2>

        <div class="container">
            <form id="formstd">
                <label for="descricao">Nome</label>
                <input type="hidden" name="idCategoria" value="<% out.write(category.getString("idCategoria")); %>">
                <input class="proj-form" name="descricao" id="descricao" maxlength="50" type="text" value="<% out.write(category.getString("descricao")); %>">

                <div class="form-btn-column">
	                <button class="form-btn" type="button" id="btnEdit">Editar</button>
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
			$("#btnEdit").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/editarCategoria.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.alterar == "true" ){
							alertFunc("Categoria editada!")
							setTimeout(function() { window.location.href = "admin.html" }, 4000)
						}
						else {
							alertFunc("erro!");
						}
						
					});	
					
				}
			);
			
			$("#btnCancel").click(
				function() {
					window.location.href = "admin.html";
				}
			);
		} 
	);
	
</script>