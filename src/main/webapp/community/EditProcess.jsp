<%@page import="java.util.stream.Collectors"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="utils.FileUtil"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.List"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--수정 처리 전 로그인 되었는지 확인한다.  -->
<%@ include file = "../space/IsLoggedIn.jsp" %>

<%
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");
String tname =request.getParameter("tname");
String prevOfile = request.getParameter("prevOfile"); 
String prevSfile = request.getParameter("prevSfile");

//DTO 객체에 수정할 내용을 저장한다.
BoardDTO dto = new BoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);
String sDirectory = application.getRealPath("/Uploads/");
String ofile = "";



try{	
	List<Part> fileParts = 
			  request.getParts().stream().filter(part -> "ofile".equals(part.getName()) && part.getSize() > 0).collect(Collectors.toList());

			for (Part filePart : fileParts) {
			  String oFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			  String sFileName = FileUtil.renameFile(sDirectory, oFileName);
			  
			  String dst = sDirectory + sFileName;
				
			  try (BufferedInputStream fin = new BufferedInputStream(filePart.getInputStream());
			      BufferedOutputStream fout = new BufferedOutputStream(new FileOutputStream(dst))) 
			  { 	int data;
			      while (true) {
			          data = fin.read();             
			          if(data == -1)  break;             
			          fout.write(data);
			      }
			  } catch(IOException e) { 
				  e.printStackTrace();       
			  		System.out.println("Uploaded Filename: " + dst + ",  "+oFileName+ ",  "+sFileName);
				}
			  
			  dto.setOfile(oFileName);
			  dto.setSfile(sFileName);
			  System.out.println("나와라:"+tname);
			  System.out.println("나와라:"+dto.getOfile());
			  FileUtil.deleteFile(request, "/Uploads", prevSfile);
			}
}catch (Exception e) {
	e.printStackTrace();
}
	




//DB연결, update해주고 자원해제순서로 진행
//DAO객체 생성을 통해 오라클에 연결한다.
BoardDAO dao = new BoardDAO(application);
int affected = dao.updateEdit(dto,tname);

//자원을 해제한다.
dao.close();

//1 아니면 0밖에 없음
if (affected == 1){
	/* 수정이 완료되면 수정된 내용을 확인하기 위해 주로 내용보기 페이지로 이동한다. */
	response.sendRedirect("sub01view.jsp?tname="+tname+ "&num="+ dto.getNum());
}
else {
	/*수정에 실패하면 경고창을 띄우고 뒤로 이동한다.*/
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}

%>
