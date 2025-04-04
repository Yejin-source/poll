<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>

<%
	// ?번 문제와 아이템들 출력
	// type = 1 아이템 타입 -> checkbox
	// type = 0 아이템 타입 -> radio
	
	// 코드를 짜기 전에 쿼리를 하나로 할지 나눌지 생각할 것!
	// JOIN을 하는 이점이 없다면 안 하는 게 훨씬 좋음
	
	// Controller Layer(request 분석 + Model Layer 호출/반환)
	int qnum = Integer.parseInt(request.getParameter("qnum")); 
	// 어떤 이름으로 받든 상관없음 | num으로 던졌어도 qnum으로 받을 수 있는 것 
	
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestionOne(qnum);
	
	// 2) 1)의 itemsList
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
	
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
</head>
<body>
	<h1>투표하기</h1>
	<form action="/poll/updateItemAction.jsp" method="post">
		<input type="hidden" name="qnum" value="<%=qnum%>">
		<table border="1">
			<tr>
				<td>
					Q : <%=question.getTitle()%>
					(<%=question.getType() == 1 ? "복수투표가능" : "복수투표불가"%>) <!-- 삼항연산자 -->
				</td>
			</tr>
			<tr>
				<td>
					<%
						for(Item i : itemList) {
					%>
							<div>
								<%
									if(question.getType() == 0) { // type = radio
								%>
										<input type="radio" value="<%=i.getInum()%>" name="inum">
								<%		
									} else { // type = checkbox
								%>
										<input type="checkbox" value="<%=i.getInum()%>" name="inum">
								<%		
									}
								%>
								<%=i.getContent()%>
							</div>				
					<%
						}
					%>
				</td>
			</tr>
		</table>
		<button type="submit">투표</button>
	</form>
</body>
</html>