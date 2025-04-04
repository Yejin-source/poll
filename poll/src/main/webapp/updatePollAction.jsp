<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	String title = request.getParameter("title");
	int type = Integer.parseInt(request.getParameter("type")); 
	
	String[] content = request.getParameterValues("content"); 
			
	QuestionDao questionDao = new QuestionDao();
	

	// 여기부터 다시
	
	response.sendRedirect("/poll/pollList.jsp");
%>