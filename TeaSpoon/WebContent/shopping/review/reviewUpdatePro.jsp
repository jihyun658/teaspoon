<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

int review_no = Integer.parseInt(request.getParameter("review_no"));
double rating = Double.parseDouble(request.getParameter("rating"));
String content = request.getParameter("content");

ReviewDataBean review = new ReviewDataBean();
review.setReview_no(review_no);
review.setRating(rating);
review.setContent(content);

ReviewDBBean dbPro = ReviewDBBean.getInstance();
dbPro.updateReview(review);
%>
<script>
alert('수정되었습니다.');
opener.parent.location.reload();
window.close();
</script>
</body>
</html>