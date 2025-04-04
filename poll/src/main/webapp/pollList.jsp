<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.LocalDate" %>

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
	int lastPage = paging.getLastPage(questionDao.getTotal());
	ArrayList<HashMap<String, Object>> list = questionDao.selectQuestionList(paging);
	
	
	// 오늘 날짜 구하기
	Calendar today = Calendar.getInstance();
	// yyyy-mm-dd
	int year = today.get(Calendar.YEAR);
	int month = today.get(Calendar.MONTH) + 1;
	int date = today.get(Calendar.DATE);
	
	String strToday = year+"-";
	
	if(month < 10) {
		strToday = strToday + "0" + month + "-";
	} else {
		strToday = strToday + month + "-";
	}
	
	if(date < 10) {
		strToday = strToday + "0" + date;
	} else {
		strToday = strToday + date;
	}
	
	System.out.println("strToday: " + strToday);
	
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pollList</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- nav.jsp 인클루드 | include page 속성값에 프로젝트명(context명) 포함 X -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>설문리스트</h1>
	<!-- foreach문 ArrayList<Question> list 출력 
	링크(startdate <= 오늘날짜 <= enddate) 투표 시작전, 투표 종료, 투표하기 -->
	
	<table class="table table-bordered table-hover">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>시작일</td>
			<td>종료일</td>
			<td>투표 현황</td>
			<td>투표</td>
			<td>삭제</td>
			<td>수정</td>
			<td>종료일수정</td>
			<td>결과</td>
		</tr>
		
		<%
			for(HashMap<String, Object> map : list) {
				String startdate = (String)map.get("startdate");
				String enddate = (String)map.get("enddate");
		%>

				<tr>
					<td><%=map.get("num")%></td>
					<td><%=map.get("title")%></td>
					<td><%=map.get("startdate")%></td>
					<td><%=map.get("enddate")%></td>
					<td><%=map.get("cnt")%>번</td>
					<td>
						<%
							// 오늘 날짜 - 시작일 : 양수 && 종료일 - 오늘 날짜 : 양수
							if(strToday.compareTo(startdate) < 0) {
						%>
								투표이전
						<%		
							} else if(strToday.compareTo(enddate) > 0) {
						%>
								투표종료
						<%		
							} else{
						%>
								<a href='/poll/updateItemForm.jsp?qnum=<%=map.get("num")%>'>투표하기</a>
						<%		
							}
						%>
					</td>
					<td>
						<%
							if((Integer)(map.get("cnt")) > 0) {
						%>
								삭제불가 
						<%		
							} else {
						%>
								<a href="">삭제하기</a>
						<%		
							}
						%>
					</td>
					<td>
						<%
							if((Integer)(map.get("cnt")) > 0) {
						%>
								수정불가
						<%		
							} else {
						%>
								<a href='/poll/updatePollForm.jsp?qnum=<%=map.get("num")%>'>수정하기</a>
						<%		
							}
						%>
					</td>
					<td>
						<%
							if(enddate.compareTo(strToday) >= 0) {
						%>
								<a href="">종료일 수정</a>
						<%		
							} else {
						%>
								수정불가
						<%		
							}
						%>
					</td>
					<td>
						<%
							if(strToday.compareTo(enddate) > 0) {
						%>
								<a href='/poll/questionOneResult.jsp?qnum=<%=map.get("num")%>'>결과보기</a>
						<%		
							} else {
						%>
								투표진행중
						<%		
							}
						%>
					</td>
				</tr>
		<%	
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<%
	 	if(currentPage > 1) {
	%>	 
			<a href="/poll/pollList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
	<%	 
		}
	%>
	
	[<%=currentPage%>]
	
	<%
	 	if(currentPage < lastPage) {
	%>	 
			<a href="/poll/pollList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
	<%	 
		}
	%>
	
</body>
</html>