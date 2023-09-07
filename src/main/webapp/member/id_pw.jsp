<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
 
<script>
function findIdForm(form) {
	//입력값이 공백인지 확인후 경고창, 포커스이동, 폼값전송 중단처리를 한다.
    if (!form.name.value) {
        alert("이름을 입력하세요.");
        form.name.focus();
        return false;
    }
    if (form.email.value == "") {
        alert("이메일을 입력하세요.");
        form.email.focus();
        return false;
    }
}

function findPwForm(fr){
	if (!fr.id.value) {
		alert("아이디를 입력하세요.");
		fr.id.focus();
		return false;
	}
	
	if (fr.name1.value==''){
		alert("이름을 입력하세요.");
		fr.name1.focus();
		return false;
	}
	
	if (fr.email1.value==''){
		alert("이메일을 입력하세요.");
		fr.email1.focus();
		return false;
	}
}
</script>

	<center>
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
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				
				<div class="idpw_box">
				<form method="post" name="id_find_Frm" onsubmit="return findIdForm(this);">
					<div class="id_box">
						<ul style="left:70px";>
							<li><input type="text" name="name" value="" class="login_input01" /></li>
							<li><input type="text" name="email" value="" class="login_input01" /></li>
						</ul>
						<a href="../member/idPwFindResult.jsp"><input type="image" src="../images/member/id_btn01.gif" class="id_btn" style="left:270px" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
				</form>
				</div>
				<form action="" method="post" name="pw_find_Frm" onsubmit="return findPwForm(this);">
					<div class="pw_box">
						<ul style="left:70px";>
							<li><input type="text" name="id" value="" class="login_input01" /></li>
							<li><input type="text" name="name1" value="" class="login_input01" /></li>
							<li><input type="text" name="email1" value="" class="login_input01" /></li>
						</ul>
						<a href="idPwFindResult.jsp"><input type="image" src="../images/member/id_btn01.gif" class="pw_btn" style="top:100px; left:270px" /></a>
					</div>
				</form>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
