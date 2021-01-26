<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Seguir"%>
<%@page import="classes.Level"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="feed">
    <h2>Usuários</h2>
    
    <div class="container">
        <div id="owner-follow-profiles">
        
        	<%
				String idUsuario   = request.getParameter("idUser");
			    String tipo 	   = request.getParameter("tipo");
				
				if( idUsuario == null && tipo == null ) {
					if (session.getAttribute("userlogin") != null) {
						
					  	int userLogin = 0;
						userLogin = (int) session.getAttribute("userlogin");
						if ( ! (userLogin > 0 )){
							response.sendRedirect("index.html");
						}
						else {
							ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
							usuario.next();
							
							if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
								response.sendRedirect("ativo.jsp");
							}
							
							if( usuario.getString("idNivelUsuario").equals("3") ) {
								//Somente o administrador pode visualizar todos os usuários
								ResultSet user = new Usuario().select("");
								while(user.next()) {
									ResultSet lvl = new Level().select("exp <= '" + user.getString("exp") + "' ORDER BY exp DESC");
									lvl.next();
									
									out.println("<a class='owner-follow' href='profile.jsp?id='" + user.getString("idUsuario") + ">");
									out.println("	<div class='owner-pic'> <img class='foto' src='img/profile/" + user.getString("foto") + ".jpg'> </div>");
									out.println("	<div class='owner-data'>");
									out.println("		<div class='owner-name'>" + user.getString("apelido") + "</div>");
									out.println("		<div class='owner-level'>Lv " + lvl.getString("idLevel") + "</div>");
									out.println("</div></a>");
								}
							} else {
								response.sendRedirect("index.html");
							}
						}
					}
					else {
						response.sendRedirect("index.html");
					}
				} 
				else {
					
					if( idUsuario != null && tipo != null ) {
						ResultSet f = null;
						if( tipo.equals("1") ) {
							//mostrar usuários seguidos
							f = new Seguir().select("idUsuario='" + idUsuario + "'");
							
							if(f.next()) {
								do {
									ResultSet user = new Usuario().select("idUsuario='" + f.getString("idSeguido") + "'");
									user.next();
									
									ResultSet lvl = new Level().select("exp <= '" + user.getString("exp") + "' ORDER BY exp DESC");
									lvl.next();
									
									out.println("<a class='owner-follow' href='profile.jsp?id='" + user.getString("idUsuario") + ">");
									out.println("	<div class='owner-pic'> <img class='foto' src='img/profile/" + user.getString("foto") + ".jpg'> </div>");
									out.println("	<div class='owner-data'>");
									out.println("		<div class='owner-name'>" + user.getString("apelido") + "</div>");
									out.println("		<div class='owner-level'>Lv " + lvl.getString("idLevel") + "</div>");
									out.println("</div></a>");
								} while(f.next());
							} else {
								out.println("<ul> <li class='lista'>Nenhum usuário registrado.</li> </ul>");
							}
							
							
						} else if( tipo.equals("2") ) {
							//mostrar usuários que o usuário logado segue
							f = new Seguir().select("idSeguido='" + idUsuario + "'");
							
							if(f.next()) {
								do {
									ResultSet user = new Usuario().select("idUsuario='" + f.getString("idUsuario") + "'");
									user.next();
									
									ResultSet lvl = new Level().select("exp <= '" + user.getString("exp") + "' ORDER BY exp DESC");
									lvl.next();
									
									out.println("<a class='owner-follow' href='profile.jsp?id='" + user.getString("idUsuario") + ">");
									out.println("	<div class='owner-pic'> <img class='foto' src='img/profile/" + user.getString("foto") + ".jpg'> </div>");
									out.println("	<div class='owner-data'>");
									out.println("		<div class='owner-name'>" + user.getString("apelido") + "</div>");
									out.println("		<div class='owner-level'>Lv " + lvl.getString("idLevel") + "</div>");
									out.println("</div></a>");
								} while(f.next());
							} else {
								out.println("<ul> <li class='lista'>Nenhum usuário registrado.</li> </ul>");
							}
							
						}
					} else {
						response.sendRedirect("index.html");
					}
					
				}
			%>  
        </div>
    </div>
</div>