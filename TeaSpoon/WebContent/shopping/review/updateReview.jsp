<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script type="text/javascript" src="../etc/star/jquery.raty.js"></script>
  <script type="text/javascript">
        $(function() {
        	   var s = $("#rating1").text();
            $('div#star').raty({
            	half : true,
            	scoreName :'rating',
            	score : s, width:200
                ,path : "../etc/star/images"
                ,click: function(score, evt) {
                    $("#rating1").html(score);
                }
            	});
            });
   </script>
   <style>
   		h4 { text-align: center;}
   		table{width: 300px; text-align: center; margin: 30px auto; font-size: 0.8em;}
   		#star{margin:0 auto;}
   		textarea{width: 300px; height: 200px;}
   		#rating1{font-weight: bold; color:dakrblue; font-size: 1.2em}
   </style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

int review_no = Integer.parseInt(request.getParameter("review_no"));
ReviewDBBean dbPro = ReviewDBBean.getInstance();
ReviewDataBean review = dbPro.getReview(review_no);
%>
	<form action="../review/reviewUpdatePro.jsp">
	<h4>리뷰 수정</h4>
		<table>
			<tr>
				<td>
				<input type="hidden" name="review_no" value="<%=review_no %>">
				평점 : <span id="rating1"><%=review.getRating() %></span>
			    <div id="star"></div>
				</td>
			</tr>
			<tr>
				<td>
				<textarea name="content" ><%=review.getContent()%></textarea>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="수정"></td>
			</tr>
		</table>
	</form>
</body>
</html>