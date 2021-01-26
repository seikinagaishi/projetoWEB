<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="mail.SendMail"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	LocalDateTime now = LocalDateTime.now();

	String email 	= request.getParameter("email");
	String senha 	= request.getParameter("senha");
	String senhaConfirm = request.getParameter("senhaConfirm");
	String apelido	= request.getParameter("apelido");
	String cod 		= new Usuario(email).newPassword();
	String dataNasc = request.getParameter("dataNasc");
	String dataInsc = dtf.format(now) + "";
	
	String saida = ""; 
	
	if (senha.equals(senhaConfirm)) {
		Usuario usuario = new Usuario (email, senha, apelido, cod, dataInsc, dataNasc);
		
		if(usuario.check()) {
			//Caso o usuário já exista não será possível criá-lo
			saida = "{ \"cadastro\": \"false\"}";
		}
		else {
			usuario.save();
			
			if (usuario.check()){
				String smtpHost = "smtp.gmail.com"; 
				String smtpPort = "587"; 
				String username = "email@gmail.com";
				String password = "senha";
				String auth     = "tls";  
				SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );
				
				String mailFrom 	= "email@gmail.com"; 
			 	String mailTo 		= email;
			 	String mailSubject 	= "Registro"; 
			 	String mailBody 	= "Obrigado por se registrar no fórum, para ativar sua conta acesse o link: http://localhost:8080/forum/operation/ativar.jsp?apelido=" + apelido + "&cod=" + cod; 
				sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
		
				saida = "{ \"cadastro\": \"true\"}";
				
				/*Assim que registrado, o usuário já é automaticamente logado, porém precisa ativar para começar a usar a conta*/
				Usuario user = new Usuario (email, senha);
				if (user.checkLogin()){
					session.setAttribute("userlogin", user.getIdUsuario());
				}else{
					session.setAttribute("userlogin", 0);
				}
			}else{
				saida = "{ \"cadastro\": \"false\"}";
			}
		}
	}
	else {
		saida = "{ \"cadastro\": \"erro\"}";
	}
	out.write(saida);
%>