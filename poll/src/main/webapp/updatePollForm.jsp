<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePollForm</title>
</head>
<body>
	<h1>설문 수정</h1>
	<hr>
	<h2>항목 수정</h2>
	<form method="post" action="/poll/insertPollAction.jsp">
		<input type="hidden" name="num" value="<%=num%>>">
		<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<input type="text" name="title" value="">
				</td>
			</tr>
			<tr>
				<td rowspan="8">항목</td>
				<td>1) <input type="text" name="content" value=""></td>
				<td>2) <input type="text" name="content" value=""></td>
			</tr>
			<tr>
				<td>3) <input type="text" name="content" value=""></td>
				<td>4) <input type="text" name="content" value=""></td>
			</tr>
			<tr>
				<td>5) <input type="text" name="content" value=""></td>
				<td>6) <input type="text" name="content" value=""></td>
			</tr>
			<tr>
				<td>7) <input type="text" name="content" value=""></td>
				<td>8) <input type="text" name="content" value=""></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date" name="startdate" value=""></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value=""></td>
			</tr>
			<tr>
				<td>복수투표</td>
				<td>
					<input type="radio" name="type" value="1">yes
					<input type="radio" name="type" value="0">no
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>