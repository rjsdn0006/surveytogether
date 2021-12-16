<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${state eq 'participation'}">
		<c:choose>
			<c:when test="${quFormat eq 'multipleChoice'}">
				<c:forEach items="${optionList}" var="opt" varStatus="status">
					<p class="choose-question-box">
						<input type="radio" name="${questionIdx}" id="${opt.opName}" class="option" value="${opt.opName}"/>
						<label for="${opt.opName}" class="choose-question-option-desc">${opt.opName}</label>
					</p>
				</c:forEach>
			</c:when>
			<c:when test="${quFormat eq 'checkBox'}">
				<c:forEach items="${optionList}" var="opt" varStatus="status">
					<p class="choose-question-box">
						<input type="checkBox" name="option" id="${opt.opName}"  class="option" value="${opt.opName}"/>
						<label for="${opt.opName}" class="choose-question-option-desc">${opt.opName}</label>
					</p>
				</c:forEach>
			</c:when>
			<c:when test="${quFormat eq 'dropDown'}">
				<p class="choose-question-box">
					<select name="${questionIdx}" class="select-box">
						<c:forEach items="${optionList}" var="opt" varStatus="status">
							<option value="${opt.opName}">${opt.opName}</option>
						</c:forEach>
					</select>
				</p>
			</c:when>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<c:choose>
			<c:when test="${quFormat eq 'multipleChoice'}">
				<p class="choose-question-box">
					<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<input type="radio" name="option" disabled/>
					<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${optionList[0].opName}" required/>
				</p>
				<c:forEach items="${optionList}" var="opt" varStatus="status" begin="1">
					<p class="choose-question-box">
						<button type="button" class="choose-question-delete-btn" onclick="removeOption(this)">X</button>
						<input type="radio" name="option" disabled/>
						<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${opt.opName}" required/>
					</p>
				</c:forEach>
			</c:when>
			<c:when test="${quFormat eq 'checkBox'}">
				<p class="choose-question-box">
					<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<input type="checkbox" name="option" disabled/>
					<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${optionList[0].opName}" required/>
				</p>
				<c:forEach items="${optionList}" var="opt" varStatus="status" begin="1">
					<p class="choose-question-box">
						<button type="button" class="choose-question-delete-btn" onclick="removeOption(this)">X</button>
						<input type="checkBox" name="option" disabled/>
						<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${opt.opName}" required/>
					</p>
				</c:forEach>
			</c:when>
			<c:when test="${quFormat eq 'dropDown'}">
				<p class="choose-question-box">
					<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${optionList[0].opName}" required/>
				</p>
				<c:forEach items="${optionList}" var="opt" varStatus="status" begin="1">
					<p class="choose-question-box">
						<button type="button" class="choose-question-delete-btn" onclick="removeOption(this)">X</button>
						<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" value="${opt.opName}" required/>
					</p>
				</c:forEach>
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>



</body>