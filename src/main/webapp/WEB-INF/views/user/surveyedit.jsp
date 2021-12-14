<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사 수정</title>
<link rel="stylesheet" href="/css/surveyform.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/script/jquery.bpopup-0.1.1.min.js"></script>
</head>
<body>
<sec:authentication property="principal" var="principal" />
<input type="hidden" name="userId" value="${principal.username}" class="userId"/>
<input type="hidden" name="surveyIdx" value="${survey.suIdx}" class="surveyIdx" />

<!-- Editor만을 위한 Header -->
<div class="header-bar survey-form">
	<div class="header-box">
		<div class="left-box">
			<span class="header-title">Editor</span>
		</div>
		<div class="right-box">
			<a href="/user/mysurvey"><span class="menu1">뒤로가기</span></a>
			<a href="#"><span class="menu2">응답사항</span></a>
			<a href="#" onclick="saveSurvey();"><span class="menu3">저장하기</span></a>
		</div>
	</div>
</div>
 
<!-- 실질적인 설문조사를 만드는 부분 -->
<div class="wrapper">
	<form class="surveyForm" action="#" method="POST">
		<fieldset>
			<legend>글제목</legend>
			<p><input type="text" name="suTitle" placeholder="설문지 제목" class="input-bar survey-title" value="${survey.suTitle}" required/></p>
			<p><textarea name="suDesc" placeholder="설문지 설명" class="input-bar survey-desc">${survey.suDesc}</textarea></p>
		</fieldset>
		
		<!-- 추가질문목록이 추가되는 영역 -->
		<div class="add-survey-box">
			
		</div>
	</form>
	
	<div class="side-box">
		<div class="add-btn side-btn">
			<i class="fas fa-plus-circle"></i>
		</div>
		<div class="top-btn side-btn">
			<i class="fas fa-arrow-circle-up"></i>
		</div>
	</div>
</div>


<!-- 우측하단 + 버튼 클릭시 나올 모달창 -->
<div id="select-box">
	<div class="select-header">
		<a class="b-close"><i class="fas fa-times"></i></a>
	    <p class="b-title">질문형식선택</p>
	</div>
  	<div class="select-content">
  		<input type="radio" id="shortSentence" name="select-content" value="shortSentence"/>
	    <label for="shortSentence">단답형</label>
	    <input type="radio" id="longSentence" name="select-content" value="longSentence"/>
	    <label for="longSentence">장문형</label>
	    <input type="radio" id="multipleChoice" name="select-content" value="multipleChoice"/>
	    <label for="multipleChoice">객관식</label>
	    <input type="radio" id="checkBox" name="select-content" value="checkBox"/>
	    <label for="checkBox">체크박스</label>
	    <input type="radio" id="dropDown" name="select-content" value="dropDown"/>
	    <label for="dropDown">드롭다운</label>
	   	<p class="select-success-box"><button type="button" class="select-success-btn">선택완료</button></p>
  	</div>
</div>


<script src="/script/surveyform.js"></script>

</body>
</html>