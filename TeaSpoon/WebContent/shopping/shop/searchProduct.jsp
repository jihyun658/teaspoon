<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="etc/shopAll.css" rel="stylesheet" type="text/css">
<title>제품 검색</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
%>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
<section>
<%
String search = request.getParameter("search");
String order_by = request.getParameter("order_by");
//페이징 처리를 위한 변수 지정
int pageSize = 12; // 한 페이지에서 보여줄 글수
String pageNum = request.getParameter("pageNum"); // 현재 페이지 번호
if(pageNum == null) pageNum = "1";
int currentPage = Integer.parseInt(pageNum); // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
int endRow = currentPage * pageSize;			 // 페이지의 마지막 글

DecimalFormat df = new DecimalFormat("#,###,###.####");
int number = 0;
int count = 0;
	
ProductDBBean dbPro = ProductDBBean.getInstance();
List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
count = dbPro.searchCount(search);

if(count > 0) { // 등록된 상품이 있다면
	productList = dbPro.searchProducts(search, order_by, startRow-1, pageSize);
}
%>
	<h3>"<%=search %>" 검색 결과</h3>
	<form action="searchProduct.jsp">
		<input type="text" name="search" placeholder="검색 단어 입력후 엔터를 눌러주세요.">
		<input type="submit" value="검색">
	</form>
	<p>검색된 상품 <span><%=count %></span>개</p>
	<div class="content">
		<ul>
		<li><a href="searchProduct.jsp?search=<%=search %>&order_by=reg_date">최신순</a></li>
		<li><a href="searchProduct.jsp?search=<%=search %>&order_by=view_count">인기순</a></li>
		<li><a href="searchProduct.jsp?search=<%=search %>&order_by=sales_volume">판매순</a></li>
	</ul>
<%
	if(count == 0) {%>
	<p>검색된 상품이 없습니다.</p>
	<%}
	for(int i=0; i<productList.size(); i++) {
		int product_id = productList.get(i).getProduct_id();
		String product_image = "../../image_tea/" +  productList.get(i).getProduct_image1();
		String product_title = productList.get(i).getProduct_title();
		int product_price = productList.get(i).getProduct_price();
		int discount_rate = productList.get(i).getDiscount_rate();
		int discount_price = product_price - (product_price*discount_rate/100);
%>
		<div class="article">
		<a href="productContent.jsp?product_id=<%=product_id%>">
			<img src=<%=product_image %>><br>
			<span class="title"><%=product_title %></span><br>
			<span class="product_price"><%=product_price %>원</span>
			<span class="discount_price"><%=discount_price %>원</span><br>
		</a>
		</div>
<%} 
%>
	</div>
 	<div id="paging">
	<%
	// 페이징 처리(paging)
	/*
	pageCount : 전체 페이지수
	currentPage : 현재 페이지
	startPage : 현재 페이지 아래쪽에 페이징되는 첫번째 글
	endPage : 현재 페이지 아래쪽에 페이징되는 마지막 글
	pageBlock : 페이징 처리에서 보여지는 페이지 블럭의 수
	count : 전체 게시글
	(전체게시글 / 페이지 사이즈 (10))올림 = 전체 페이지수 
	첫번째 페이지 숫자 = 1
	현재 페이지를 10으로 나누어서 딱 떨어지지 않으면 첫번째 페이지 숫자 = 현재페이지의 10의 자리수 + 1 떨어지면 
	*/
	if(count > 0){
		
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1;
		
		if (currentPage % 10 != 0) startPage = (int) (currentPage / 10) * 10 + 1;
		else startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		
		if (endPage > pageCount) endPage = pageCount;
		if (startPage > 1) { %>
			<div class="pageBox">
				<a href="searchProduct.jsp?search=<%=search %>&pageNum=<%=currentPage-1 %>">&lt;</a>
			</div>
		<%} 
		for(int i=startPage; i<=endPage; i++){
			if(i == currentPage) out.print("<div class='selectPage'>" + i + "</div>");
			else { %>
			<div class="pageBox">
				<a href="searchProduct.jsp?search=<%=search %>&pageNum=<%=i %>"><%=i %></a>
			</div>
			<%}
		}
		if (endPage < pageCount) { %>
			<div class="pageBox">
				<a href="searchProduct.jsp?search=<%=search %>&pageNum=<%=currentPage+1 %>">&gt;</a>
			</div>
	<%}
	}
	%>
	</div>
</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>