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
		
		let questionFormat = fieldset.querySelector("input[name='format']").value;
		
		if(questionFormat!='shortSentence' && questionFormat!='longSentence'){
			// 객관식, 체크박스, 드롭다운이라면 옵션이 존재할것이다. 
			let questionIdx = fieldset.querySelector("input[name='questionIdx']").value;
			
			$.ajax({
				url: "/user/loadoption",
				method: "get",
				data: {quIdx:questionIdx, quFormat:questionFormat}
			}).done(function(optionPage){
				$(".choose-question-container").html(optionPage);
			});
		}
	});
	
}