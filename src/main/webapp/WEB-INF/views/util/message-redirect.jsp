<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>message-redirect</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>

	<c:if test="${not empty params}">
		<form action="${redirectUri}" method="${method}" style="display:none;" name="sendForm">
			<c:forEach items="${params}" var="param" varStatus="stauts">
				<input type="hidden" name="${param.key}" value="${param.value}" />
			</c:forEach>
		</form>
	</c:if>
	
	<script>
		$(function(){
			let message = "${message}";
			let params = "${params}";
			let redirectUri = "${redirectUri}";
			
			if(message!=null){
				alert(message);
			}
			if(params!=""){
				document.sendForm.submit();
			}else{
				location.href = redirectUri;
			}
		});
	</script>
	
</body>
</html>