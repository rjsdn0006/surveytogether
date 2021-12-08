<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="stylesheet" href="/css/home.css" />
</head>
<body>

<jsp:include page="../header.jsp"/>

<div class="wrapper">
	
	<div class="menu-box">
		<div class="home-menu">
			<i class="fas fa-comments free-board-icon"></i>
			<p class="menu-desc">자유게시판</p>
		</div>
		<div class="home-menu">
			<i class="far fa-clipboard survey-board-icon"></i>
			<p class="menu-desc">설문조사참여</p>
		</div>
		<div class="home-menu">
			<i class="fas fa-user-edit mysurvey-icon"></i>
			<p class="menu-desc">나의설문조사</p>
		</div>
	</div>


	<sec:authentication property="principal" var="user" />
</div>


</body>
</html>