<%@page import="common.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@page import="project3.MemberDTO"%>
<%@page import="project3.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
//로그인 폼에서 전송한 폼값을 받는다. 요청을 받은 페이지
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");
String save_check = request.getParameter("save_check");
//출력결과가 Console에 나온다.
System.out.println(userId+"="+userPwd);
//출력결과가 웹브라우저에 나온다.
out.println(userId+"="+userPwd);
//위 정보를 통해 DAO 객체를 생성하고 오라클에 연결한다.
MemberDAO dao = new MemberDAO();
/*폼값으로 받은 아이디, 패스워드를 인수로 전달하여 로그인 처리를 위한 회원인증을 진행한다.
일치하는 레코드가 있다면 DTO에 저장하여 반환한다.*/
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
//자원해제
dao.close();
//회원정보가 있는 경우 if문 실행
if(memberDTO.getId() != null){
	if(save_check != null && save_check.equals("Y")){
		/*로그인에 성공하고, 아이디 저장하기를 체크한 경우에는 하루동안
		유효한 쿠키를 생성한다. 쿠키값은 로그인한 아이디로 설정한다. (86400은 60 60 40 아닐까))*/
		CookieManager.makeCookie(response,"loginId", userId, 86400);
	}
	else{
		/*로그인에 성공하고, 아이디저장을 체크하지 않은 경우에는 쿠키를 삭제한다.*/
		CookieManager.deleteCookie(response,"loginId");
	}
	
	//로그인에 성공한 경우
	//session영역에 회원아이디와 이름을 저장한다.
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserName", memberDTO.getName());
	//그리고 로그인 페이지로 '이동'한다.
	//이동을 해도 페이지 세션이 유지되기 때문에 forward를 사용하지 않아도 됨
	//세션 - 한번 정보를 입력하면 브라우저를 종료할 때까지 가지고 있다는 특징 때문에
	//이동 가능한.
/* 	out.println("<script> alert('로그인 성공일 걸?'); </script>");
	System.out.println("로그인 성공해라.");
	response.sendRedirect("../main/main.jsp"); */
	JSFunction.alertLocation("로그인에 성공했습니다.", "../main/main.tj", out);
}
else{
	
	//로그인에 실패한 경우
	//request 영역에 에러메세지를 저장한다.
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	//그리고 로그인 페이지로 '포워드' forward한다. -> 왜냐면 정보가 없기 때문에~?
	request.getRequestDispatcher("login.jsp").forward(request, response);
}
%>



