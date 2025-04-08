<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");	

	// 요청받은 매개값 확인
	System.out.println("deleteBoardAction.jsp num: " + num);
	System.out.println("deleteBoardAction.jsp pass: " + pass);
	
	// 객체 생성
	Board board = new Board();
	board.setNum(num);
	board.setPass(pass);
	
	// boardDao를 통해 삭제
	BoardDao boardDao = new BoardDao();
	boardDao.deleteBoard(board);
	
	// 뷰가 없으므로 클라이언트에 다른 요청을 강제(리다이렉트)
	response.sendRedirect("/poll/board/boardList.jsp");
%>