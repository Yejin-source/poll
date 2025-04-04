<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	String[] inumArr = request.getParameterValues("inum");
	// inumArr 개수만큼 count++ 하는 메서드를 호출
	ItemDao itemDao = new ItemDao();
	for(String inum : inumArr) {
		itemDao.updateItemCountPlus(qnum, Integer.parseInt(inum));
	}
	

	// View 존재하지 않는 프로세스 : JSP(Java Server Page)일 필요가 없음 
	// -> 다른 요청 필요 -> Backend(Server)에서 요청 불가 -> 브라우저에 요청 강제화(<a> 부탁)
	// 웹 브라우저에 요청을 강요해서 톰캣이 받는 것
	response.sendRedirect("/poll/pollList.jsp");
	
%>
