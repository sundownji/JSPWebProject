<%@page import="common.JSFunction"%>
<%@page import="project3.MemberDTO"%>
<%@page import="project3.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>



<%
String member_name = request.getParameter("name");
String member_email = request.getParameter("email");
System.out.println(member_name+"="+member_email);
//출력결과가 웹브라우저에 나온다. 
out.println(member_name+"="+member_email);

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(member_name, member_email);
/* MemberDTO dto = dao.getMemberDTO(id, p ass);*/

dao.close();

if (dto.getId() != null) {
	String member_id = dto.getId();
	
	JSFunction.alertLocation("회원님의 아이디는:"+member_id, "../member/login.jsp", out);
}
else{
	request.setAttribute("LoginErrMsg", "입력하신 정보와 일치하는 아이디가 없습니다.");
	//그리고 로그인 페이지로 '포워드' forward한다. -> 왜냐면 정보가 없기 때문에~? 
	request.getRequestDispatcher("id_pw.jsp").forward(request, response);
}
%>

<%-- 
		<%
		if(session.getAttribute("id") != null){
		%>

	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디찾기<p>
				</div>
				
					<div class="container">
						<div class="found-success">
						<h4 class="id_class">회원님의 아이디는 </h4>
						<%=session.getAttribute("id")%>
						<h4>입니다.</h4>
							
						
						</div>
						<div class="found-login">
							<input type="button" id="btnLogin" value="로그인" onclick= 'login()'/>
						</div>
					</div>
				</div>
			</div>
			
			<%
		}
		else {
			%>
			<div class="container">
			<div class="found-fail">
				<h4>등록된 정보가 없습니다.</h4>
				</div>
			<div class="found-login">
				<input type="button" id="btnback" value="다시찾기" onClick="history.back()" />
				<a href="join01.jsp"></a><input type="button" id="btnjoin" value="회원가입"/>
			</div>
			</div>
			<%
			
			}
			%>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %> --%>
