<%@page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
String tname = request.getParameter("tname");

%>
<%@ include file="../space/ListCommon.jsp" %>
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
					<img src="../images/community/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				<%
				}
				%>
				</div>
				<div>
				<form method="get">  
				    <table class="table" width="90%"  >
					<input type="hidden" name="tname" value="<%= tname %>" />
			 		<tr>
				        <td align="center">
				            <select name="searchField"> 
				                <option value="title">제목</option> 
				                <option value="content" >내용</option>
				            </select>
				            <input type="text" name="searchWord" />
				            <input type="submit" value="검색하기" class="btn btn-warning"/>
				        </td>
		    		</tr>   
    				</table>
    			</form>
				    <table width="90%" class="table table-bordered table-hover">
				        <tr class="text-center" >
				            <th width="10%">번호</th>
				            <th width="50%">제목</th>
				            <th width="15%">작성자</th>
				            <th width="10%">조회수</th>
				            <th width="15%">작성일</th>
				        </tr>
				   <%
					//컬렉션에 입력된 데이터가 없는지 확인한다. 
					if (boardLists.isEmpty()) {
					%>
			     	   <tr>
				            <td colspan="5" align="center">
				                등록된 게시물이 없습니다^^*
				            </td>
				        </tr>
				    <%
						}
						else {
							/* 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에 저장된
							레코드의 갯수만큼 반복하여 출력한다. */
						    int virtualNum = 0;  
						  
							
						    int countNum = 0;  
						    for (BoardDTO dto : boardLists)
						    {
						    	/* 현재 출력할 게시물의 갯수에 따라 번호가 달라지게 되므로 
						    	totalCount를 사용하여 가상번호를 부여한다. */
						        //virtualNum = totalCount--;  
						    	
						    	virtualNum = totalCount - (((pageNum - 1) * pageSize) 
						    			+ countNum++);
						%>
						<tr align="center" >
					    <td><%= virtualNum %></td>
					    <td align="left"; > 
					       <p style= "width:230px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis"><a href="sub01view.jsp?tname=<%= tname %>&num=<%= dto.getNum() %>&virtualNum=<%=virtualNum%>"style="text-decoration:none;">
					        	<%= dto.getTitle() %></a></p> 
					    </td>
					    <td align="center"><%= dto.getId() %></td>
					    <td align="center"><%= dto.getVisitcount() %></td>
					    <td align="center"><%= dto.getPostdate() %></td>  
					</tr>
					
					<%
					    }
					}
					%>
					</table>
					 <table class="table" width="90%">
				        <tr align="right">
				        	<td align="center">
				        	<%= BoardPage.pagingImg(totalCount, pageSize,
				                       blockPage, pageNum, request.getRequestURI(),tname) %>
				        	</td>
				        	<%
				        		if (tname.equals("notice_board")){
									if (session.getAttribute("UserId")!=null && session.getAttribute("UserId").toString().equals("manager")){
							%>
						            <td><button type="button" onclick="location.href='sub01write.jsp?tname=<%=tname %>';" class="btn btn-danger" >글쓰기
						                </button></td>
					
				            <%
										}
						      		}
						      		else{
						
						     %>
				        		      <td style="widht:100%;"><button type="button" onclick="location.href='sub02write.jsp?tname=<%=tname %>';" class="btn btn-danger" >글쓰기
				        		          </button></td>
				                <%
				        		}
				                %>
			        </tr>
			    </table>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
