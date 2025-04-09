<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>이미지 올리기</title>
    </head>
    <body>
    <form action="/poll/imageBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data">
    <!-- enctype="application/x-www-form-urlencoded" -> 디폴트값_문자열 -->
		<div>메모: <input type="text" name="title" /></div>
		<div>이미지: <input type="file" name="imageFile" /></div>
		<button type="submit">이미지 등록</button>
    </form>
    </body>
</html>