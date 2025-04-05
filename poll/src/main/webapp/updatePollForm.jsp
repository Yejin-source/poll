<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	System.out.println("updatePollForm.jsp: " + qnum);	

	// Model 객체 생성
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	// 해당 num 값을 가지는 데이터 행 조회
	Question q = questionDao.selectQuestionOne(qnum);
	ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
	
	int listSize = itemList.size();
	// size() -> 콜렉션 객체(ex. Arratlist) 안에 포함된 요소의 개수 반환 
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePollForm</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>설문 수정</h1>
	<form method="post" action="/poll/insertPollAction.jsp">
		<input type="hidden" name="qnum" value="<%=qnum%>>">
		<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<input type="text" name="title" value="<%=q.getTitle()%>">
				</td>
			</tr>
			<tr>
				<td rowspan="8">항목</td>
				<td>1) <input type="text" name="content" value='<%=listSize > 0 ? itemList.get(0).getContent() : ""%>'></td>
				<td>2) <input type="text" name="content" value='<%=listSize > 1 ? itemList.get(1).getContent() : ""%>'></td>
			</tr>
			<tr>
				<td>3) <input type="text" name="content" value='<%=listSize > 2 ? itemList.get(2).getContent() : ""%>'></td>
				<td>4) <input type="text" name="content" value='<%=listSize > 3 ? itemList.get(3).getContent() : ""%>'></td>
			</tr>
			<tr>
				<td>5) <input type="text" name="content" value='<%=listSize > 4 ? itemList.get(4).getContent() : ""%>'></td>
				<td>6) <input type="text" name="content" value='<%=listSize > 5 ? itemList.get(5).getContent() : ""%>'></td>
			</tr>
			<tr>
				<td>7) <input type="text" name="content" value='<%=listSize > 6 ? itemList.get(6).getContent() : ""%>'></td>
				<td>8) <input type="text" name="content" value='<%=listSize > 7 ? itemList.get(7).getContent() : ""%>'></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date" name="startdate" value="<%=q.getStartdate()%>"></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%=q.getEnddate()%>"></td>
			</tr>
			<tr>
				<td>복수투표</td>
				<td>
					<input type="radio" name="type" value="1" <% if(q.getType() == 1) {%> checked <%}%>>yes
					<input type="radio" name="type" value="0" <% if(q.getType() == 0) {%> checked <%}%>>no
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>