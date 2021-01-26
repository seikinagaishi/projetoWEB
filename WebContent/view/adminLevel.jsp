<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Level"%>
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
                <a href="admin.html">Categoria</a>
            </li>
            <li class="lista">
                <a href="#" class="profile-option-selected">Level</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Level
        </h2>

        <ul>
        	<%
        		ResultSet lvl = new Level().select("");
        		if(lvl.next()) {
        			out.println("<script type='text/javascript'>var lvl = []; </script>");
        			
        			do {
        				out.println("<li class='lista' id='li" + lvl.getString("idLevel") + "'>");
        				out.println(	lvl.getString("idLevel") + " - EXP: " + lvl.getString("exp"));
        				out.println("	<div>");
        				out.println("		<img class='icon' id='delete" + lvl.getString("idLevel") + "' src='img/icon/delete.png'>");
        				out.println("</div></li>");
        				
        				out.println("<script type='text/javascript'>lvl.push('" + lvl.getString("idLevel") + "'); </script>");
        			} while(lvl.next());
        		}
        		else {
        			out.println("<li class='lista'>Nenhum Level</li>");
        		}
        	%>
        	
			<a class="btns" href="adminCriarLevel.html">Criar Level</a>
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
			lvl.map(function (lv) {
				$("#delete" + lv).click(
	           		function() {
	           			document.querySelector('#id').setAttribute('value', lv);
	           			
	           			var formData = $("#form").serialize();
						$.post( "operation/deletarLevel.jsp", formData, function( data, status ) {					
							alertFunc('Level deletado!');
							document.querySelector('div#side ul').removeChild( document.querySelector('#li' + lv) );
						});	
	           		}
	            );
		    });
		} 
	);
	
</script>