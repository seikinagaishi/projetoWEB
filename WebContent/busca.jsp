<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Fórum - Busca</title>
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
					$("#content").load("view/busca.jsp<%
						String busca = request.getParameter("busca");
						if ( busca != null ) {
							out.write("?busca=" + busca);
						}
					%>");
					$("footer").load("view/footer.html");
				} 		
			);
		</script>
	</body>
</html>