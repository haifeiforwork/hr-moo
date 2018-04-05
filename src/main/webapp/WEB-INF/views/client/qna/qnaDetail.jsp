<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
function go_listPage() {
	with (document.search_form) {
		target="_self";
		encoding = "application/x-www-form-urlencoded";
		submit();
	}
}
function goDel(){
	if(!confirm("삭제하시겠습니까?")) {
		return;
	}
	jQuery("#procType").val("del");
	var params = jQuery("#search_form").serialize();
	$.ajax({
		type: 'POST',
		url: "/client/qnaProcess",
		data: params,
		async: false,
        cache: false,
		success: function(data) {
			alert(data.json.msg);
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
function goWrite(){
	var frm = document.search_form;
	$("#procType").val("mod");
	frm.action = "/client/qnaWrite";
	frm.submit();
}
</script>
<title>무림 채용</title>
</head>
<body>
<div id="wrap">

<c:import url="/inc/header.jsp?m=4&s=2"></c:import>
			
			<!-- 컨텐츠 영역 시작 -->
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 컨텐츠 타이틀 -->
				<div class="page_title">
					<span class="title">채용문의</span>
					<span class="description">무림 그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용안내</a>
						</li>
						<li class="currentpage">
							<a href="">인재상</a>
						</li>
					</ul>
				</div>

    <!-- header -->
                <div class="contetns">
				<form method="get" name="search_form" id="search_form" action="qnaList">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${vo.pageNo }"/>">
					<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>">
					<input type="hidden" name="idx" value="<c:out value="${rs.IDX }"/>">
					<input type="hidden" name="procType" id="procType">
				</form>
	<div class="btn_wrap right">
		<a class="btn_a color_b" title="목록" href="#" onClick="javascript:go_listPage();"><span>목록</span></a>
		<a class="btn_a color_c" title="수정" href="#" onClick="javascript:goWrite();"><span>수정</span></a>
		<a class="btn_a color_c" title="수정" href="#" onClick="javascript:goDel();"><span>삭제</span></a>
		<a class="btn_a color_a" title="글쓰기" href="/client/qnaWrite"><span>글쓰기</span></a>
	</div>

	<table class="contents_table">
	  <colgroup>
	    <col style="width:150px;" />
	    <col style="width:;" />
	    <col style="width:150px;" />
	    <col style="width:;" />
	  </colgroup>
		<tbody>
			<tr>
				<th>제목</th>
				<td colspan="3"><c:out value="${rs.TITLE}"/></td>
			</tr>
			<tr>
				<th>문의자명</th>
				<td><c:out value="${rs.MOD_NAME}"/></td>
				<th>작성일</th>
				<td>2017.10.27</td>
			</tr>
			<tr>
				<th>일반전화</th>
				<td><c:out value="${rs.REG_PHONE}"/></td>
				<th>휴대전화</th>
				<td><c:out value="${rs.REG_PHONE}"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><c:out value="${rs.REG_EMAIL}"/></td>
				<th>첨부파일</th>
				<td>${fileView }</td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td class="recnoti_contents" colspan="3">
					${rs.CONTENT_Q}
				</td>
			</tr>
			<c:if test="${rs.STATUS eq '2' }">
			<tr>
				<td class="recnoti_recomment" colspan="4">
					<dl>
						<dt>채용 담당자 답변</dt>
						<dd>
							<span class="text">
								${rs.CONTENT_A }
							</span>
							<span class="name">
								<span class="label">답변 작성자</span>
								<span class="text">HR팀</span>
							</span>
						</dd>
					</dl>
				</td>
			</tr>
			</c:if>
			
			
		</tbody>
	</table>

	<div class="btn_wrap center">
		<a class="btn_a color_b" title="목록" href="#" onClick="javascript:go_listPage();"><span>목록</span></a>
		<a class="btn_a color_c" title="수정" href="#" onClick="javascript:goWrite();"><span>수정</span></a>
		<a class="btn_a color_c" title="수정" href="#" onClick="javascript:goDel();"><span>삭제</span></a>
		<a class="btn_a color_a" title="글쓰기" href="/client/qnaWrite"><span>글쓰기</span></a>
	</div>				
				
				
                   	
  				</div><!--검색박스 끝-->
</div>
<c:import url="/inc/footer.jsp"></c:import>
</div>
</body>
</html>