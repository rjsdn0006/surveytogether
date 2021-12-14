<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>option</title>
</head>
<body>

<!-- optionList, quFormat이 전달되어 option 목록을 만드는 페이지 -->

<c:forEach items="${optionList}" var="opt" varStatus="status">

</c:forEach>

<c:when test="${quFormat eq 'multipleChoice'}">
	<p class="choose-question-box">
		<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<input type="radio" name="option" disabled/>
		<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${optionList[0].opName}" required/>
	</p>
	<c:forEach items="${optionList}" var="opt" varStatus="status" begin="1">
	
	</c:forEach>
</c:when>

</body>
</html>