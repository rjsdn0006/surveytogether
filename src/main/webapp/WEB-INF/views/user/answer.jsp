<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제출된 설문지</title>
<link rel="stylesheet" href="/css/surveyform.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
<body>

<!-- Header -->
<div class="header-bar survey-form">
	<div class="header-box">
		<div class="left-box">
			<span class="header-title">Answers</span>
		</div>
		<div class="right-box">
			<a href="#" onclick="history.back()"><span class="menu1">뒤로가기</span></a>
		</div>
	</div>
</div>
 
 <input type="hidden" class="writer" value="${writer}" />
 
<!-- 설문응답이 표시될 부분 -->
<div class="wrapper">
	<form class="surveyForm" action="#" method="POST">
		<fieldset>
			<legend>글제목</legend>
			<div class="surveyWriter">답변자 : ${writer}</div>
			<p><input type="text" name="suTitle" class="input-bar survey-title" value="${survey.suTitle}" disabled/></p>
			<p><textarea name="suDesc" class="input-bar survey-desc" disabled>${survey.suDesc}</textarea></p>
		</fieldset>
		
		<!-- 질문목록이 추가되는 영역 -->
		<div class="add-survey-box">
			<c:forEach items="${questionList}" var="question" varStatus="status">
				<fieldset class="question">
					<p><input type="hidden" class="quIdx" value="${question.quIdx}"/></p>
					<p><input type="text" name="quTitle" class="input-bar add-question" value="${question.quTitle}" disabled/></p>
					<div class="answer-add-box">
					
					</div>
				</fieldset>
			</c:forEach>
		</div>
	</form>
</div>

<script src="/script/answer.js"></script>

</body>
</html>