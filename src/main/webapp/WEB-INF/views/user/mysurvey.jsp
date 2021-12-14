<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의설문조사</title>
<link rel="stylesheet" href="/css/mysurvey.css" />
</head>
<body>

<jsp:include page="../header.jsp"/>
	
<div class="wrapper">

	<div class="create-box" onclick="location.href='/user/surveyform'">
			CREATE NEW SURVEY
	</div>
	
	<div class="search-box">
		
	</div>
	
	<div class="survey-list-box">
		<table class="survey-list-table">
			<tr>
				<th>TITLE</th>
				<th>CREATE TIME</th>
				<th>UPDATE TIME</th>
			</tr>
			<c:forEach items="${surveyList}" var="survey" varStatus="status">
				<tr>
					<td class="title"><a href="/user/surveyedit?suIdx=${survey.suIdx}">${survey.suTitle}</a></td>
					<td class="cTime">${survey.suCreateTime}</td>
					<td class="uTime">${survey.suUpdateTime}</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	
	<div class="pagination-box">
	
	</div>
	
</div>

</body>
</html>