<%@page import="common.JSFunction"%>
<%@page import="project3.MemberDAO"%>
<%@page import="project3.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값 받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String tel = request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
String mobile = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
String email = request.getParameter("email_1")+"@"+request.getParameter("email_2");
String email_check = request.getParameter("email_check");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

//DTO객체에 저장하기
MemberDTO dto = new MemberDTO();
dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setEmail_check(email_check);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);

//전달하는게 많기 때문에 객체 하나 만들어서 다 전달하는게 편함

//DAO객체 생성 및 INSERT처리
//applcation해야 web.xml 정보를 가져올 수 있음
MemberDAO dao = new MemberDAO();
int result = dao.registinsert(dto);
if (result == 1){
	response.sendRedirect("login.jsp");
}
else{
	//실패하면 경고창(alert)을 띄우고, 뒤로(history) 이동한다.
	JSFunction.alertBack("회원가입에 실패하셨습니다.", out);
	
}
%>
