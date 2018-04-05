<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
$(document).ready(function(){
	//editor load
	fn_smartEditorInit( "textarea_contents", true, false, true );
	$( ".calendar_input" ).datepicker({dateFormat: 'yy.mm.dd'});
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
		if (!valid_exist(title)) {
			alert('제목을 입력하세요');
			TITLE.focus();
			return;
		}
		if (!valid_exist(regName)) {
			alert('작성자명을 입력하세요');
			TITLE.focus();
			return;
		}
		
		if (!valid_exist(regDt)) { 
			alert ('작성일을 입력하세요');
			return;
		}

		if (!valid_existEditor(contentQ)) {
			alert('내용을 입력하세요');
			return;
		}
		
		
		if(!confirm(msg)) {
			return;
		}
		
		fn_save();
		
		/*
		if( fileExistCheck() ) {
			alert(1);
			fn_fileUpload( "document.frm", "fileinfo", "fn_save()", "N");
		} else {
			fn_save();
		}
		*/
	}
}

function fn_save() {
	with( document.frm ) {
		target = "_self";
		method = "post";
		encoding = "application/x-www-form-urlencoded";
		action = "/admin/faq/faqProcess";
		//submit();
	}
	var params = $("#frm").serialize();
	$.ajax({
		type: 'POST',
		url: "/admin/faq/faqProcess",
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
		action="/admin/faq/faq0001"
		encoding = "application/x-www-form-urlencoded";
		submit();
	}
}
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/adm_header.jsp?m=3&s=2"></c:import>
	
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">채용 문의 관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용 문의 관리</a>
						</li>
						<li class="currentpage">
							<a href="#">FAQ목록</a>
						</li>
					</ul>
				</div>
				<div class="contetns">	
					<form method="post" name="search_form" id="search_form" action="/admin/faq/faq0001">
						<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${vo.pageNo }"/>"> 
						<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>"> 
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>">
					</form>
					<form method="post" name="frm" id="frm">
						<input type="hidden" name="idx" value="<c:out value="${rs.IDX }"/>"> 
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>"> 
						<input type="hidden" name="fileinfo"> 
						<input type="hidden" name="delfileinfo">
	                    <div class="top_box">
	                        <p class="tit_blue">FAQ 
		                        <c:if test="${procType eq 'mod'}" >수정</c:if>
		                        <c:if test="${procType eq 'new'}" >등록</c:if>
	                        </p>
	                    </div>
	        			<div class="list2">
			                <table>
								<colgroup>
									<col style="width: 16%">
									<col style="width: 84%">
								</colgroup>
								<tbody>
									<tr>
										<th class="bg">제목</th>
										<td style="text-align: left">
											<input type="text" style="width: 680px;" question="질문 제목을 입력해 주세요" name="title" maxlength="100" value="<c:out value="${rs.TITLE }" />" /></td>
									</tr>
									<tr>
										<th class="bg">이름</th>
										<td style="text-align: left">
											<input type="text" style="width: 240px;" name="regName" maxlength="20" value="<c:out value="${rs.REG_NAME }" />" /></td>
									</tr>
									<tr>
										<th class="bg">작성일</th>
										<td style="text-align: left">
											
											<input type="text" class="calendar_input" style="width: 240px;" name="regDt" maxlength="50" value="<fmt:formatDate value="${rs.REG_DT }" pattern="yyyy.MM.dd" />" /></td>
									</tr>
									<tr>
										<th class="bg">게시여부</th>
										<td style="text-align: left">
											<input type="radio" value="1" name="delYn" id="del0" ${empty rs.DE_YN ? 'checked="checked"' : (rs.DE_YN eq true ? 'checked="checked"' : '')  }><label for="del0">사용</label>
											<input type="radio" value="0" name="delYn" id="del1"<c:if test="${rs.DEL_YN eq false }">checked="checked"</c:if>><label for="del1">미사용</label>
										</td>
									</tr>
	
									<tr>
										<th class="bg">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</th>
										<td>
											<textarea id="textarea_contents" name="contentQ" style="width: 680px; height: 300px;">${rs.CONTENT_Q }</textarea>
										</td>
									</tr>
									<!-- 
									<tr>
										<th class="bg" style="height: 30px;">첨부파일</th>
										<td style="padding: 0px 0 10px 10px; vertical-align: middle;">
											${fileUpload }</td>
									</tr>
									 -->
								</tbody>
							</table>
	                    </div>
					</form>        
        			<div class="dataBox_footer">
           				<a href="javascript:void(0);" onclick="javascript:go_savePage();" class="bt004"><span>저장</span></a>
						<a href="javascript:void(0);" onclick="javascript:go_listPage();" class="bt005"><span>취소</span></a>
         			</div>
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>