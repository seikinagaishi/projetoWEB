<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Fórum - Perfil</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		
		<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300&display=swap" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css">
	</head>
	
	<body>
		<nav></nav>
		<div id="content"></div>
		<footer></footer>
		
		<script type="text/javascript">	
			$(document).ready( 
				function() {
					$("nav").load("view/nav.jsp");
					$("#content").load("view/profileFollowing.jsp?idUsuario=<%
						String idUsuario = request.getParameter("id");
						if (idUsuario == null) {
							response.sendRedirect("index.html");
						}
						else {
							ResultSet user = new Usuario().select("idUsuario='" + idUsuario + "'");
							if(user.next()) {
								out.write(idUsuario);
							}
							else {
								response.sendRedirect("index.html");
							}
						}
					%>");
					$("footer").load("view/footer.html");
				} 		
			);
		</script>
	</body>
</html>