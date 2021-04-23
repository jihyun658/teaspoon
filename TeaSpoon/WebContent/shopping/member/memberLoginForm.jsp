<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 로그인 페이지</title>
<link href="etc/memberLogin.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
	<section>
        <p class="form_title">회원 로그인</p>
        <hr color="#EDD8BB" size="1px">
        <form class="form" action="memberLoginPro.jsp" method="POST">
            <input type="text" name="id" placeholder="ID" required autofocus><br>
            <input type="password" name="passwd" placeholder="Password" required><br>
            <input type="submit" value="LOGIN">
        </form>
	</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>