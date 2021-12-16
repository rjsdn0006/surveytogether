<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사 만들기</title>
<link rel="stylesheet" href="/css/surveydo.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/script/jquery.bpopup-0.1.1.min.js"></script>
</head>
<body>
<sec:authentication property="principal" var="principal" />
<input type="hidden" name="userId" value="${principal.username}" class="userId"/>
<input type="hidden" id="surveyIdx" value="${survey.suIdx}" />

<!-- Participation만을 위한 Header -->
<div class="header-bar survey-form">
	<div class="header-box">
		<div class="left-box">
			<span class="header-title">Participation</span>
		</div>
		<div class="right-box">
			<a href="/user/surveyboard"><span class="menu1">뒤로가기</span></a>
			<a href="#" onclick="doneSurvey();"><span class="menu2">참여완료</span></a>
		</div>
	</div>
</div>
 
<!-- 실질적인 설문조사를 만드는 부분 -->
<div class="wrapper">
	<form class="surveyForm" action="#" method="POST">
		<fieldset>
			<legend>글제목</legend>
			<div class="surveyWriter">만든사람 : ${survey.suWriter}</div>
			<p><input type="text" name="suTitle" value="${survey.suTitle}" class="input-bar survey-title" disabled/></p>
			<p><textarea name="suDesc" class="input-bar survey-desc" disabled>${survey.suDesc}</textarea></p>
		</fieldset>
		<!-- 추가질문목록이 추가되는 영역 -->
		<div class="add-survey-box">

		</div>
	</form>
</div>

<script src="/script/surveydo.js"></script>

</body>
</html>