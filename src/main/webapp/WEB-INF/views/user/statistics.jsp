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
</div>

<script>
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
	
	  var data = google.visualization.arrayToDataTable([
	    ['Task', 'Hours per Day'], // [분류, 비중]
	    ['Work',     11],
	    ['Eat',      2],
	    ['Commute',  2],
	    ['Watch TV', 2],
	    ['Sleep',    7]
	  ]);
	
	  var options = {
	    title: 'My Daily Activities'
	  };
	
	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	
	  chart.draw(data, options);
	}
</script>
</body>
</html>