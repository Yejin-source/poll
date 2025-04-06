<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	int type = Integer.parseInt(request.getParameter("type")); 
	
	String[] content = request.getParameterValues("content"); 
		
	
	// 항목(content)이 비어있지 않으면 리스트에 저장
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content) {
		if(!c.equals("")) {
			contentList.add(c);
		}
	}
	
	
	// question 객체 생성 후 DAO를 통해 수정
	Question question = new Question();
	question.setNum(num);
	question.setTitle(title);
	question.setType(type);
	
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestion(question);
	
	
	// 항목 객체 리스트 생성
	ArrayList<Item> itemList = new ArrayList<>();
	int i = 1;
	for(String c : content) {
		Item item = new Item();
		item.setQnum(num); // 설문 번호
		item.setInum(i);   // 보기 번호
		item.setContent(c);
		itemList.add(item);
		i++;
	}
	
		
	// item 객체 생성 후 DAO를 통해 삭제
	ItemDao itemDao = new ItemDao();
	itemDao.deleteItem(num);

	// 새 항목 추가
	for(Item item : itemList) {
		itemDao.insertItem(item);
	}

	
	response.sendRedirect("/poll/pollList.jsp");
%>