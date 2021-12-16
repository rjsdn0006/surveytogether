<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<c:choose>
	<c:when test="${state eq 'participation'}">
		<c:forEach items="${questionList}" var="que" varStatus="status">	
			<c:choose>
				<c:when test="${que.quFormat eq 'shortSentence'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>
						<p><input type="text" name="quTitle" class="input-bar add-question" value="${que.quTitle}" disabled/></p>
						<p><input type="hidden" name="format" value="shortSentence" /></p>
						<p><input type="text" placeholder="단답형 답변을 적어주세요" class="input-bar answer" /></p>
					</fieldset>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${que.quFormat eq 'longSentence'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>
						<p><input type="text" name="quTitle" class="input-bar add-question" value="${que.quTitle}" disabled/></p>
						<p><input type="hidden" name="format" value="longSentence" /></p>
						<p><textarea class="input-bar long-answer answer">장문형 답변을 적어주세요</textarea></p>
					</fieldset>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${que.quFormat eq 'multipleChoice'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>
						<p><input type="text" name="quTitle" class="input-bar add-question"  value="${que.quTitle}" disabled/></p>
						<p><input type="hidden" name="format" value="multipleChoice" /></p>
						<div class="choose-question-container">
						
						</div>
					</fieldset>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${que.quFormat eq 'checkBox'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>	
						<p><input type="text" name="quTitle" class="input-bar add-question" value="${que.quTitle}" disabled/></p>
						<p><input type="hidden" name="format" value="checkBox" /></p>
						<div class="choose-question-container">
	
						</div>
					</fieldset>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${que.quFormat eq 'dropDown'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>	
						<p><input type="text" name="quTitle" class="input-bar add-question" value="${que.quTitle}" disabled/></p>
						<p><input type="hidden" name="format" value="dropDown" /></p>
						<div class="choose-question-container">

						</div>
					</fieldset>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:when>
	
	<c:otherwise>
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
			<c:choose>
				<c:when test="${que.quFormat eq 'checkBox'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>	
						<p><input type="text" name="quTitle" placeholder="체크박스 질문" class="input-bar add-question" value="${que.quTitle}" required/></p>
						<p><input type="hidden" name="format" value="checkBox" /></p>
						<div class="choose-question-container">
							<p class="choose-question-box">
								<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input type="checkbox" name="option" disabled/>
								<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" required/>
							</p>
						</div>
						<div class="add-question-btn-box">
							<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
							<button type="button" class="add-choose-btn" onclick="addOption('checkbox',this)"><i class="fas fa-plus"></i></button>
						</div>
					</fieldset>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${que.quFormat eq 'dropDown'}">
					<fieldset class="question">
						<p><input type="hidden" name="questionIdx" value="${que.quIdx}" /></p>	
						<p><input type="text" name="quTitle" placeholder="드롭다운 질문" class="input-bar add-question" value="${que.quTitle}" required/></p>
						<p><input type="hidden" name="format" value="dropDown" /></p>
						<div class="choose-question-container">
							<p class="choose-question-box">
								<span class="firstOptionSpace">&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" required/>
							</p>
						</div>
						<div class="add-question-btn-box">
							<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
							<button type="button" class="add-choose-btn" onclick="addOption('dropdown',this)"><i class="fas fa-plus"></i></button>
						</div>
					</fieldset>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:otherwise>
</c:choose>

</body>