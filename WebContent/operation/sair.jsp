<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("userlogin", 0);
	session.removeAttribute("userlevel");
	response.sendRedirect("../login.html");
%>