<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>응답사항</title>
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
			<a href="/user/statistics"><span class="menu1">통계보기</span></a>
			<a href="#" onclick="history.back()"><span class="menu2">뒤로가기</span></a>
		</div>
	</div>
</div>
 
 <input type="hidden" value="${suIdx}" class="surveyIdx" />
<!-- 본문 -->
<div class="wrapper">
	<c:choose>
		<c:when test="${not empty answerPeople}">
			<div class="answer-list-box">
				<p class="person-icon"><i class="fas fa-child"></i></p>
				<p class="answer-list-title">설문을 제출한 사람들</p>
				<div class="answer-people-box">
					<c:forEach items="${answerPeople}" var="person" varStatus="status">
						<p onclick="gotoAnswerDetail('${person}')">${person}</p>
					</c:forEach>
				</div>
				
			</div>
		</c:when>
		<c:otherwise>
			<div class="no-answer-box">
				<p><i class="fas fa-times no-icon"></i></p>
				<p class="no-desc">응답사항이 없습니다</p>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script>
	function gotoAnswerDetail(param){
		// param에는 설문조사 응답자가 들어있다.
		const suIdx = $(".surveyIdx").val();
		const url = "/user/answer?"+"suIdx="+suIdx+"&writer="+param;
		location.href = url;
	}
</script>
</body>
</html>