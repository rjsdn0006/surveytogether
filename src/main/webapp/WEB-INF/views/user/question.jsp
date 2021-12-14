<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>question</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
<body>
<!-- questionList가 전달되어 question 목록을 만드는 페이지 -->

<c:forEach items="${questionList}" var="que" varStatus="status">
	<c:choose>
		<c:when test="${que.quFormat eq 'shortSentence'}">
			<fieldset class="question">
				<p><input type="text" name="quTitle" placeholder="단답형 질문" class="input-bar add-question" value="${que.quTitle}" required/></p>
				<p><input type="hidden" name="format" value="shortSentence" /></p>
				<p><input type="text" placeholder="단답형 답변을 받게됩니다." class="input-bar" disabled/></p>
				<div class="add-question-btn-box">
					<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
				</div>
			</fieldset>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${que.quFormat eq 'longSentence'}">
			<fieldset class="question">
				<p><input type="text" name="quTitle" placeholder="장문형 질문" class="input-bar add-question" value="${que.quTitle}" required/></p>
				<p><input type="hidden" name="format" value="longSentence" /></p>
				<p><input type="text" name="" placeholder="장문형 답변을 받게됩니다." class="input-bar" disabled/></p>
				<div class="add-question-btn-box">
					<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
				</div>
			</fieldset>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${que.quFormat eq 'multipleChoice'}">
			<fieldset class="question">
				<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>
				<p><input type="text" name="quTitle" placeholder="객관식 질문" class="input-bar add-question"  value="${que.quTitle}" required/></p>
				<p><input type="hidden" name="format" value="multipleChoice" /></p>
				<div class="choose-question-container">
					<p class="choose-question-box">
						<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="radio" name="option" disabled/>
						<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" required/>
					</p>
				</div>
				<div class="add-question-btn-box">
					<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
					<button type="button" class="add-choose-btn" onclick="addOption('radio',this)"><i class="fas fa-plus"></i></button>
				</div>
			</fieldset>
		</c:when>
	</c:choose>
</c:forEach>

<script>
$(function(){
	loadOption(); 
});

function loadOption(){
	/*
	   quIdx를 전달해줘서 그에 맞는 option을 넣어주어야 한다. 
	   1. fieldset를 가져와서 객관식, 체크박스, 드롭다운이라면 option이 존재하는것이다.
	   2. ajax로 quIdx를 전달해준다. (hidden input으로 quidx값이 있을것이다.)
	   3. controller에서 quIdx를 넣어서 optionList를 받아오고 그걸 option.jsp에 전달한다.
	   4. option.jsp는 해당요소를 forEach를 통해 만들어낸다.
	   5. controller는 option.jsp를 ajax에 다시반환하고 이 파일에서 그 요소를 넣어준다.
	   6. 이렇게하면 하나의 fieldset에대한 option 불러오기가 끝이난다. 
	*/
	let fieldsetList = $('fieldset.question');
	$.each(fieldsetList, function(index, fieldset){
		if(question.quFormat!='shortSentence' && question.quFormat!='longSentence'){
			// 객관식, 체크박스, 드롭다운이라면 옵션이 존재할것이다. 
			let questionIdx = fieldset.querySelector("input[name='questionIdx']");
			$.ajax({
				url: "/user/loadoption",
				method: "get",
				data: {quIdx:questionIdx}
			}).done(function(optionPage){
				$(".choose-question-container").html(optionPage);
			});
		}
	});
	
}
</script>
</body>
</html>