<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type")); 
	
	String[] content = request.getParameterValues("content"); 
			
	// question Model 객체 생성
	QuestionDao questionDao = new QuestionDao();
	
	
	// item Model 객체 생성
	ItemDao itemDao = new ItemDao();

	// 여기부터 다시
	
	response.sendRedirect("/poll/pollList.jsp");
%>