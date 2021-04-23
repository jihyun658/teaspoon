<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_qna.*, java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" class="shop.board_qna.BoardQnaDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean> 

<%
String pageNum = request.getParameter("pageNum");
BoardQnaDBBean dbPro = BoardQnaDBBean.getInstance();
// -1: 작성자가 일치하지 않을 때
int check = dbPro.updateArticle(article);

if(check == 1) {
	out.print("<script>location='listBoardQna.jsp?pageNum=" + pageNum + "';</script>");
} else if(check == 0) {
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
} else if(check == -1) {
	out.print("<script>alert('아이디가 일치하지 않습니다.'); history.go(-1);</script>");
}
%>
</body>
</html>