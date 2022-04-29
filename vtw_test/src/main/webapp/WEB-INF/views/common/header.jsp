<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.example.demo.member.model.vo.Member"%> 
    
<%
	Member member = (Member) session.getAttribute("member");
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VTW - RestAPI</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/CustomStyle.css" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
</head>
<body>

<script>

function logout(){

	location.href = '${pageContext.request.contextPath}/member/logout';
}
	
</script>

<div id = "header-container">
	<img src="${pageContext.request.contextPath }/resources/img/vtwLogo.png" id="vtwLogo" <%if(member != null){ %>onclick="location.href = '${pageContext.request.contextPath}/board/backToIndex'"<%} %>>
	<% if(member != null){ %>
		<header>
			
			<span>${member.name}님 환영합니다.</span>
			<input type='hidden' value='\${member.name}' id = 'loginMember'>
			<input type='hidden' value='${member.id}' id = 'loginMemberId'>
			<button type = 'button' id = 'btn-signOut' onclick = 'logout();'>로그아웃</button>
		
		</header>
	
	<%}%>
	
</div>

<section id = "section">






