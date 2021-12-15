<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의설문조사</title>
<link rel="stylesheet" href="/css/mysurvey.css" />
</head>
<body>

<jsp:include page="../header.jsp"/>
 <sec:authentication property="principal" var="user" /> 

<div class="wrapper">

	<div class="create-box" onclick="location.href='/user/surveyform'">
		CREATE NEW SURVEY
	</div>
	
	<div class="survey-list-box">
		<table class="survey-list-table">
			<tr>
				<th>NUM</th>
				<th>TITLE</th>
				<th>CREATE TIME</th>
				<th>UPDATE TIME</th>
			</tr>
			<c:forEach items="${surveyList}" var="survey" varStatus="status">
				<tr>
					<td class="number">${survey.suIdx}</td>
					<td class="title"><a href="/user/surveyedit${survey.makeQueryString(survey.currentPageNo)}&suIdx=${survey.suIdx}">${survey.suTitle}</a></td>
					<td class="cTime">${survey.suCreateTime}</td>
					<td class="uTime">${survey.suUpdateTime}</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	
	<c:if test="${survey!=null && survey.paginationInfo.totalRecordCount>0}">
		<div class="pagination-box">
			<ul>
				<c:if test="${survey.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/user/mysurvey','${survey.makeQueryString(1)}')">&laquo;</li>
				</c:if>
				<c:if test="${survey.paginationInfo.hasPreviousPage == true}">
					<li onclick="movePage('/user/mysurvey','${survey.makeQueryString(survey.paginationInfo.firstPage-1)}')">&lsaquo;</li>
				</c:if>
				<c:forEach var="i" begin="${survey.paginationInfo.firstPage}" end="${survey.paginationInfo.lastPage}">
					<c:choose>
						<c:when test="${survey.currentPageNo == i}">
							<li class="selectPage">${i}</li>
						</c:when>
						<c:when test="${survey.currentPageNo != i}">
							<li onclick="movePage('/user/mysurvey','${survey.makeQueryString(i)}')" class="nonSelectPage">${i}</li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${survey.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/user/mysurvey','${survey.makeQueryString(survey.paginationInfo.lastPage+1)}')">&rsaquo;</li>
				</c:if>
				<c:if test="${survey.paginationInfo.hasNextPage == true}">
					<li onclick="movePage('/user/mysurvey','${survey.makeQueryString(survey.paginationInfo.totalPageCount)}')">&raquo;</li>
				</c:if>
			</ul>
		</div>
	</c:if>
</div>

<div class="search-box">
	<form action="/user/mysurvey" method="get">
		<input type="hidden" name="currentPageNo" value="1" />
		<input type="hidden" name="recordsPerPage" value="${survey.recordsPerPage}" />
		<input type="hidden" name="pageSize" value="${survey.pageSize}" />
		<select name="searchType" class="searchType">
			<option value="title">제목</option>
			<!-- <option value="wrtier">작성자</option> -->
		</select>
		<input type="text" name="searchKeyword" placeholder="내용" class="searchKeyword" />
		<input type="submit" value="검색하기" class="searchBtn"/>
	</form>
</div>

<script>
	function movePage(uri,queryString){
		location.href = uri + queryString;
	}
</script>
</body>
</html>