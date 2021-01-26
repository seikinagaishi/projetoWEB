<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="columns">
    <aside>
        <h2>Navegação</h2>
        
        <ul>
            <li class="lista">
                <a href="#" class="profile-option-selected">Perfil</a>
            </li>
            <li class="lista">
                <a href="profilePrivacy.html">Privacidade</a>
            </li>
            <li class="lista">
                <a href="profilePassword.html">Mudar Senha</a>
            </li>
            <li class="lista">
                <a href="profileTitle.html">Modificar Título</a>
            </li>
            <li class="lista">
                <a href="operation/sair.jsp">Sair</a>
            </li>
        </ul>
    </aside>

    <div id="side">
        <h2 id="editTitle">
            Suas informações
            <div>
                <a href="profileChange.html"><img class="icon" src="img/icon/edit2.png" title="Editar"></a>
            </div>
        </h2>

        <ul>
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
						
						out.println("<li class='lista'><p class='lista-item'>" + usuario.getString("apelido") +"</p></li>");
						out.println("<li class='lista'><p class='lista-item'>" + usuario.getString("email") +"</p></li>");
						out.println("<li class='lista'><p class='lista-item'>Gênero: " + usuario.getString("gender") +"</p></li>");
						out.println("<li class='lista'><p class='lista-item'>Nasceu em <input type='date' class='dateshow' value='" + usuario.getString("dataNasc") +"' readonly></p></li>");
						out.println("<li class='lista'><p class='lista-item'>Bio: " + usuario.getString("bio") +"</p></li>");
					}
			   	}
			   	else {
			   		response.sendRedirect("login.jsp");
			   	}
			%>
        </ul>
    </div>
</div>