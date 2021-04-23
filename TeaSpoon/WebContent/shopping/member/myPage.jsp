<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*, shop.buy.*, shop.board_qna.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
	table img {width:100px; height: 100px; object-fit: contain;}
</style>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
<h4>마이페이지</h4>
<input type="button" onclick="location='memberDeleteForm.jsp'" value="회원탈퇴하기">
<h4>최신 구매 목록</h4>
<%
BuyDBBean buyPro = BuyDBBean.getInstance();
List<HashMap<String,String>> buyList = buyPro.getBuyList(id);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
DecimalFormat df = new DecimalFormat("#,###");
%>
<table>
	<%for(HashMap<String,String> buy : buyList) { 
	Date buy_date = new SimpleDateFormat("yyyy-MM-dd").parse(buy.get("buy_date"));
	%>
	<tr>
		<td><a href="../buy/buyIdList.jsp?buy_id=<%=buy.get("buy_id")%>"><img src="../../image_tea/<%=buy.get("product_image") %>"></a></td>
		<td><a href="../buy/buyIdList.jsp?buy_id=<%=buy.get("buy_id")%>"><%=buy.get("buy_id") %><br><%=buy.get("product_title") %>외 <%=buy.get("et")%>건</a></td>
		<td><%=buy.get("total_price") %>원</td>
		<td><%=sdf.format(buy_date) %></td>
		<td><%=buy.get("delivery_state") %></td>
		<td><input type="button" value="반품요청"><input type="button" value="배송지 변경"></td>
	</tr>
	<%} %>
</table>
<h4>나의 리뷰</h4>
<%
ReviewDBBean dbPro = ReviewDBBean.getInstance();
List<ReviewDataBean> reviewList = dbPro.getMyReview(id, 1, 5);
for(ReviewDataBean review : reviewList){%>
	<p><%=review.getProduct_id() %>
	<%=review.getRating() %>
	<%=review.getContent() %><p>
<%} %>
<h4>나의 문의 내역</h4>
<%
BoardQnaDBBean qnaPro = BoardQnaDBBean.getInstance();
List<BoardQnaDataBean> qnaList = qnaPro.getMyQna(id, 1, 5);
for(BoardQnaDataBean qna : qnaList){%>
	<%=qna.getQ_kind() %>
	<%=qna.getSubject() %>
	<%=qna.getReg_date() %><br>

<%} %>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>