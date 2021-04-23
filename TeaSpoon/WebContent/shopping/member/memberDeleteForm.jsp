<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="etc/memberLogin.css" rel="stylesheet" type="text/css">
</head>
<body>
<div>
<%@ include file="../common/shopTop.jsp" %>
	<section>
        <p class="form_title">회원 탈퇴</p>
        <hr color="#EDD8BB" size="1px">
        <form class="form" action="memberDeletePro.jsp" method="POST">
            <%=id %><br>
            <input type="password" name="passwd" placeholder="Password" required><br>
            <input type="submit" value="회원탈퇴">
        </form>
	</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>