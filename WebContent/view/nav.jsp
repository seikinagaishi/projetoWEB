<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classes.Usuario"%>
<%@page import="classes.Level"%>
<%@page import="classes.LogEXP"%>
<%@page import="classes.Conquista"%>
<%@page import="classes.Conquistado"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="menu">
    <div class="line1"></div>
    <div class="line2"></div>
    <div class="line3"></div>
</div>

<div class="logo">
    <h4><a href="index.html">Logo</a></h4>
</div>

<ul class="nav-links">
    <li>
        <a href="categorias.html">Categorias</a>
    </li>

    <li id="busca">
        <img id="lupa" src="img/icon/search.png">
        <form action="busca.jsp" method="POST">
			<input type="text" name="busca" id="search">
        </form>
    </li>

    <li id="minibusca">
        <a href="busca.jsp">Buscar</a>
    </li>

    <li>
    	<%
			if (session.getAttribute("userlogin") != null) {
				
		   		int userLogin = 0; 
				userLogin = (int) session.getAttribute("userlogin");
				if ( ! (userLogin > 0 )){
					out.println("<a href='login.html'>Perfil</a>");
				}
				
				else {
					ResultSet usuario = new Usuario().select("idUsuario='" + userLogin + "'");
					usuario.next();
					
					if( Integer.valueOf(usuario.getString("ativo")) == 0 || Integer.valueOf(usuario.getString("banido")) == 1 ) {
						out.println("<a href='login.html'>Perfil</a>");
						
					} else {
						out.println("<a href='profile.jsp?id=" + userLogin + "'>Perfil</a>");
						
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						LocalDateTime now = LocalDateTime.now();
						
						if( !(usuario.getString("ultimaSessao").equals(dtf.format(now))) ) {
							Usuario lastSession = new Usuario(userLogin, usuario.getString("email"), dtf.format(now));
							lastSession.save();
							//registrar último dia acessado
						}
						
						if( usuario.getInt("exp") < 11000 ) {
						//caso o usuário ainda não tenha obtido level máximo
						
							ResultSet checkDailyEXP = new LogEXP().select("idUsuario='" + userLogin + "' AND qtd='3' AND data='" + dtf.format(now) + "'");
							if(checkDailyEXP.next()) {
							} else {
								Usuario dailyEXP = new Usuario(userLogin, 3);
								dailyEXP.save();
								
								LogEXP log = new LogEXP(0, userLogin, 3, dtf.format(now));
								log.save();
								//+3 pontos de experiência por login diário
							}
							
						}

						ResultSet conquistado = new Conquistado().selectCount("idUsuario='" + userLogin + "'" );
						ResultSet conquista = new Conquista().selectCount("");
						conquistado.next();
						conquista.next();
												
						if( !(conquista.getString("count(*)").equals( conquistado.getString("count(*)") )) ) {
						//Caso o usuário ainda não tenha obtido todas as conquistas
							if( usuario.getInt("idNivelUsuario") != 1 ) {
								if( usuario.getInt("idNivelUsuario") == 3 ) {
									ResultSet adminTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='1'");
									if( !(adminTitle.next()) ) {
										Conquistado clear = new Conquistado(0, 1, userLogin, dtf.format(now));
										clear.save();
										//Conquista de ser Administrador
									}
								}
								else {
									ResultSet modTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='2'");
									if( !(modTitle.next()) ) {
										Conquistado clear = new Conquistado(0, 2, userLogin, dtf.format(now));
										clear.save();
										//Conquista de ser Moderador
									}
								}
								
							}
							
							ResultSet lvlNav = new Level().select("exp <= '" + usuario.getString("exp") + "' ORDER BY exp DESC");
							lvlNav.next();
							if( lvlNav.getInt("idLevel") >= 3 ) {
								ResultSet lvlTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='3'");
								if(!(lvlTitle.next())) {
									Conquistado clear = new Conquistado(0, 3, userLogin, dtf.format(now));
									clear.save();
									//Conquista por alcançar level 3
								} else {
									if( lvlNav.getInt("idLevel") >= 5 ) {
										lvlTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='4'");
										if(!(lvlTitle.next())) {
											Conquistado clear = new Conquistado(0, 4, userLogin, dtf.format(now));
											clear.save();
											//Conquista por alcançar level 5
										}
										else {
											if( lvlNav.getInt("idLevel") >= 10 ) {
												lvlTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='5'");
												if(!(lvlTitle.next())) {
													Conquistado clear = new Conquistado(0, 5, userLogin, dtf.format(now));
													clear.save();
													//Conquista por alcançar level 10
												}
											}
										}
									} 
								}
							}
							
							ResultSet likesUser = new LogEXP().selectCount("idUsuario='" + userLogin + "' AND qtd='5'");
							likesUser.next();
							if( likesUser.getInt("count(*)") >= 100 ) {
								ResultSet likeTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='6'");
								if(!(likeTitle.next())) {
									Conquistado clear = new Conquistado(0, 6, userLogin, dtf.format(now));
									clear.save();
									//Conquista por dar likes em 100 tópicos
								}
							}
							
							ResultSet topicsUser = new LogEXP().selectCount("idUsuario='" + userLogin + "' AND qtd='10'");
							topicsUser.next();
							if( topicsUser.getInt("count(*)") >= 20 ) {
								ResultSet topicTitle = new Conquistado().select("idUsuario='" + userLogin + "' AND idConquista='7'");
								if(!(topicTitle.next())) {
									Conquistado clear = new Conquistado(0, 7, userLogin, dtf.format(now));
									clear.save();
									//Conquista por criar 20 tópicos
								}
							}
						}
						
						if( usuario.getInt("idNivelUsuario") == 3 ) {
							out.println("</li> <li>");
	       					out.println("<a class='admin' href='admin.html'>Gerenciar</a>");
	     					//Página exclusiva do Administrador
	       				}
					}
				}
		   	}
		   	else {
		   		out.println("<a href='login.html'>Perfil</a>");
		   	}
		%>
    </li>
</ul>

<div class="profile">
	<%
		if (session.getAttribute("userlogin") != null) {
			int userLogin = 0; 
			userLogin = (int) session.getAttribute("userlogin");
			if(userLogin > 0) {
				ResultSet usuarioNav = new Usuario().select("idUsuario='" + userLogin + "'");
				usuarioNav.next();
				
				if( Integer.valueOf(usuarioNav.getString("ativo")) == 0 || Integer.valueOf(usuarioNav.getString("banido")) == 1 ) {
					out.println("<a href='login.html'>Login</a>");
				} else {
					out.println(usuarioNav.getString("apelido"));
					out.println("<div class='small-pic'>");
					out.println("	<img class='icon' src='img/icon/settings.png' id='editBtn' title='Configurações'>");
					out.println("	<img class='small-foto' src='img/profile/" + usuarioNav.getString("foto") +".jpg' title='" + usuarioNav.getString("apelido") + "'>");
					out.println("</div>");
				}
			}
			else {
				out.println("<a href='login.html'>Login</a>");
			}
		}
		else {
			out.println("<a href='login.html'>Login</a>");
		}
	%>
</div>

<script src="js/nav.js"></script>

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
			$("#editBtn").click(
				function() {
					window.location.href = "profileConfig.html";
				}
			);
		} 
	);
	
</script>