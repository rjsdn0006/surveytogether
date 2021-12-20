/* ------------------------ top버튼 영역 ------------------------ */

$(document).on("click",".top-btn",function(){
	$('html, body').animate({
		scrollTop: 0
	}, 300);
})

/* ------------------------ +버튼 Modal영역 ------------------------ */

$(document).on("click",".add-btn",function(){
 	$('#select-box').bPopup({
 		followSpeed: 'fast',
 		opacity: 0.5,
 		speed: 100
 	});
});
 	
$(document).on("click",".select-success-btn",function(){
 	let selectContentList = $("input[name=select-content]");
 	for(let i=0; i<selectContentList.length; i++){
 		if(selectContentList[i].checked == true){
 			let checkedOption = selectContentList[i].value;
 			return addQuestion(checkedOption);
 		}
 	}
 	alert("체크해주세요");	
 });
 	
 function addQuestion(checkedOption){
 	$('#select-box').bPopup().close();
 	
 	let addHtml = "";
 	
 	if(checkedOption=="shortSentence"){
 		addHtml = 
 		`	
		<fieldset class="question">
			<p><input type="text" name="quTitle" placeholder="단답형 질문" class="input-bar add-question" required/></p>
			<p><input type="hidden" name="format" value="shortSentence" /></p>
			<p><input type="text" placeholder="단답형 답변을 받게됩니다." class="input-bar" disabled/></p>
			<div class="add-question-btn-box">
				<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
			</div>
		</fieldset>
 		`;
 	}else if(checkedOption=="longSentence"){
		addHtml = 
		`
		<fieldset class="question">
			<p><input type="text" name="quTitle" placeholder="장문형 질문" class="input-bar add-question" required/></p>
			<p><input type="hidden" name="format" value="longSentence" /></p>
			<p><input type="text" name="" placeholder="장문형 답변을 받게됩니다." class="input-bar" disabled/></p>
			<div class="add-question-btn-box">
				<button type="button" class="trash-btn" onclick="deleteQuestion(this)"><i class="far fa-trash-alt"></i></button>
			</div>
		</fieldset>
		`;
	}else if(checkedOption=="multipleChoice"){
		addHtml = 
		`
		<fieldset class="question">
			<p><input type="text" name="quTitle" placeholder="객관식 질문" class="input-bar add-question" required/></p>
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
		`;
	}else if(checkedOption=="checkBox"){
		addHtml =
		`
		<fieldset class="question">
			<p><input type="text" name="quTitle" placeholder="체크박스 질문" class="input-bar add-question" required/></p>
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
		`;
	}else if(checkedOption=="dropDown"){
		addHtml =
		`
		<fieldset class="question">
			<p><input type="text" name="quTitle" placeholder="드롭다운 질문" class="input-bar add-question" required/></p>
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
		`;
	}
 	
 	$(".add-survey-box").append(addHtml);
 	
 };
 
 /* ------------------------ Question영역 ------------------------ */
 
function deleteQuestion(param){
	// param : .treash-btn
	let trashBtn = $(param);
	trashBtn.parent().parent().remove();
}

function addOption(param,thisParam){
	// param : radio, checkbox, dropdown 
	// thisParam : .add-choose-btn
	let addHtml = "";
	let addChooseBtn = $(thisParam);
	let container = addChooseBtn.parent().prev();
	
	if(param=="dropdown"){
		addHtml+=
		`
		<p class="choose-question-box">
			<button type="button" class="choose-question-delete-btn" onclick="removeOption(this)">X</button>
			<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" required/>
		</p>
		`;
	}else{
		addHtml+=
		`
		<p class="choose-question-box">
			<button type="button" class="choose-question-delete-btn" onclick="removeOption(this)">X</button>
			<input type="${param}" name="option" disabled/>
			<input type="text" placeholder="추가된 옵션" class="choose-question-option-desc" required/>
		</p>
		`;
	}
	container.append(addHtml);
}

function removeOption(param){
	 
	// param : .choose-question-delete-btn
	let deleteBtn = $(param);
	deleteBtn.parent().remove();
}

 /* ------------------------ 저장영역 ------------------------ */
function saveSurvey(){
    // survey에 <- questionList담고 <- questionOptionList담고 , 최종적으로 survey 만을 넘겨주는 방식. 

	let questionList = [];
	let fieldsetList = $('fieldset.question');
	$.each(fieldsetList, function(index, fieldset){
		let question = new Object();
		question.quTitle = fieldset.querySelector("input[name='quTitle']").value;
		question.quFormat = fieldset.querySelector("input[name='format']").value;

		if(question.quFormat!='shortSentence' && question.quFormat!='longSentence'){
			// 객관식, 체크박스, 드롭다운이라면 옵션이 존재할것이다. 
			let optionList = [];
			let optionWrapper = fieldset.querySelectorAll("input.choose-question-option-desc");

			for(let i=0; i<optionWrapper.length; i++){
				let option = new Object();
				option.opName = optionWrapper[i].value;
				optionList.push(option);
			}
			question.questionOptionList = optionList;
		}
		questionList.push(question);
	});
	
	let loginUser = $(".userId").val();
	let surveyIdx = $(".surveyIdx").val();
	
	let survey = {
        suWriter : loginUser,
        suTitle : $('.survey-title').val(),
        suDesc : $('.survey-desc').val(),
        questionList : questionList,
		suIdx : surveyIdx
    };

	$.ajax({
		url: "/user/savesurvey",
		method: "post",
		data: JSON.stringify(survey),
		contentType: "application/json"
	}).done(function(){
		alert("등록되었습니다.");
		location.href = "/user/mysurvey";
		/* ajax는 비동기식으로 동작하기때문에 url호출후 페이지 이동이 이루어지지 않는다.
		   그러므로 location.href를 통해서 직접이동시켜줘야 한다.
		*/
	});
}

/* ------------------------ 삭제영역 ------------------------ */
function deleteSurvey(){
	if(confirm("정말 삭제하시겠습니까?")){
		const surveyIdx = $(".surveyIdx").val();
		$.ajax({
			url: "/user/deletesurvey",
			method: "post",
			data: {suIdx:surveyIdx}
		}).done(function(){
			location.href = "/user/mysurvey";
		});
	}
}
 /* ------------------------ 수정일 경우 question 불러오기 ------------------------ */
$(function(){
	if($(".surveyIdx")!=null){
		// surveyIdx class가 있을경우 ( 즉 edit 수정작업일경우 )
		loadQuestion($(".surveyIdx").val());
	}
});

function loadQuestion(param){
	// param에는 suIdx가 들어있다.
	$.ajax({
		url: "/user/loadquestion",
		method: "get",
		data: {suIdx:param}
	}).done(function(questionPage){
		$(".add-survey-box").html(questionPage);
		loadOption(); // question fieldset이 만들어진후 option도 만들어준다.
	});
}
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
		
		let questionFormat = fieldset.querySelector("input[name='format']").value;
		
		if(questionFormat!='shortSentence' && questionFormat!='longSentence'){
			// 객관식, 체크박스, 드롭다운이라면 옵션이 존재할것이다. 
			let questionIdx = fieldset.querySelector("input[name='questionIdx']").value;
			
			$.ajax({
				url: "/user/loadoption",
				method: "get",
				data: {quIdx:questionIdx, quFormat:questionFormat}
			}).done(function(optionPage){
				fieldset.querySelector(".choose-question-container").innerHTML = optionPage;
			});
		}
	});
	
}