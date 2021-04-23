<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 삭제</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

int review_no = Integer.parseInt(request.getParameter("review_no"));

ReviewDBBean dbPro = ReviewDBBean.getInstance();
dbPro.deleteReview(review_no);
%>
<script>
alert('삭제되었습니다.');
location.href = document.referrer; //뒤로가기 후 새로고침이 필요할때 사용한다.
</script>
</body>
</html>