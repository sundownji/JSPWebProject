<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<%
//로그인이 되었다면 수정할 게시물의 일련번호를 파라미터로 받아오기
String num = request.getParameter("num");
String tname = request.getParameter("tname");
String virtualNum = request.getParameter("virtualNum");
//수정할 게시물을 얻어와서 DAO객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);
BoardDTO dto = new BoardDTO();
//기존 게시물의 내용을 읽어온다. <상세보기에서 생성한 selectview를 가져와>
if (tname.equals("free_board") || tname.equals("notice_board")){ 
		dto = dao.selectView(num,tname);
}
else if (tname.equals("photo_board") || tname.equals("info_board")){
		dto = dao.selectViewWithFile(num, tname);
}
//세션영역에 저장된 회원 아이디를 가져와서 문자열로 변환한다.
String sessionId = session.getAttribute("UserId").toString();
//로그인한 회원이 해당 게시물의 작성자인지 확인한다.
if (!sessionId.equals(dto.getId())){
	//작성자가 아닐 경우 자바스크립트의 alert 띄우고 history를 통해 back하고 return걸어줌
	//작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다.
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
/*url의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지 수정페이지로 진입할 수 있다. 
따라서 수정페이지 자체에서도 작성자 본인이 맞는지 확인하는 절차가 필요하다.*/
dao.close();
%>
<script type="text/javascript">
/* 글쓰기 페이지에서 제목과 내용이 입력되었는지 검증하는 JS코드 */
function validateForm(form) { 
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<% 
					if(tname.equals("notice_board")) { %>            
				  	 	<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
				   	 	<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				<% }
					else if(tname.equals("program_board")) {%>
				    <img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
			   		<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				<% }
					else if(tname.equals("free_board")) { %>
				   		<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
				   		<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				<% }
					else if(tname.equals("photo_board")) {%>
					    <img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
				   		<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				<% }
					else if(tname.equals("info_board")) {%>
				    <img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
			   		<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				<% 
				}
				%>
				<div>
<!-- 게시판 들어가는 부분 (시작) -->
<form name="writeFrm" method="post" action="EditProcess.jsp" enctype="multipart/form-data"
      onsubmit="return validateForm(this);">
    <input type="hidden" name="virtualNum" value="<%= virtualNum %>" />  
    <input type="hidden" name="num" value="<%=dto.getNum() %>" />
    <input type="hidden" name="tname" value="<%=tname %>" />
    <input type="hidden" name="prevOfile" value="<%=dto.getOfile() %>" />
	<input type="hidden" name="prevSfile" value="<%=dto.getSfile() %>" />
    <table class="table table-bordered" width="90%">
        <tr>
        	
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=dto.getTitle() %>" />
            </td>
        </tr>  
        <tr>
        <%
        if(tname.equals("info_board")|| tname.equals("photo_board")){
        %>
         	<td>첨부파일</td>
         	<td>
         		<input type="file" name="ofile" /> <%=dto.getOfile() %>
        	</td>
        <%
        }
        %>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"><%=dto.getContent() %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="btn btn-light">작성 완료</button>
                <button type="reset" class="btn btn-light">다시 입력</button>
                <button type="button" class="btn btn-light" onclick="location.href='sub01list.jsp?tname=<%=tname%>';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
<!-- 게시판 들어가는 부분 (끝) -->
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>