<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.faq.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주하는 질문</title>
<script>
	$(document).ready(function() {
		  $(".faq").hide();
		  $(".heading").click(function()
		  {
			$("#lt").toggleClass("lotate");
		    $(this).next(".faq").slideToggle(500);
		    $("i", this).toggleClass("fa-chevron-down fa-chevron-up");
		  });
		});


</script>
<style>
.heading{margin:0 auto; border-bottom:1px solid #eee; width: 700px; height: 40px; padding:10px;
 line-height: 40px; text-align: left; background: #fff; font-weight: bold; font-size: small}
.faq{margin:0 auto;width: 660px; padding:30px; background: #fafafa; line-height: 30px; text-align: justify; font-size: small}
.heading #lt{float:right; display:inline-block;text-align: right; transform: rotate(-90deg); }
.lotate{ transform: rotate(-180deg);}
</style>
</head>
<body>
<%
FaQDBBean faqPro = FaQDBBean.getInstance();
List<FaQDataBean> faqList = faqPro.getFaqList();

for(FaQDataBean faq : faqList){
%>
<div class="heading">
    <%=faq.getFaq_no()%>. <%=faq.getSubject() %> <span id="lt">&lt;</span>
</div>
<div class="faq">
    <%= faq.getContent() %>
</div>
<%} %>

</body>
</html>