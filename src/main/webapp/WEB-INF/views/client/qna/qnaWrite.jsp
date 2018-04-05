<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
$(document).ready(function(){
	//editor load
	fn_smartEditorInit( "textarea_contents", true, false, true );
	
	$("#LOCK_YN").change(function(){
		if($("#LOCK_YN").is(":checked")){
	    	$("#REG_PW").removeAttr("disabled");
	    }else{
	    	$("#REG_PW").val('');
	    	$("#REG_PW").attr("disabled", "disabled");
	    }
	});

	
});

function go_savePage() {
	fn_smartEditorUpdateContentsField();
	with (document.frm)
	{
<c:if test="${procType eq 'mod'}">
		var msg="수정하겠습니까?";
</c:if>
<c:if test="${procType eq 'new'}">
		var msg="등록하겠습니까?";
</c:if>
		if (!valid_exist(TITLE)) {
			alert('제목을 입력하세요');
			TITLE.focus();
			return;
		}
		if (!valid_exist(REG_NAME)) {
			alert('작성자명을 입력하세요');
			TITLE.focus();
			return;
		}
		
		if (!valid_existEditor(CONTENT_Q)) {
			alert('내용을 입력하세요');
			return;
		}
		
		if($("#LOCK_YN").is(":checked")){
			if (!valid_exist(REG_PW)) {
				alert('비밀글로 등록할때는 비밀번호를 입력하셔야 합니다.');
				REG_PW.focus();
				return;
			}
		}
		<c:if test="${procType eq 'new'}">
		if($('input:checkbox[id="chk"]').is(":checked") != true) {
			alert("개인정보 처리방침에 동의하셔야 합니다.");
			return;
		}
		</c:if>
		
		if(!confirm(msg)) {
			return;
		}

		if( fileExistCheck() ) {
			fn_fileUpload( "document.frm", "fileinfo", "fn_save()", "N");
		} else {
			fn_save();
		}
	}
}
function fn_save() {
	with( document.frm ) {
		target = "_self";
		method = "post";
		encoding = "application/x-www-form-urlencoded";
		action = "/client/qnaProcess";
		//submit();
	}


	출처: http://openlife.tistory.com/381 [물고기 많은 바다]
	$('#frm [name="REG_PHONE"]').val($('#rTel01').val() + '-' + $('#rTel02').val() + '-' + $('#rTel03').val());
	$('#frm [name="REG_EMAIL"]').val($('#rEmail01').val() + '@' + $('#rEmail02').val());
	var params = jQuery("#frm").serialize();
	$.ajax({
		type: 'POST',
		url: "/client/qnaProcess",
		data: params,
		async: false,
        cache: false,
		success: function(data) {
			if(data.json.result == "SUCCESS"){
				document.search_form.submit();	
			}
		},
		error : function() {
			alert("알수 없는 에러가 발생했습니다.");
		},
		dataType: "json"
	}); 
}
function go_listPage() {
	with (document.search_form) {
		target="_self";
		encoding = "application/x-www-form-urlencoded";
		submit();
	}
}
</script>
<title>무림 HR</title>
</head>
<body>

<div id="wrap">
	<c:import url="/inc/header.jsp?m=4&s=2"></c:import>

		<!-- 컨텐츠 영역 시작 -->
		<div class="contents_wrap lnb_open">
			<!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 컨텐츠 타이틀 -->
			<div class="page_title">
				<span class="title">채용문의</span> <span class="description">무림
					그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
				<ul class="location">
					<li><a href="">Home</a></li>
					<li><a href="">채용안내</a></li>
					<li class="currentpage"><a href="">인재상</a></li>
				</ul>
			</div>
			<!-- 컨텐츠 내용 -->
			<div class="contetns">
				<form method="get" name="search_form" id="search_form"
					action="qnaList">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${vo.pageNo }"/>"> 
					<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>"> 
					<input type="hidden" name="procType" value="<c:out value="${procType }"/>">
				</form>
				<form method="post" name="frm" id="frm">
					<input type="hidden" name="IDX" value="<c:out value="${rs.IDX }"/>"> 
					<input type="hidden" name="procType" value="<c:out value="${procType }"/>"> 
					<input type="hidden" name="fileinfo"> 
					<input type="hidden" name="delfileinfo">
					<input type="hidden" name="REG_PHONE">
					<input type="hidden" name="REG_HP">
					<input type="hidden" name="REG_EMAIL">

					<h2>채용문의<c:if test="${procType eq 'mod'}"> 수정</c:if><c:if test="${procType eq 'new'}">등록</c:if>
					</h2>
					
						<table class="jobapp_table">
							<colgroup>
								<col style="width:150px;">
								<col style="width:;">
							</colgroup>
							<tbody>
								<tr>
									<th >제목</th>
									<td style="text-align: left">
										<input type="text" class="width_80" placeholder="질문 제목을 입력해 주세요" name="TITLE" maxlength="100" value="<c:out value="${rs.TITLE }" />" />
										<span class="marginleft_10 vert_middle">
											<input type="checkbox" id="LOCK_YN" name="LOCK_YN" value="Y">
											<label for="chk" class="checklabel">비밀글</label>
										</span>
										</td>
								</tr>
								<tr>
									<th >작성자명</th>
									<td style="text-align: left">
										<input type="text" style="width: 240px;" name="REG_NAME" maxlength="20" value="<c:out value="${rs.REG_NAME }" />" /></td>
								</tr>
								<tr>
									<th >E-mail</th>
									<td style="text-align: left">
									<c:set var="emails" value="${fn:split(rs.REG_EMAIL, '@')}" />
									<input type="text" name="rEmail01" id="rEmail01" value="${emails[0]}" />
									@
									<input type="text" name="rEmail02" id="rEmail02" value="${emails[1]}" />
									<select onchange="recruitForm.rEmail02.value = this.value;">
								    	<option value>선택하세요</option>
										<option value="naver.com">naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="chol.com">chol.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="empal.com">empal.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="hanafos.com">hanafos.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="hanmir.com">hanmir.com</option>
										<option value="hitel.net">hitel.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="korea.com">korea.com</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="netian.com">netian.com</option>
										<option value="paran.com">paran.com</option>
										<option value="yahoo.com">yahoo.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value>직접입력</option>
								  	</select>
								</tr>
								<tr>
									<th >연락처</th>
									<td style="text-align: left">
									<c:set var="tels" value="${fn:split(rs.REG_PHONE, '-')}" />
									<input type="text" name="rTel01" id="rTel01" class="width_10" value="${tels[0]}" maxlength="4"/>
									-
									<input type="text" name="rTel02" id="rTel02" class="width_10" value="${tels[1]}" maxlength="4"/>
									-
									<input type="text" name="rTel03" id="rTel03" class="width_10" value="${tels[2]}" maxlength="4" />
								</tr>
<!-- 								<tr> -->
<!-- 									<th >무선번호</th> -->
<!-- 									<td style="text-align: left"> -->
<%-- 									<c:set var="cells" value="${fn:split(rs.REG_HP, '-')}" /> --%>
<!-- 									<select name="rHp01" id="rHp01"> -->
<!-- 										<option value>선택</option> -->
<%-- 										<option value="010" <c:if test="${cells[0] eq '010'}">selected</c:if>>010</option> --%>
<%-- 										<option value="011" <c:if test="${cells[0] eq '011'}">selected</c:if>>011</option> --%>
<%-- 										<option value="016" <c:if test="${cells[0] eq '016'}">selected</c:if>>016</option> --%>
<%-- 										<option value="017" <c:if test="${cells[0] eq '017'}">selected</c:if>>017</option> --%>
<%-- 										<option value="018" <c:if test="${cells[0] eq '018'}">selected</c:if>>018</option> --%>
<%-- 										<option value="019" <c:if test="${cells[0] eq '019'}">selected</c:if>>019</option> --%>
<!-- 									</select> -->
<!-- 									- -->
<%-- 									<input type="text" name="rHp02" id="rHp02" value="${cells[1]}" maxlength="4"/> --%>
<!-- 									- -->
<%-- 									<input type="text" name="rHp03" id="rHp03" value="${cells[2]}" maxlength="4"/> --%>
<!-- 								</tr> -->
								

								<tr>
									<th >문의사항</th>
									<td>
										<textarea id="textarea_contents" name="CONTENT_Q" style="width: 680px; height: 300px;">${rs.CONTENT_Q }</textarea>
									</td>
								</tr>
								<c:if test="${procType eq 'new'}">
									<tr>
										<th >비밀번호</th>
										<td style="text-align: left">
											<input type="password" id="REG_PW" name="REG_PW" maxlength="10" value="" disabled />
											<span class="disc marginleft_10">* 수정 또는 삭제시 반드시 필요합니다. (6~12자리 숫자 또는 문자)</span>
										</td>
									</tr>
								</c:if>
								<tr>
									<th  style="height: 30px;">첨부파일</th>
									<td style="padding: 0px 0 10px 10px; vertical-align: middle;">
										${fileUpload }</td>
								</tr>


							</tbody>
						</table>
					
				</form>
				<c:if test="${procType eq 'new'}">
				<div class="login_privacy table_bottom">
					<h1>개인정보처리방침</h1>
					<div class="text">
						수집하는 개인정보 항목당사는 회원가입, 상단, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
수집항목 : 이름, 비밀번호, 휴대전화번호, 이메일, 회사명, 부서, 주소, 전화번호, 제목, 내용, 행사 참가 정보(생년월일, 성별 등)<br>
개인정보수집방법 : 행사 참가 신청, 배송 요청 개인정보의 수집 및 이용목적당사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br>
샘플북 배송, 간행물 배송, 행사 참가 신청 개인정보의 보유 및 이용기간원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br> 
					</div>
					<div class="agreement">
						<input type="checkbox" id="chk">
						<label for="chk" class="checklabel">개인정보처리방침에 동의합니다.</label>
					</div>
				</div>
				</c:if>
				
				<div class="btn_wrap center">
					<a class="btn_a color_a" title="확인" href="javascript:void(0);" onclick="javascript:go_savePage();"><span>확인</span></a>
					<a class="btn_a color_b" title="취소" href="javascript:void(0);" onclick="javascript:go_listPage();"><span>취소</span></a>
				</div>				
				
			</div>
		</div>
	
	
	<c:import url="/inc/footer.jsp"></c:import>
</div>
</body>
</html>