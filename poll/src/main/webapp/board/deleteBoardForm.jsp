<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDao boardDao = new BoardDao();
	// boardDao.deleteBoard(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>글 삭제</h1>
	<form method="post" action="/poll/board/deleteBoardAction.jsp">
	<input type="hidden" name="num" value="<%=num%>">
		<table class="table table-striped">
			<tr>
				<th>비밀번호 확인</th> 
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button type="submit">삭제</button>
	</form>
</body>
</html>