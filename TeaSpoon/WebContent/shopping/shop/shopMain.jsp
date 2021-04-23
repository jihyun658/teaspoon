<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 메인</title>
<link href="etc/shopMain.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
<section>
<% 
ProductDBBean productPro = ProductDBBean.getInstance();
%>
<script>
$(document).ready(function(){
	$('.slider').bxSlider({
		mode: "horizontal",	// 슬라이드 이동 방향, horizontal, vertical, fade, 기본값: horizontal
		auto : true ,
		speed: 1000,		// 전환 속도
		pause: 4000, 		// 전화 사이의 시간(이미지의 노출시간)
		pager: true,
		slideWidth: 1200,  	// 슬라이드 너비
		slideMargin: 10,	// 슬라이드 사이의 여백
		maxSlides: 1, 		// 슬라이드 최대 노출 개수
		minSlides: 1, 		// 슬라이드 최소 노출 개수
		moveSlide: 1, 		// 슬라이드 이동 개수
		touchEnabled: false, // 웹화면에서 touch 이벤트 제거, 클릭했을때 해당 페이지로 이동하기 위해서
	});
});

// bxslider 클릭시 페이지 이동
function clickProduct(pCategory, pKind) {
	location = "shopAll.jsp?product_category=" + pCategory + "&product_kind=" + pKind;
}
</script>
<div id="top_gallery">
	<ul class="slider">
		<li><img src="../images/slide01.jpg" onclick="clickProduct(1,103)"></li>
		<li><img src="../images/slide02.jpg" onclick="clickProduct(3, null)"></li>
		<li><img src="../images/slide03.jpg" onclick="clickProduct(1, 103)"></li>
	</ul>
</div>

<% // 텝메뉴 
List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
String product_kindName = "";
String[] pNames = {"블렌딩 차", "홍차", "허브티", "꽃차", "전통차", "백차/발효차"};
int n = 0;
%>
<div class="tab-product">
	<h2 class="newTea">New Tea</h2>
	<%
	for(int i=0; i<pNames.length; i++)	{
	%>
	<input type="radio" name="tab-menu" id="tab<%=i%>" <%if(i==0)out.print("checked"); %>>
	<label for="tab<%=i%>"><%=pNames[i] %></label>
	<%}
	for(int i=0; i<pNames.length; i++) {
		productList.addAll(productPro.getKindProducts("10"+(i+1), 10));
	}
	for(int i=0; i<productList.size(); i++) {
		int product_id = productList.get(i).getProduct_id();
		String product_image = "../../image_tea/" +  productList.get(i).getProduct_image1();
		String product_title = productList.get(i).getProduct_title();
		String product_kind = productList.get(i).getProduct_kind();
		String product_category = productList.get(i).getProduct_category();
		int product_price = productList.get(i).getProduct_price();
		int discount_rate = productList.get(i).getDiscount_rate();
		int discount_price = product_price - (product_price*discount_rate/100);

		if(i%10 == 0) {
			out.print("<div class='tab product"+ ++n +"'>");
			out.print("<a href='shopAll.jsp?product_category=" + product_category + "&product_kind=" + product_kind + "'>전체보기+</a><br>");
		}
	%>
		<a href="productContent.jsp?product_kind=<%=product_kind%>&product_id=<%=product_id%>">
		<div class="article">
			<div class="product">
			<div class="cartInsert"><div onclick="location='cartInsert.jsp?product_id=<%=product_id %>"></div></div>
			<img src=<%=product_image %>>
			</div>
			<span class="title"><%=product_title %></span><br>
			<span class="product_price"><%=product_price %>원</span>
			<span class="discount_price"><%=discount_price %>원</span><br>
		</a>
		</div>
	<%if(i%10==9) out.print("</div>");}
 %>	
</div>
<div class="fruit_image">
	<img src="../images/issue_fruit.jpg">
	<div>
		<h3>상쾌한 허브티</h3>
		<p>피곤한 하루 상쾌한 허브티로 달래보세요.</p>
		<%
		productList = new ArrayList<ProductDataBean>();
		productList.addAll(productPro.getKindProducts("103", 3));
		for(int i=0; i<productList.size(); i++) {
			int product_id = productList.get(i).getProduct_id();
			String product_image = "../../image_tea/" +  productList.get(i).getProduct_image1();
			String product_title = productList.get(i).getProduct_title();
			String product_kind = productList.get(i).getProduct_kind();
			int product_price = productList.get(i).getProduct_price();
			int discount_rate = productList.get(i).getDiscount_rate();
			int discount_price = product_price - (product_price*discount_rate/100);
		%>
		<div class="article">
		<a href="productContent.jsp?product_kind=<%=product_kind%>&product_id=<%=product_id%>">
			<img src=<%=product_image %>><br>
			<span class="title"><%=product_title %></span><br>
		</a>
		</div>
		<%} %>
	</div>
</div>
<h2>New TeaWear</h2>
<div class="teaWear">
	<a href="shopAll.jsp?product_category=2">전체보기+</a><br>
	<div>
		<%
		productList = new ArrayList<ProductDataBean>();
		productList.addAll(productPro.getProducts("2", 5));
		for(int i=0; i<productList.size(); i++) {
			int product_id = productList.get(i).getProduct_id();
			String product_image = "../../image_tea/" +  productList.get(i).getProduct_image1();
			String product_title = productList.get(i).getProduct_title();
			String product_kind = productList.get(i).getProduct_kind();
			String product_category = productList.get(i).getProduct_category();
			int product_price = productList.get(i).getProduct_price();
			int discount_rate = productList.get(i).getDiscount_rate();
			int discount_price = product_price - (product_price*discount_rate/100);
		%>
		<div class="article">
		<a href="productContent.jsp?product_category=<%=product_category %>&product_kind=<%=product_kind%>&product_id=<%=product_id%>">
			<img src=<%=product_image %>><br>
			<span class="title"><%=product_title %></span><br>
			<span class="product_price"><%=product_price %>원</span>
			<span class="discount_price"><%=discount_price %>원</span><br>
		</a>
		</div>
		<%} %>
	</div>
</div>
<h2>New ETC</h2>
<div class="teaWear">
	<a href="shopAll.jsp?product_category=3">전체보기+</a><br>
	<div>
		<%
		productList = new ArrayList<ProductDataBean>();
		productList.addAll(productPro.getProducts("3", 5));
		for(int i=0; i<productList.size(); i++) {
			int product_id = productList.get(i).getProduct_id();
			String product_image = "../../image_tea/" +  productList.get(i).getProduct_image1();
			String product_title = productList.get(i).getProduct_title();
			String product_kind = productList.get(i).getProduct_kind();
			String product_category = productList.get(i).getProduct_category();
			int product_price = productList.get(i).getProduct_price();
			int discount_rate = productList.get(i).getDiscount_rate();
			int discount_price = product_price - (product_price*discount_rate/100);
		%>
		<div class="article">
		<a href="productContent.jsp?product_category=<%=product_category %>&product_kind=<%=product_kind%>&product_id=<%=product_id%>">
			<img src=<%=product_image %>><br>
			<span class="title"><%=product_title %></span><br>
			<span class="product_price"><%=product_price %>원</span>
			<span class="discount_price"><%=discount_price %>원</span><br>
		</a>
		</div>
		<%} %>
	</div>
</div>
</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>