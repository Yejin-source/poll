<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String enddate = request.getParameter("enddate");
	System.out.println("updateQuestionEnddateAction.jsp num: " + num);
	System.out.println("updateQuestionEnddateAction.jsp enddate: " + enddate);
	

	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestionEnddate(num, enddate);
	
	
	response.sendRedirect("/poll/pollList.jsp");
%>