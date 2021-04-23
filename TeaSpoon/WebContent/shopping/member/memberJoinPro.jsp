<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String address = address1 + " " +  address2;
String tel = request.getParameter("tel");
Timestamp now = new Timestamp(System.currentTimeMillis());

MemberDataBean member = new MemberDataBean();
member.setId(id);
member.setPasswd(passwd);
member.setName(name);
member.setAddress(address);
member.setTel(tel);
member.setReg_date(now);

int check = 0;
MemberDBBean memberPro = MemberDBBean.getInstance();
check = memberPro.insertMember(member);

// check가 -1일때 새로운 아이디, check가 1일때는 중복 아이디
if(check == -1) {
	out.print("<script>alert('회원가입에 성공하였습니다.'); location='memberLoginForm.jsp'</script>");	
} else if(check == 1) {
	out.print("<script>alert('중복 아이디입니다.\\n아이디를 다시 입력해 주세요.'); location='memberJoinForm.jsp';</script>");	
}
%>
</body>
</html>