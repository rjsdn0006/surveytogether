
/* ------------------------ 저장영역 ------------------------ */
function doneSurvey(){
	
	let answerUser = $(".userId").val();
	let fieldsetList = $('fieldset.question');
	
	$.each(fieldsetList, function(index,fieldset){
		let format = fieldset.querySelector("input[name='format']").value;
		let questionIdx = fieldset.querySelector("input[name='questionIdx']").value;
		let answer;
		let stringAnswer = new Object();
		let selectAnswer = new Object();
		
		// format에 따라서 답변을 가져오는 방식이 달라진다. 
		if(format == 'shortSentence' || format == 'longSentence'){
			answer = fieldset.querySelector(".answer").value;
			stringAnswer.straQuestionIdx = questionIdx;
			stringAnswer.straWriter = answerUser;
			stringAnswer.straAnswer = answer;
			
		}else if(format == 'multipleChoice' || format == 'checkBox'){
			let checkedList = fieldset.querySelectorAll("input[class='option']:checked");
			answer = [];
			checkedList.forEach(function(checked){
				answer.push(checked.value);
			}); 
			selectAnswer.selaQuestionIdx = questionIdx;
			selectAnswer.selaWriter = answerUser;
			selectAnswer.selaAnswer = answer;

		}else if(format == 'dropDown'){
			let selectBox =  fieldset.querySelector(".select-box");
			answer = [];
			answer.push(selectBox.options[selectBox.selectedIndex].value); 
			selectAnswer.selaQuestionIdx = questionIdx;
			selectAnswer.selaWriter = answerUser;
			selectAnswer.selaAnswer = answer;
		}
		
		let answerDTO = {
			selectAnswer: selectAnswer,
			stringAnswer: stringAnswer
		};
		
		$.ajax({
			url:"/user/saveanswer",
			method:"post",
			data: JSON.stringify(answerDTO),
			contentType: "application/json"
		}).done(function(){
			
		});
		
		
	});
	alert("설문조사에 참여완료 했습니다.");
	location.href="/user/surveyboard";

}

 /* ------------------------ question 불러오기 ------------------------ */
$(function(){
	let suIdx = $("#surveyIdx").val();
	loadQuestion(suIdx);
});

function loadQuestion(param){
	/* param에는 suIdx가 들어있다.
	 * edit의 loadQuestion과 다른점은, state를 넘겨주어 question.jsp에서 참여용 question 형식을 만들어준다. 
	 */
	let state = 'participation';
	$.ajax({
		url: "/user/loadquestion",
		method: "get",
		data: {suIdx:param, state:state}
	}).done(function(questionPage){
		$(".add-survey-box").html(questionPage);
		loadOption(); // question fieldset이 만들어진후 option도 만들어준다.
	});
}

function loadOption(){
	let fieldsetList = $('fieldset.question');
	$.each(fieldsetList, function(index, fieldset){
		
		let questionFormat = fieldset.querySelector("input[name='format']").value;
		
		if(questionFormat!='shortSentence' && questionFormat!='longSentence'){
			// 객관식, 체크박스, 드롭다운이라면 옵션이 존재할것이다. 
			let questionIdx = fieldset.querySelector("input[name='questionIdx']").value;
			let state = 'participation';
			$.ajax({
				url: "/user/loadoption",
				method: "get",
				data: {quIdx:questionIdx, quFormat:questionFormat, state:state}
			}).done(function(optionPage){
				fieldset.querySelector(".choose-question-container").innerHTML = optionPage;
			});
		}
	});
}
