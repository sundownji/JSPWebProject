<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../space/IsLoggedIn.jsp" %>
<%@ include file="../include/global_head.jsp" %>

<%
String tname = request.getParameter("tname");

%>
<%@ include file="../space/ListCommon.jsp" %>  

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
	if (form.ofile.value == ""){
		alert("첨부파일은 필수 입력입니다.")
		return false;
		}	
   	

}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
				<%
				if (tname.equals("employee_board")){
				%>				
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				<%
				}
				else if (tname.equals("protector_board")){
				%>
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				<%
				}
				%>
				   		
				</div>
				<div>
<!-- 게시판 들어가는 부분 (시작) -->
<form name="writeFrm" method="post" action="WriteProcess.jsp" enctype="multipart/form-data"
      onsubmit="return validateForm(this);">
	<input type="hidden" name="tname" value="<%= tname %>" />
    <table class="table table-bordered" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" />
            </td>
        </tr>

        <tr>
         	<td>첨부파일</td>
         	<td>
         		<input type="file" name="ofile" value=""/>
        	</td>
        </tr>
        
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='./sub01.jsp?tname=<%=tname%>';">목록 보기</button>
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