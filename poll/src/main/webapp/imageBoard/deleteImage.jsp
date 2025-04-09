<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.io.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String filename = request.getParameter("filename");
	
	// 받은 매개변수 값 확인
	System.out.println("deleteImage.jsp num: " + num);
	System.out.println("deleteImage.jsp filename: " + filename);
	
	
	// db 삭제
	ImageDao imageDao = new ImageDao();
	imageDao.deleteImage(num);
	
	
	// 파일 삭제
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path, filename); // new File 경로에 파일이 없으면 빈파일 생성 준비
	if(file.exists()) { // 빈파일이 아니라면
		file.delete();
	}
	
	response.sendRedirect("/poll/imageBoard/imageList.jsp");
%>