
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.List"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="utils.FileUtil"%>
<%@page import="common.JSFunction"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file = "./IsLoggedIn.jsp" %>  
<!-- 로그인 페이지에 오랫동안 머물러 세션이 삭제되는 경우가 있으므로
글쓰기 처리 페이지에서도 반드시 로그인을 확인해야한다.  -->    
 
<%
//클라이언트가 작성한 폼값을 받아온다. 
String title = request.getParameter("title");
String content = request.getParameter("content");
String tname = request.getParameter("tname");
System.out.println("나와."+tname);
String sDirectory = application.getRealPath("/Uploads/");
String ofile = request.getParameter("ofile"); 




//폼값을 DTO객체에 저장한다. 
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
/* 특히 아이디의 경우 로그인 후 작성페이지에 진입할 수 있으므로 
세션영역에 저장된 회원아이디를 가져와서 저장한다. */
dto.setId(session.getAttribute("UserId").toString());
//파일업로드용 프로세스
//String filePath = "C:/Users/TJ/02Workspaces/09JSPServlet/JSPWebProject/src/main/webapp/Uploads/";

//Retrieves <input type="file" name="ofile" multiple="true">
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
}

BoardDAO dao = new BoardDAO(application);

int iResult = 0;

if (tname.equals("free_board") || tname.equals("notice_board")){
	iResult = dao.insertWrite(dto,tname);
}
else if (tname.equals("photo_board") || tname.equals("info_board")){
	iResult = dao.insertWriteWithFile(dto,tname);
}


dao.close();

if (iResult == 1) {
	//글쓰기에 성공했다면 목록으로 이동한다. 
    response.sendRedirect("sub01list.jsp?tname="+tname);
} 
else {
	//실패했다면 경고창(alert)을 띄우고, 뒤로(history) 이동한다. 
    JSFunction.alertBack("글쓰기에 실패하였습니다.", out);

}
%>



