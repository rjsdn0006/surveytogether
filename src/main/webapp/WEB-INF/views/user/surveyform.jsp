<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사 만들기</title>
<link rel="stylesheet" href="/css/surveyform.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/script/jquery.bpopup-0.1.1.min.js"></script>
</head>
<body>

<div class="header-bar survey-form">
	<div class="header-box">
		<div class="left-box">
			<span class="header-title">Editor</span>
		</div>
		<div class="right-box">
			<a href="#"><span class="menu1">뒤로가기</span></a>
			<a href="#"><span class="menu2">응답사항</span></a>
			<a href="#"><span class="menu3">저장하기</span></a>
		</div>
	</div>
</div>

<div class="wrapper">
	<form class="surveyForm">
		<fieldset>
			<legend>글제목</legend>
			<p><input type="text" name="surveyTitle" placeholder="설문지 제목" class="input-bar survey-title" /></p>
			<p><textarea name="surveyDesc" placeholder="설문지 설명" class="input-bar"></textarea></p>
		</fieldset>
		<!-- 추가질문목록이 추가되는 영역 -->
		<div class="add-survey-box">
			<!-- 단답형 질문이 추가된다고 생각해보자 -->
			<fieldset>
				<p><input type="text" name="" placeholder="질문" class="input-bar add-question" /></p>
				<p><input type="text" name="" placeholder="단답형 답변을 받게됩니다." class="input-bar" disabled/></p>
				<div class="add-question-btn-box">
					<button class="trash-btn"><i class="far fa-trash-alt"></i></button>
				</div>
			</fieldset>
			<!-- 장문형 질문이 추가된다고 생각해보자 -->
			<fieldset>
				<p><input type="text" name="" placeholder="질문" class="input-bar add-question" /></p>
				<p><input type="text" name="" placeholder="장문형 답변을 받게됩니다." class="input-bar" disabled/></p>
				<div class="add-question-btn-box">
					<button class="trash-btn"><i class="far fa-trash-alt"></i></button>
				</div>
			</fieldset>
			<!-- 객관식 질문이 추가된다고 생각해보자 -->
			<fieldset>
				<p><input type="text" name="" placeholder="질문" class="input-bar add-question" /></p>
				<p class="choose-question-box">
					<button class="choose-question-delete-btn">X</button>
					<input type="radio" name="option" id="option1" disabled/>
					<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc"/>
				</p>
				<div class="add-question-btn-box">
					<button class="trash-btn"><i class="far fa-trash-alt"></i></button>
					<button class="add-choose-btn"><i class="fas fa-plus"></i></button>
				</div>
			</fieldset>
			<!-- 체크박스 질문이 추가된다고 생각해보자 -->
			<fieldset>
				<p><input type="text" name="" placeholder="질문" class="input-bar add-question" /></p>
				<p class="choose-question-box">
					<button class="choose-question-delete-btn">X</button>
					<input type="checkbox" name="option" id="option1" disabled/>
					<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc"/>
				</p>
				<div class="add-question-btn-box">
					<button class="trash-btn"><i class="far fa-trash-alt"></i></button>
					<button class="add-choose-btn"><i class="fas fa-plus"></i></button>
				</div>
			</fieldset>
		</div>
	</form>
	
	<div class="side-box">
		<div class="add-btn side-btn">
			<i class="fas fa-plus-circle"></i>
		</div>
		<div class="top-btn side-btn">
			<i class="fas fa-arrow-circle-up"></i>
		</div>
	</div>
</div>


<div id="select-box">
	<div class="select-header">
		<a class="b-close"><i class="fas fa-times"></i></a>
	    <p class="b-title">질문형식선택</p>
	</div>
  	<form action="#" class="select-content">
  		<input type="radio" id="shortSentence" name="select-content" value="shortSentence"/>
	    <label for="shortSentence">단답형</label>
	    <input type="radio" id="longSentence" name="select-content" value="longSentence"/>
	    <label for="longSentence">장문형</label>
	    <input type="radio" id="multipleChoice" name="select-content" value="multipleChoice"/>
	    <label for="multipleChoice">객관식</label>
	    <input type="radio" id="checkBox" name="select-content" value="checkBox"/>
	    <label for="checkBox">체크박스</label>
	    <input type="radio" id="dropDown" name="select-content" value="dropDown"/>
	    <label for="dropDown">드롭다운</label>
	   	<p class="select-success-box"><button type="submit" class="select-success-btn">선택완료</button></p>
  	</form>
</div>

<script>
 	$(document).on("click",".add-btn",function(){
 		$('#select-box').bPopup({
 			followSpeed: 'fast',
 			opacity: 0.5,
 			speed: 100
 		});
 	});
</script>
</body>
</html>