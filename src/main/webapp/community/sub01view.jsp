<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="./viewCommon.jsp" %>

<script>
//삭제를 위해 폼값만 전달하는 녀석
//게시물 삭제를 위한 Javascript 함수
function deletePost() {
	//confirm() 함수는 대화창에서 '예'를 누를 때 true가 반환된다.
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
    	//폼태그에 돔 얻어와서 확인 후 전송
    	//<form> 태그의 name 속성을 통해 DOM을 얻어온다.
        var form = document.writeFrm;      
    	//전송방식과 전송할 경로를 지정한다.
        form.method = "post"; 
        form.action = "DeleteProcess.jsp";
        //submit() 함수를 통해 폼값을 전송한다.
        form.submit();         
        //<form> 태그 하위의 hidden박스에 설정된 일련번호를 전송한다.
    }
}
</script>


<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

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
					<img src="../images/community/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				<%
				}
				%>
					</div>			
				<div>
<!-- 게시판 들어가는 부분 (시작) -->
<form name="writeFrm">
	<input type="hidden" name="num" value="<%= num %>" />
	<input type="hidden" name="tname" value="<%= tname %>" />
	<input type="hidden" name="prevOfile" value="<%=dto.getOfile() %>" />
	<input type="hidden" name="prevSfile" value="<%=dto.getSfile() %>" />
	<!-- DTO에 저장된 내용을 getter를 통해 웹브라우저에 출력한다. -->  
    <table border="1" width="90%" class="table table-bordered">
        <tr>
            <td>번호</td>
            <td><%= virtualNum %></td>
            <td>작성자</td>
            <td><%= dto.getId() %></td>
        </tr>
        <tr>
            <td>작성일</td>
            <td><%= dto.getPostdate() %></td>
            <td>조회수</td>
            <td><%= dto.getVisitcount() %></td>
        </tr>
        <tr>
            <td>제목</td>
            <td colspan="3"><%= dto.getTitle() %></td>
        </tr>
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
            	<!-- 입력시 줄바꿈을 위한 엔터는 \r\n으로 입력되므로 
            	웹	브라우저에 출력시에는 <br>태그로 변경해야한다. -->
                <%= dto.getContent().replace("\r\n", "<br/>") %> 
                <% if (tname.equals("photo_board")) { %>
                <br />
                <img style="width:100%; height:200px; margin-top:30px; margin-bottom:30px;" id="prvimg" src="../Uploads/<%=dto.getSfile() %>" alt="" />
                <% }  %>
            </td> 
        </tr>
        <tr>
		<%
        if (tname.equals("photo_board") || tname.equals("info_board")){ 
        %>
            <td>첨부파일</td>
       		<td colspan="3">
        	<%= dto.getOfile() %>
        	<a href="./download.jsp?ofile=<%= dto.getOfile() %>&sfile=<%=  dto.getSfile() %>&idx=<%=dto.getNum() %>">다운로드</a>
        	</td>
        <%
        }
        %>
        </tr>
        <tr>
            <td colspan="4" align="center">
				<%
				/* 로그인이 된 상태에서 세션영역에 저장된 아이디가 해당 게시물을 
				작성한 아이디와 일치하면 수정, 삭제 버튼을 보이게 처리한다. 
				즉, 작성자 본인이 해당 게시물을 조회했을때만 수정, 삭제 버튼이 보이게
				처리한다. */
				if(session.getAttribute("UserId")!=null &&  
					dto.getId().equals(session.getAttribute("UserId").toString())){
				%>
				     <button type="button" class="btn btn-light"
				             onclick="location.href='sub01edit.jsp?tname=<%=tname%>&num=<%= dto.getNum() %>&virtualNum=<%= virtualNum %>;">
				         수정하기</button>
				         
				     <!-- 삭제하기 버튼을 누르면 JS의 함수를 호출한다. 해당 함수는 
				     submit()을 통해 폼값을 서버로 전송한다.  -->
				     <button type="button" class="btn btn-light" onclick="deletePost()">삭제하기</button> 
				<%
				}
				%>
                <button type="button" onclick="location.href='sub01.jsp?tname=<%=tname %>';" class="btn btn-light">
                    목록 보기
                </button>
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