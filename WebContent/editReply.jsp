<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Comentario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Fórum - Editar Resposta</title>
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
					$("#content").load("view/editReply.jsp?idComentario=<%
						String idComentario = request.getParameter("id");
						if (idComentario == null) {
							response.sendRedirect("index.html");
						}
						else {
							ResultSet comment = new Comentario().select("idComentario='" + idComentario + "'");
							if(comment.next()) {
								out.write(idComentario);
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