<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>

<%
	// Controller : request 분석 + model 호출
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	
	// 1) questionOne | 문제 출력
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestionOne(qnum);
	
	// 2) 1)의 itemsList | item 출력
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
	
	// 3) 총 투표수
	int totalCount = itemDao.selectItemCountByQnum(qnum);
%>


<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<!-- nav.jsp 인클루드 -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1><%=qnum%>번 설문 투표결과</h1>
	<table border="1" width="80%">
		<tr>
			<td colspan="4">
				Q : <%=question.getTitle()%>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				총 투표수: <%=totalCount%>
			</td>
		</tr>
		<tr>
			<td>번호</td><td>내용</td><td>카운트(차트)</td><td>카운트</td>
		</tr>		
		<%
			for(Item i : itemList) {
		%>
				<tr>
					<td><%=i.getInum()%></td>
					<td><%=i.getContent()%></td>
					<td>
						<!-- 각 count값에 대한 백분율 값 | 백분율은 double로 형 변환을 할 것 -->
						<%
							int percentage = (int)(Math.round((double)i.getCount() / (double)totalCount * 100));
							
							for(int n=1; n<=percentage; n++) {
						%>
								*
						<%		
							}
						%>
					</td>
					<td><%=i.getCount()%></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>