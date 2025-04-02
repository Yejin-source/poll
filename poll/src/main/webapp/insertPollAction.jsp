<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>

<%
	// controller(기능: 1.요청값 분석 | 2.모델 호출)
	
	// 1. 요청값 분석
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
		
	// item.content
	String[] content = request.getParameterValues("content");
	
	// 공백 요소 제거 후 새로운 배열(ArrayList<String>)에 저장
	// ex) "a", "b", "c"
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content) {
		if(!c.equals("")) {
			contentList.add(c); // 보기
		}
	}
	System.out.println(contentList); // ArrayList는 바로 출력 가능
	
	
	Question question = new Question();
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);

	
	// 2. Question 모델(DAO메서드) 호출
	QuestionDao questionDao = new QuestionDao();
	int qnum = questionDao.insertQuestion(question);
	
	ArrayList<Item> itemList = new ArrayList<>();
	int i = 1;
	for(String c : contentList) {
		Item item = new Item();
		item.setQnum(qnum);
		item.setInum(i);
		item.setContent(c);
		itemList.add(item);
		i=i+1;
	}	
		
	// 2-1 Item 모델(DAO메서드) 호출
	ItemDao itemDao = new ItemDao();
	for(Item item : itemList) {
		itemDao.insertItem(item);
	}
	
	// view가 필요 없음 -> 새로운 요쳥 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
	
	
	
%>