
/* ------------------------ 저장영역 ------------------------ */
function doneSurvey(){
    // survey에 <- questionList담고 <- questionOptionList담고 , 최종적으로 survey 만을 넘겨주는 방식. 
	let answerUser = $(".userId").val();
	
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