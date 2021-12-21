<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계보기</title>
<link rel="stylesheet" href="/css/surveyform.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>

<!-- Header -->
<div class="header-bar survey-form">
	<div class="header-box">
		<div class="left-box">
			<span class="header-title">Statistics</span>
		</div>
		<div class="right-box">
			<a href="#" onclick="history.back()"><span class="menu1">뒤로가기</span></a>
		</div>
	</div>
</div>
  
<!-- 본문 -->
<div class="wrapper">
	
	<div id="piechart" style="width: 900px; height: 500px;"></div>
	
	<c:forEach items="${questionList}" var="question" varStatus="status">
		<c:if test="${question.quFormat != 'shortSentence'}">
			<c:if test="${question.quFormat != 'longSentence'}">
				<div class="statistics-box">
					<input type="hidden" name="questionName" class="questionName" value="${question.quTitle}">
					<input type="hidden" name="questionIdx" value="${question.quIdx}" />
				</div>
			</c:if>
		</c:if>
	</c:forEach>

	
	
</div>

<script>
	google.charts.load('current', {'packages':['corechart']});
	let answerName = [];
	let answerCount = [];
	let questionName = $('.questionName');
	let i = 0 ;
	
	$(function(){
		loadChartInfo();
	});
	
	function loadChartInfo(){
		
		let statisticsBox = $(".statistics-box");
		
		$.each(statisticsBox,function(index, statistics){
			let quIdx = statistics.querySelector("input[name='questionIdx']").value;
			$.ajax({
				url:"/user/loadResultInfo",
				method:"get",
				data:{quIdx:quIdx}
			}).done(function(result){
				// result에는 resultList가 담겨있다. 
				for(let i=0; i<result.length; i++){
					answerName.push(result[i].reAnswer);
					answerCount.push(result[i].reCount);
				}
				let chartBox = statistics.querySelector("div.chart-box"); // 차트넣을곳 선택 
				google.charts.setOnLoadCallback(drawChart);
		           
			});
		});
		
	};
	
	function drawChart() {
		
	  let array = [];
	  let defaultOption = ['Option','Percentage'];
	  array.push(defaultOption);
	  for(let i=0; i<answerName.length; i++){
		  let box = [];
		  box.push(answerName[i]);
		  box.push(answerCount[i]);
		  array.push(box);
	  }
	  var data = google.visualization.arrayToDataTable(array);
	
	  var options = {
	    title: questionName[i].value
	  };
	
	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	
	  chart.draw(data, options);
	  answerName = []; // 전역변수 이므로 초기화시켜줌
	  answerCount = []; // 위와같음
	  i += 1;
	}
</script>
</body>
</html>