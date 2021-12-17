$(function(){
	loadAnswer();
});

function loadAnswer(){
	const writer = $('.writer').val();
	
	let fieldsetList = $('fieldset.question');
	$.each(fieldsetList, function(index, fieldset){
		let quIdx = fieldset.querySelector('input.quIdx').value;
		$.ajax({
			url: "/user/getanswer",
			method: "get",
			data: {writer:writer, quIdx:quIdx}
		}).done(function(result){
			// result가 list이다.
			let answer = "";

			for(let i=0; i<result.length; i++){
				answer += (result[i]+"&nbsp"+"&nbsp"+"&nbsp");
			}
			
			fieldset.querySelector('div.answer-add-box').innerHTML = answer;
		});
	});
}