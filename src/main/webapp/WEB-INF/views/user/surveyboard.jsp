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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
			<c:forEach items="${surveyList}" var="item" varStatus="status">
				<tr class="rowValue">		
					<td class="writer">${item.suWriter}</td>
					<td class="title"><a href="#" onclick="checkAnswer('${item.suIdx}','${survey.makeQueryString(survey.currentPageNo)}')">${item.suTitle}</a></td>
					<td class="cTime">${item.suCreateTime}</td>
					<td class="uTime">${item.suUpdateTime}</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	
	<c:if test="${survey!=null && survey.paginationInfo.totalRecordCount>0}">
		<div class="pagination-box">
			<ul>
				<c:if test="${survey.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/user/surveyboard','${survey.makeQueryString(1)}')">&laquo;</li>
				</c:if>
				<c:if test="${survey.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/user/surveyboard','${survey.makeQueryString(survey.paginationInfo.firstPage-1)}')">&lsaquo;</li>
				</c:if>
				<c:forEach var="i" begin="${survey.paginationInfo.firstPage}" end="${survey.paginationInfo.lastPage}">
					<c:choose>
						<c:when test="${survey.currentPageNo == i}">
							<li class="selectPage">${i}</li>
						</c:when>
						<c:when test="${survey.currentPageNo != i}">
							<li onclick="movePage('/user/surveyboard','${survey.makeQueryString(i)}')" class="nonSelectPage">${i}</li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${survey.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/user/surveyboard','${survey.makeQueryString(survey.paginationInfo.lastPage+1)}')">&rsaquo;</li>
				</c:if>
				<c:if test="${survey.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/user/surveyboard','${survey.makeQueryString(survey.paginationInfo.totalPageCount)}')">&raquo;</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	
	<div class="search-box">
		<form action="/user/surveyboard" method="get">
			<input type="hidden" name="currentPageNo" value="1" />
			<input type="hidden" name="recordsPerPage" value="${survey.recordsPerPage}" />
			<input type="hidden" name="pageSize" value="${survey.pageSize}" />
			<select name="searchType" class="searchType">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select>
			<input type="text" name="searchKeyword" placeholder="내용" class="searchKeyword" />
			<input type="submit" value="검색하기" class="searchBtn"/>
		</form>
	</div>
	
</div>
<script>
	function checkAnswer(paramA,paramB){
		// paramA에는 surveyIdx가 들어와있다.
		// paramB에는 queryString이 들어있다.
		const loginUser = "${user.username}";
		$.ajax({
			url:"/user/checkanswer",
			method:"get",
			data:{writer:loginUser, suIdx:paramA}
		}).done(function(result){
			if(result){
				alert("이미 참여한 설문조사입니다.");
				return false;
			}else{
				let path = "/user/surveydo"+paramB+"&suIdx="+paramA;
				location.href = path;
						
			}
		});
		
	};
	
	function movePage(uri,queryString){
		location.href = uri + queryString;
	}

</script>
</body>
</html>