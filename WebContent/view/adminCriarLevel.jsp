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
                <a href="admin.html">Categoria</a>
            </li>
            <li class="lista">
                <a href="adminLevel.html" class="profile-option-selected">Level</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Criar Level
        </h2>

        <div class="container">
            <form id="formstd">
                <label for="idLevel">Level</label>
                <input class="proj-form" name="idLevel" id="idLevel" type="number">
                
                <label for="exp">Experiência Necessária</label>
                <input class="proj-form" name="exp" id="exp" type="number">

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
					$.post( "operation/criarLevel.jsp", formData, function( data, status ) {
						var objReturn = $.parseJSON( data );
						if ( objReturn.criar == "true" ){
							alertFunc("Level criado!")
							setTimeout(function() { window.location.href = "adminLevel.html" }, 4000)
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