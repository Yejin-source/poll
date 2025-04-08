<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");	
	String subject = request.getParameter("subject");	
	String content = request.getParameter("content");	

	// 요청받은 매개값 확인
	System.out.println("updateBoardAction.jsp num: " + num);
	System.out.println("updateBoardAction.jsp name: " + name);
	System.out.println("updateBoardAction.jsp subject: " + subject);
	System.out.println("updateBoardAction.jsp content: " + content);
	
	// board 객체 생성
	Board board = new Board();
	board.setNum(num);
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	
	// logging(디버깅 포함)
	System.out.println(board.toString());

	// boardDao를 통해 수정
	BoardDao boardDao = new BoardDao();
	boardDao.updateBoard(board);
	
	// 뷰가 없으므로 클라이언트에 다른 요청을 강제(리다이렉트)
	response.sendRedirect("/poll/board/boardOne.jsp?num="+num);
%>