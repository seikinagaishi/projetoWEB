<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                <a href="admin.html" class="profile-option-selected">Categoria</a>
            </li>
            <li class="lista">
                <a href="adminLevel.html">Level</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Criar Categoria
        </h2>

        <div class="container">
            <form id="formstd">
                <label for="descricao">Nome</label>
                <input class="proj-form" name="descricao" id="descricao" maxlength="50" type="text">

                <button class="form-btn" type="button" id="btnSend">Criar</button>
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
			$("#btnSend").click(
				function() {
					var formData = $("#formstd").serialize();
					$.post( "operation/criarCategoria.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.criar == "true" ){
							alertFunc("Categoria criada!")
							setTimeout(function() { window.location.href = "admin.html" }, 4000)
						}
						else if(objReturn.criar == "false") {
							alertFunc("Preencha os campos!");
						}
						else {
							alertFunc("Já existe!");
						}
						
					});	
					
				}
			);
		} 
	);
	
</script>