<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_qna.*, java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" class="shop.board_qna.BoardQnaDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()));
BoardQnaDBBean dbPro = BoardQnaDBBean.getInstance();
dbPro.insertArticle(article);
response.sendRedirect("listBoardQna.jsp");
%>
</body>
</html>