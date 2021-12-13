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
			<p><input type="text" name="" placeholder="장문형 질문" class="input-bar add-question" required/></p>
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
			<p><input type="text" name="" placeholder="객관식 질문" class="input-bar add-question" required/></p>
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
			<p><input type="text" name="" placeholder="체크박스 질문" class="input-bar add-question" required/></p>
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
			<p><input type="text" name="" placeholder="드롭다운 질문" class="input-bar add-question" required/></p>
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
	
	// children()은 부모 요소의 바로 아래 단계인 자식만, find()는 부모 태그의 모든 하위 요소선택 가능
	let fieldsetList = $('fieldset.question');
	$.each(fieldsetList, function(index, fieldset){
		console.log(fieldset.find("input[name='quTitle']"));
	});

	
	
	
	let survey = {
        suTitle : $('.survey-title').val(),
        suDesc : $('.survey-desc').val()
    };
    let question = {
	 	//가져왔다고 가정 
	};
	let questionOption = {
		// 가져왔다고 가정
	};
    
    let allData = {"survey":survey,"question":question,"questionOption":questionOption};
    
	
	$.ajax({
		url:"/user/savesurvey",
		method:"post",
		data:JSON.stringify(allData),
		contentType: "application/json"
	}).done(function(){
		alert("완료");	
	});
}