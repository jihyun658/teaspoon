<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<link href="etc/managerLogin.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="container">
        <img src="etc/teaspoon.png" alt="logo">
        <p class="form_title">관리자 로그인</p>
        <hr color="#EDD8BB" size="1px">
        <form class="form" action="managerLoginPro.jsp" method="POST">
            <input type="text" name="id" placeholder="Manager ID" required autofocus><br>
            <input type="password" name="passwd" placeholder="Password" required><br>
            <input type="submit" value="LOGIN">
        </form>
    </div>
</body>
</html>