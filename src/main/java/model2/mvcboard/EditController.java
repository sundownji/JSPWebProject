package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;


//요청명에 대한 매핑
@WebServlet("/mvcboard/edit.do")
//수정페이지에서도 파일을 업로드할 수 있기 때문에 Mutipart 설정
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)

public class EditController extends HttpServlet {
	
	//수정페이지로 진입하면 기존의 내용을 가져와서 쓰기 폼에 세팅한다.
	//단순한 페이지 이동이므로 get방식 요청이다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//일련번호를 받는다.
		String idx = req.getParameter("idx");
		//DAO객체를 생성한 후 기존 게시물의 내용을 가져온다.
		MVCBoardDAO dao = new  MVCBoardDAO();
		MVCBoardDTO dto = dao.selectView(idx);
		//DTO객체를 request영역에 저장한 후 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
	}
	
	
	/* 수정할 내용을 입력한 후 전송된 폼값을 update 쿼리문으로 갱신한다.
	 	게시판은 post방식으로 전송되므로 doPost()를 오버라이딩한다. */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//파일 업로드
		//업로드할 디렉토리의 물리적 경로를 가져온다.
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		String originalFileName ="";
		try {
			//업로드가 정상적으로 완료되면 원본 파일명을 반환한다.
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		}
		catch (Exception e) {
			//파일업로드 시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동한다.
			//예외 발생의 이유를 확인하기 위해 printStackTrace() 메서드를 사용하는 것이 좋다.
			JSFunction.alertBack(resp, "파일 업로드 오류입니다.");
			return;
		}
		//2.파일 업로드 외 처리
		/* 수정을 위해 hidden박스에 저장된 내용도 함께 받아온다. 
		  게시물의 일련번호와 기존 등록된 파일명이 함께 전송된다. */
		String idx = req.getParameter("idx");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		
		String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		//비밀번호는 session에서 가져옴
		/* 패스워드 검증에 성공한 경우 세션영역에 젖아된 패스워드를 가져온다.
		  영역에 저장시 Object타입으로 자동형변환 되므로 기존의 타입으로
		  다운캐스팅 해야한다.
		 */
		HttpSession session = req.getSession();
		String pass = (String)session.getAttribute("pass");
		
		//DTO에 저장
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setIdx(idx);
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPass(pass);
		
		//원본 파일명과 저장된 파일 이름 설정
		if(originalFileName != "") {
			/* 
				수정페이지에서 새롭게 등록한 파일이 있다면 기존 내용을 수정해야 한다.
			 	파일명의 이름을 변경한 후 원본파일명과 저장된 파일명을 DTO에 저장한다.
			*/
	
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			//원본과 변경된 파일명을 DTO에 저장한다.(dto에 저장되야 db에 저장되니까)
			dto.setOfile(originalFileName); //원래 파일 이름
			dto.setSfile(savedFileName); //서버에 저장된 파일 이름
			
			//기존 파일 삭제
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		else {
			//기존 첨부파일이 없다면 기존 이름 유지
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		//DB에 수정 내용 반영
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.updatePost(dto);
		dao.close();
		
		//성공 or 실패
		if(result == 1 ) { //글쓰기 성공시 목록 페이지로 이동
			//세션영역에 저장된 패스워드를 삭제한다.
			session.removeAttribute("pass");
			resp.sendRedirect("../mvcboard/view.do?idx=" + idx);
		}
		else { //글쓰기 실패시 쓰기 페이지로 이동
			JSFunction.alertLocation(resp, "비밀번호 검증을 다시 진행해주세요.", "../mvcboard/view.do?idx=" + idx);
		}
	}

}
