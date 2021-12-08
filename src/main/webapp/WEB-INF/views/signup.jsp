<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="/css/index.css" />
</head>
<body>
<div class="header-bar">
	<p class="header-title">회원가입</p>
</div>
<div class="wrapper">
	<i class="far fa-address-card header-icon"></i>
	<div class="login-box">
		<form action="/signupProcess" method="post">
			<p><input type="text" name="username" placeholder="id" class="input-bar"/></p>
			<p><input type="password" name="password" placeholder="password" class="input-bar"/></p>
			<p><input type="text" name="name" placeholder="name" class="input-bar"/></p>
			<p><button type="submit" class="btn register-btn">가입하기</button></p>
		</form>
	</div>
</div>
</body>
</html>