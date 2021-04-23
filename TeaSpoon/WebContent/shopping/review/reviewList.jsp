<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품별 리뷰 보기</title>
  <script type="text/javascript" src="../etc/star/jquery.raty.js"></script>
  <script type="text/javascript">
        $(function() {
            $('div#star').raty({
            	half : true,
            	scoreName :'rating',
                score: 5
                ,path : "../etc/star/images"
                ,click: function(score, evt) {
                    $("#rating").html(score);
                }
            	});
            });
        
         
         // 리뷰 수정 창 열기
        function updatePopUp(review_no){
        		var popUrl = "../review/updateReview.jsp?review_no=" + review_no;	
        		var popOption = "width=500, height=400, top=100, left=200, resizable=no, scrollbars=no, status=no;";
        			window.open(popUrl,"",popOption);
        		}

    </script>
    <style>
    .container2 table{text-align: left; margin:100px auto;}
    .container2 td{padding:10px;}
    .container2 textarea{margin: 0 auto; width:700px; height: 80px;}
    .container2 input[type="submit"]{ height: 120px; vertical-align: middle; background-color: #E2AA87; 
    color:white; border: 2px solid #E2AA87; font-size: 1em}
	.container2 input[type="submit"]:hover{    
	color: #E2AA87;
    background-color: #FEF7E1;
    border: 2px solid #E2AA87; font-weight: bold}
    label{font-size:0.8em;}
    #star {margin: 0 auto; text-align: center; display: inline-block;}
    #rating{margin-left: 20px;font-weight: bold; font-size:1.2em; color:blue}
    .container2 ul{list-style: none}
    .container2 ul li{display: inline-block; }
    </style>
</head>
<body>

<div class="container2">
	<%
	String member_id = (String)session.getAttribute("id");
	
	int pageSize = 10; // 페이지 사이즈, 한 페이지에서 보여줄 글수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	int p_id = Integer.parseInt(request.getParameter("product_id"));
	if(pageNum == null) pageNum = "1";
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
	int end = currentPage * pageSize;			 // 페이지의 마지막 글
	int count = 0; // 전체 글수
	int number = 0; // 전체 글수 역순 번호
	
	List<ReviewDataBean> reviewList = null;
	ReviewDBBean dbPro = ReviewDBBean.getInstance();
	count = dbPro.getReviewCount(p_id); // 전체 글수 (product_id 별로)
	double rating = dbPro.getRatingAVG(p_id); // 상품별 평점
	if(count > 0) reviewList = dbPro.getReviewList(start, end, p_id);
	// 전체 글수 역순 번호 - 현재 페이지마다 달라서 매번 계산
	number = count - (currentPage - 1) * pageSize;
	// 전체 페이지 수
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	%>
	<div class="menu">
	<ul>
		<li><a href="#content">상품 상세정보</a></li>
		<li><a href="#delivery">배송 안내</a></li>
		<li id="review"><a href="#review">리뷰(<%=count %>)</a></li>
		<li><a href="#FAQ">FAQ</a></li>
	</ul>
		</div>
	<div>
		총 평점 : <%=rating %>
	</div>
	<!-- 리뷰 등록 -->
	<form action="../review/reviewInsert.jsp">
		<table>
			<tr>
				<td>
				<input type="hidden" name="product_id" value="<%=p_id %>">
			    <div id="star" ></div><span id="rating">5</span>
				</td>
				<td rowspan="2">
				<input type="submit" value="리뷰등록">
				</td>
			</tr>
			<tr>
				<td>
				<textarea name="content" rows="" cols=""></textarea>
				</td>
			</tr>
		</table>
	</form>
	
	<%
			if(count == 0) {
		%> <%-- 글이 없을 때 --%>
		<table><tr><td>등록된 리뷰가 없습니다.</td></tr></table>
	<%
		} else {
	%> 
	<%-- 글이 있을 때 --%>
	<%
		for(ReviewDataBean review : reviewList) {
			%>
		<div>
			<%
			for(int i=0; i<review.getRating()-1; i++){%>
			<img alt="" src="../etc/star/images/star-on.png">
			<%} %>
			<%if(review.getRating()%1 == 0){%>
			<img alt="" src="../etc/star/images/star-on.png">
			<%} else { %>
			<img alt="" src="../etc/star/images/star-half.png"><%} %>
			<span><%=review.getRating() %></span>
		<ul>
			<li><%=review.getMember_id() %> &nbsp; <%=sdf.format(review.getReg_date()) %></li>
			<%if(review.getMember_id().equals(member_id)) { // 작성자와 로그인된 아이디가 같을 때 수정 / 삭제 가능%>
			<li><a href="javascript:updatePopUp(<%=review.getReview_no()%>);">수정하기</a> / <a href="../review/deleteReview.jsp?review_no=<%=review.getReview_no()%>">삭제하기</a></li>
			<%} %>
		</ul>
		<ul>
			<li><%=review.getContent() %></li>
		</ul>
		</div>	
			<%}%>
	<%} %>
	
	<%--
	pageCount : 전체 페이지수
	currentPage : 현재 페이지
	startPage : 현재 페이지 아래쪽에 페이징되는 첫번째 글
	endPage : 현재 페이지 아래쪽에 페이징되는 마지막 글
	pageBlock : 페이징 처리에서 보여지는 페이지 블럭의 수
	 --%>
	
	<div id="paging">
	<%
	// 페이징 처리(paging)
	if(count > 0) {
		int startPage = 1;
		
		if(currentPage%10 != 0) startPage = (int)(currentPage/10)*10 + 1;
		else startPage = ((int)(currentPage/10)-1)*10 + 1;
		
		int pageBlock = 10; // 페이징처리에서 보여질 페이지 블럭의 수
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10) {
			out.print("<a href='listBoardReview.jsp?pageNum=" + (startPage-10) 
					+ "'><div id='pbox' class='pagebox2'>&lt</div></a>");
		}
		for(int i=startPage; i<=endPage; i++) {
			if (i == currentPage) { // 해당 페이지 선택 상태
				out.print("<div id='pbox' class='pagebox1'>" + i + "</div>");
			} else { // 선택되지 않은 상태
				out.print("<a href='listBoardReview.jsp?pageNum=" + i 
				+ "'><div id='pbox' class='pagebox2'>" + i + "</div></a>");
			}
		}
		if(endPage < pageCount) {
			out.print("<a href='listBoardReview.jsp?pageNum=" + (startPage+10) 
					+ "'><div id='pbox' class='pagebox2'>&gt</div></a>");
		}
	}%>
	</div>
</div>
</body>
</html>