<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

 <body>
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
 			<form action="registinf.jsp" name="registform" method="post" onsubmit="return formValidate(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>

					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;<input type="image" src="../images/btn_idcheck.gif" onclick="id_check_person(this.form);" style="cursor:hand;" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>	
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
				
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" />
	<select name="last_email_check2" onChange="email_input(this.form);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="직접입력" >직접입력</option>
		<option value="gmail.com" >gmail.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>

	</select>
	 
						<label><input type="checkbox" name="open_email" value="Y">
						<span>이메일 수신동의</span></label></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zip" value=""  class="join_input" style="width:60px"; />&nbsp;
						<a href="javascript:;" title="새 창으로 열림" onclick="zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" a href="" />&nbsp;&nbsp;
				<input type="reset" class="reset_btn">&nbsp;&nbsp;
				<a href="../main/main.jsp"><img src="../images/btn02.gif" /></a>
				 </p>
				
			</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<style>
      .reset_btn{
        background: #666;
	    width: 91px;
	    height: 22px;
	    text-align: center;
	    border: #666;
	    border-radius: 4px;
	    font-weight: bold;
	    color: white;
      }
   </style>

	<%@ include file="../include/footer.jsp" %>
	</center>
	
<script type="text/javascript">

function formValidate(frm){
	if(frm.id.value==''){
		alert("아이디를 입력하세요.");
		frm.id.focus();
		return false;
	}
	
	for(var i=0 ; i<frm.id.value.length; i++){
        if(!((frm.id.value[i]>='a' && frm.id.value[i]<='z') ||
            (frm.id.value[i]>='A' && frm.id.value[i]<='Z') ||
            (frm.id.value[i]>='0' && frm.id.value[i]<='9'))){
            alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
            frm.id.value='';
            frm.id.focus();
            return false; 
        }
	}
	
	if(!(frm.id.value.length>=4 && frm.id.value.length<=12)){
		alert("아이디는 4~12자 사이만 가능합니다.");
		frm.id.value ='';
		frm.id.focus();
		return false;	
	}
  	if(frm.id.value[0].charCodeAt(0)>=48 &&
		frm.id.value.charCodeAt(0)<=57){
        alert('아이디는 숫자로 시작할 수 없습니다.');
        frm.id.value = '';
        frm.id.focus();
        return false;
    }
  

	if(frm.pass.value==''){
		alert("비밀번호를 입력하세요.");
		frm.pass.focus();
		return false;
	}
	
	if(!(frm.pass.value.length>=4 && frm.pass.value.length<=12)){
		alert("비밀번호는 4~12자 사이만 가능합니다.");
		frm.pass.value ='';
		frm.pass.focus();
		return false;	
	}
	
	
	if(frm.pass2.value==''){
		alert('비밀번호를 확인해주세요.');
		frm.pass2.focus();
		return false;
	}

	if(!(frm.pass.value==frm.pass2.value)){
		alert('비밀번호가 일치하지 않습니다.');
		frm.pass.value="";
		frm.pass2.value="";
		frm.pass.focus();
		return false;
	}
		
	if(frm.name.value==''){
		alert('이름을 입력하세요.')
		frm.name.focus();
		return false;
	}
	
	if(frm.tel1.value==''){
		alert('전화번호를 입력해주세요.');
		frm.tel1.focus();
		return false;
	}
	if(frm.tel2.value==''){
		alert('전화번호를 입력해주세요.');
		frm.tel2.focus();
		return false;
	}
	if(frm.tel3.value==''){
		alert('전화번호를 입력해주세요.');
		frm.tel3.focus();
		return false;
	}
	
	if(frm.mobile1.value==''){
		alert('핸드폰번호를 입력해주세요.');
		frm.mobile1.focus();
		return false;
	}
	
	if(frm.mobile2.value==''){
		alert('핸드폰번호를 입력해주세요.');
		frm.mobile2.focus();
		return false;
	}
	
	if(frm.mobile3.value==''){
		alert('핸드폰번호를 입력해주세요.');
		frm.mobile3.focus();
		return false;
	}
		
	if(frm.email_1.value==""){
		alert('이메일을 입력해주세요.')
		frm.email_1.focus();
		return false;
	}
}

	function id_check_person(fn){
		if(fn.id.value==""){
			alert("아이디를 입력하고 중복확인을 해주세요.")
			fn.id.focus();
		}
		else {
			fn.id.readOnly = true;
		}
	}

	function email_input(frm){
		var choiceDomain = frm.last_email_check2.value;
		if(choiceDomain==""){
			frm.email_1.value='';
			frm.email_2.value='';
			frm.email_1.focus();
		}
		else if(choiceDomain=='직접입력'){
			frm.email_2.value='';
			frm.email_2.readOnly = false;
			frm.email_2.focus();
		}
		else{
			frm.email_2.value= choiceDomain;
			frm.email_2.readOnly = true;
		}
	}	
 
		function zipFind(){    
		    new daum.Postcode({
		        oncomplete: function(data) {
		            console.log(data);
		            console.log(data.zonecode);
		            console.log(data.address);
		            
		            var frm = document.registform;
		            frm.zip.value = data.zonecode;
		            frm.addr1.value = data.address;
		            frm.addr2.focus();
		        }
		    }).open();
		    
		    
		}
		
		function id_check_person(fn){
		    if(fn.id.value==''){
		        alert("아이디를 입력후 중복확인 해주세요.");
		        fn.id.focus();
		    }
		    else{
		        //아이디 중복확인 창을 띄울때 입력한 아이디를 쿼리스트링으로 
		        //넘겨준다. 
		        window.open('joinOverlap.jsp?id='+fn.id.value, 
		            'idOver', 
		            'width=500,height=300');
		        //입력한 아이디를 수정할 수 없도록 속성을 추가한다. 
		        fn.id.readOnly = true;
		    }
		}
	


</script>
 </body>
</html>
