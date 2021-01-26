<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("userlogin") != null) {
		
	  	int userLogin = 0;
		userLogin = (int) session.getAttribute("userlogin");
		if ( ! (userLogin > 0 )){
		}
		else {
			ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
			usuario.next();
			
			if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
				response.sendRedirect("ativo.jsp");
			}
		}
	}
	else {
	}
%>

<div id="directory">
    <a href="index.html">home</a> /
    <a href="#">categorias</a>
</div>

<div id="content">
    <div class="box">
        <h2>Categorias</h2>
        	
        <div id="categories">
	         <%
	        	ResultSet category = new Categoria().select("");
				while(category.next()) {
					out.println("<div class='category'>");
					out.println("	<a href='listaTopicos.jsp?id=" + category.getString("idCategoria") + "'>" + category.getString("descricao") + "</a>");
					out.println("</div>");
				}
	        %>
        </div>
    </div>
</div>