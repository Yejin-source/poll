<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- CSS 스타일 정의 -->
	<style>
		p {color:orange;}
		#one {color:blue;}
		.two {color:green;}
		.three {background-color:yellow;}
	</style>
	
</head>
<body>
	<div>GOOD</div>
	<p>GOOD</p>
	
	<div id="one">GOOD</div> <!-- id가 one인 걸 찾아서 바꾸기 -->
	<div class="two">GOOD</div> <!-- class에서 tow인 걸 모두 찾아서 바꾸기 -->
	
	<div class="two three">GOOD</div> <!-- CSS는 대부분 class를 사용함 -->
	<div class="two">TEST</div>
</body>
</html>