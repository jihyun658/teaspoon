<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.manager.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세보기</title>
<link rel="stylesheet" type="text/css" href="etc/productContent.css"/>
<link rel="stylesheet" type="text/css" href="../etc/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="../etc/slick/slick-theme.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script> -->
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="../etc/slick/slick.min.js"></script>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>
	<section>
	<%
	int product_id = Integer.parseInt(request.getParameter("product_id"));

	ProductDBBean productPro = ProductDBBean.getInstance();
	ProductDataBean product = productPro.getProduct(product_id);


	String product_image1 = "../../image_tea/" + product.getProduct_image1();
	String product_image2 = "../../image_tea/" + product.getProduct_image2();
	String product_image3 = "../../image_tea/" + product.getProduct_image3();
	String product_image4 = "../../image_tea/" + product.getProduct_image4();
	int product_price = product.getProduct_price();
	int discount_rate = product.getDiscount_rate();
	int sale_price = product_price - (product_price*discount_rate/100);
	DecimalFormat df = new DecimalFormat("#,###,###");
	
	String product_kind = product.getProduct_kind();
	String c_name = productPro.getCategoryName(product.getProduct_category());
	String k_name = productPro.getKindName(product_kind);
	%>
	<div class="selectKind">
		<a href="shopMain.jsp"><img alt="" src="../etc/home.png"></a> &gt; 
		<a href="shopAll.jsp?product_category=all">전체상품 </a>&gt; 
		<a href="shopAll.jsp?product_category=<%=product.getProduct_category()%>"><%=c_name %></a>
		<%if (k_name != ""){%> &gt; 
		<a href="shopAll.jsp?product_category=<%=product.getProduct_category()%>&product_kind=<%=product_kind%>"><%=k_name %></a><%} %>
	</div>
		<h3><%=product.getProduct_title() %></h3>
	<div id="content">
			<script type="text/javascript">
			$(document).ready(function() {
				 $('.slider-for').slick({
				  slidesToShow: 1,
				  slidesToScroll: 1,
				  arrows: false,
				  fade: true,
				  asNavFor: '.slider-nav'
				});
				$('.slider-nav').slick({
				  slidesToShow: 3,
				  slidesToScroll: 1,
				  asNavFor: '.slider-for',
				  dots: false,
				  centerMode: true,
				  focusOnSelect: true
				});
			});
			</script>
		<div class="images">
			<div class="slider-for">
				<div><img src="<%=product_image1 %>"></div>
				<div><img src="<%=product_image2 %>"></div>
				<div><img src="<%=product_image3 %>"></div>
			</div>
			<div class="slider-nav">
				<div><img src="<%=product_image1 %>"></div>
				<div><img src="<%=product_image2 %>"></div>
				<div><img src="<%=product_image3 %>"></div>
			</div>
		</div>
		<div class="desc">
		<form action="cart/cartInsert.jsp" method="post">
			<input type="hidden" name="product_id" value="<%=product_id %>">
			<table>
				<tr>
					<th>판매가</th>
					<td><span class="price1"><%=df.format(product_price) %>원</span><span class="price2"><%=df.format(sale_price) %>원</span> (<span class="price3"><%=discount_rate %>%</span> 할인)</td>
				</tr>
				<tr>
					<th>용량</th>
				   <%if(product.getProduct_type() == null || product.getProduct_type() == "")
		                out.print("<td>" + product.getProduct_weight() + "개</td>");
		             else if(product.getProduct_type().equals("잎차") || product.getProduct_type().equals("파우더"))
		              	out.print("<td>" + product.getProduct_weight() + "g</td>");
		             else out.print("<td>" + product.getProduct_weight() + "개</td>");%>
				</tr>
				<tr>
					<th>타입</th>
					<td><%=product.getProduct_type() %></td>
				</tr>
				<tr>
					<th>원산지</th>
					<td><%=product.getProduct_origin() %></td>
				</tr>
				<tr>
					<th>원재료 및 함량</th>
					<td><span class="meterial"><%=product.getProduct_material() %></span></td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td><%=product.getProduct_brand() %></td>
				</tr>
				<tr>
					<th>수량</th>
					<td><input type="number" name="buy_count" value="1" min="1" max="<%=product.getProduct_count()%>"></td>
				</tr>
				<tr>
					<th colspan="2"><input type="submit" value="장바구니 담기" formaction="../cart/cartInsert.jsp">
					<input type="submit" value="바로 구매" formaction="../buy/buyForm.jsp"></th>
				</tr>
			</table>
		</form>
		</div> 	
		<div class="menu">
			<ul>
				<li id="contentMenu"><a>상품 상세정보</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#review">리뷰</a></li>
				<li><a href="#FAQ">FAQ</a></li>
			</ul>
		</div>
		<div class="content">
			<p><%=product.getProduct_content() %></p>
			<img src=<%=product_image4 %>>
		</div>
		<div class="menu">
			<ul>
				<li><a href="#content">상품 상세정보</a></li>
				<li id="delivery"><a href="#delivery">배송 안내</a></li>
				<li><a href="#review">리뷰</a></li>
				<li><a href="#FAQ">FAQ</a></li>
			</ul>
		</div>
		<div class="delivery">
			<p>&lt; 주문안내 &gt;</p>
			<ol>
				<li>제품의 특성상 개별포장 개봉 후 교환 환불 불가 하오니 신중한 구매 바랍니다.</li>
				<li>일부 상품의 경우 공급 업체의 사정에 따라 주문 후 품절될 수 있으며, 이러한 경우 개별연락을 드리고 있으니 양해 부탁 드립니다.</li>
				<li>제품의 색상은 모니터에 따라 실제와 약간 다를 수 있습니다.</li>
			</ol>
			<p>&lt; 배송안내 &gt;</p>
			<ol>
				<li>입금확인 후 1~3일 정도 상품 준비기간이 소요되며, 주문량이 많을 경우 준비기간이 조금 더 소요될 수 있습니다.</li>
				<li>주문 후 24시간 이내에 입금확인이 되지 않을 경우, 주문 취소가 되오니 유의해주세요.</li>
				<li>기본 배송비는 2,500원이며, 3만원 이상 구매 시 무료배송 입니다.</li>
				<li>도서 산간지역 추가 운임 3,000원이 발생합니다.</li>
			</ol>
		</div>

		<!-- 리뷰 -->
		<%@ include file="../review/reviewList.jsp" %>
		<!-- 자주하는질문 -->
		<div class="menu">
			<ul>
				<li><a href="#content">상품 상세정보</a></li>
				<li><a href="#delivery">배송 안내</a></li>
				<li><a href="#review">리뷰</a></li>
				<li id="FAQ"><a href="#FAQ">FAQ</a></li>
			</ul>
		</div>
		<%@ include file="../faq/faqList.jsp" %>
	</div>
	</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>