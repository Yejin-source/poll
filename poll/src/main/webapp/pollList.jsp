<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>

<!-- Controller -->
<%
	// question 테이블 리스트 -> 페이징 -> 링크(startdate <= 오늘날짜 <= enddate) -> 투표 프로그램
	// QuestionDao.selectQuestionList(Paging)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
	
	
	// 오늘 날짜 구하기
	Calendar c = Calendar.getInstance();
	int todayYear = c.get(Calendar.YEAR);
	int todayMonth = c.get(Calendar.MONTH) - 1;
	int todayDate = c.get(Calendar.DATE);
	
	
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문리스트</h1>
	<!-- foreach문 ArrayList<Question> list 출력 
	링크(startdate <= 오늘날짜 <= enddate) 투표 시작전, 투표 종료, 투표하기 -->
	
	<form>
		<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>시작 날짜</td>
			<td>종료 날짜</td>
			<td>투표</td>
		</tr>
	<%
		for(Question q : list) {
	%>	
			<tr>
				<td><%=q.getNum()%></td>
				<td><%=q.getTitle()%></td>
				<td><%=q.getStartdate()%></td>
				<td><%=q.getEnddate()%></td>
				<td>
					<%
						if(Integer.valueOf(q.getStartdate().substring(0, 4)) <= todayYear
								&& Integer.valueOf(q.getStartdate().substring(5, 7)) <= todayMonth
								&& Integer.valueOf(q.getStartdate().substring(8)) <= todayDate
								
							|| Integer.valueOf(q.getEnddate().substring(0, 4)) >= todayYear
								&& Integer.valueOf(q.getEnddate().substring(5, 7)) >= todayMonth
								&& Integer.valueOf(q.getEnddate().substring(8)) >= todayDate) {
					%>
							<a href="">투표하기</a>
					<%				
						} else{
					%>
							<a>투표기간 X</a>
					<%		
						}
					%>
					
				</td>
			</tr>
	<%	
		}
	%>
		</table>
	</form>
</body>
</html>