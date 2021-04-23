<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%

String id = (String)session.getAttribute("id");
//아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

//아이디 세션이 있을 때 (로그인을 했을 때)
int product_id = Integer.parseInt(request.getParameter("product_id"));
double rating = Double.parseDouble(request.getParameter("rating"));
String content = request.getParameter("content");

ReviewDataBean review = new ReviewDataBean();
review.setMember_id(id);
review.setProduct_id(product_id);
review.setRating(rating);
review.setContent(content);

ReviewDBBean dbpro = ReviewDBBean.getInstance();
dbpro.insertReview(review);

out.print("<script>location='../shop/productContent.jsp?product_id=" + product_id + "'</script>");
//response.sendRedirect("../shop/productContent.jsp?product_id=" + product_id);
%>
id : <%=id %>
</body>
</html>