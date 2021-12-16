<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사참여</title>
<link rel="stylesheet" href="/css/surveyboard.css" />
</head>
<body>

<jsp:include page="../header.jsp"/>
 <sec:authentication property="principal" var="user" /> 
 	
<div class="wrapper">

	<div class="survey-list-box">
		<table class="survey-list-table">
			<tr>
				<th class="writer">WRITER</th>
				<th class="title">TITLE</th>
				<th class="cTime">CREATE TIME</th>
				<th class="uTime">UPDATE TIME</th>
			</tr>
			<c:forEach items="${surveyList}" var="survey" varStatus="status">
				<tr class="rowValue">
					<td class="writer">${survey.suWriter}</td>
					<td class="title"><a href="/user/surveydo?suIdx=${survey.suIdx}">${survey.suTitle}</a></td>
					<td class="cTime">${survey.suCreateTime}</td>
					<td class="uTime">${survey.suUpdateTime}</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	
	<div class="pagination-box">
	
	</div>
	
	<div class="search-box">
		
	</div>
	
</div>

</body>
</html>