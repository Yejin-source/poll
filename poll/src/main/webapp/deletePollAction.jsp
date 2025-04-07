<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("deletePollAction.jsp num: " + num);

	// Model 객체 생성
	ItemDao itemDao = new ItemDao();
	QuestionDao questionDao = new QuestionDao();
	
	
	itemDao.deleteItem(num);
	questionDao.deleteQuestion(num);
	
	response.sendRedirect("/poll/pollList.jsp");
%>