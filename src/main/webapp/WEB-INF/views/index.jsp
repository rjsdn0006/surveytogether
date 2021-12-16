<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Survey Together</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="/css/index.css" />
</head>
<body>
<!--  
<div class="header-bar">
	<p class="header-title">Survey Together</p>
</div>
-->

<div class="wrapper">
	<div class="container">
		<i class="fas fa-users header-icon"></i>
		<p class="header-title">Survey Together</p>
		<div class="login-box">
			<form action="/loginProcess" method="POST">
				<p><input type="text" name="username" placeholder="id" class="input-bar" required/></p>
				<p><input type="password" name="password" placeholder="password" class="input-bar" required/></p>
				<label for="remember-me" class="remember-label">Remember</label>
				<input type="checkbox" name="remember-me" id="remember-me" />
				<p><button type="submit" class="btn">로그인</button>
				<a href="/signup"><button type="button"  class="btn">회원가입</button></a></p>
			</form>
		</div>
	</div>
</div>
</body>
</html>