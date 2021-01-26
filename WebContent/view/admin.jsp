<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="alertArea"></div>

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
                <a href="#" class="profile-option-selected">Categoria</a>
            </li>
            <li class="lista">
                <a href="adminLevel.html">Level</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Categoria
        </h2>

        <ul>
        	<%
        		ResultSet category = new Categoria().select("");
        		if(category.next()) {
        			out.println("<script type='text/javascript'>var category = []; </script>");
        			
        			do {
        				out.println("<li class='lista' id='li" + category.getString("idCategoria") + "'>");
        				out.println("	<a href='listaTopicos?id=" + category.getString("idCategoria") + "'>" + category.getString("descricao") + "</a>");
        				out.println("	<div>");
        				out.println("		<img class='icon' id='edit" + category.getString("idCategoria") + "' src='img/icon/edit.png'>");
        				out.println("		<img class='icon' id='delete" + category.getString("idCategoria") + "' src='img/icon/delete.png'>");
        				out.println("</div></li>");
        				
        				out.println("<script type='text/javascript'>category.push('" + category.getString("idCategoria") + "'); </script>");
        			} while(category.next());
        		}
        		else {
        			out.println("<li class='lista'>Nenhuma categoria</li>");
        		}
        	%>
        	
			<a class="btns" href="adminCriarCategoria.html">Criar Categoria</a>
        </ul>
    </div>
</div>

<form id="form">
	<input type="hidden" name="id" id="id">
</form>

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
			category.map(function (cat) {
				$("#edit" + cat).click(
	           		function() {
	           			window.location.href = "adminEditarCategoria.jsp?id=" + cat;
	           		}
	            );
				
				$("#delete" + cat).click(
	           		function() {
	           			document.querySelector('#id').setAttribute('value', cat);
	           			
	           			var formData = $("#form").serialize();
						$.post( "operation/deletarCategoria.jsp", formData, function( data, status ) {					
							alertFunc('Categoria deletada!');
							document.querySelector('div#side ul').removeChild( document.querySelector('#li' + cat) );
						});	
	           		}
	            );
		    });
		} 
	);
	
</script>