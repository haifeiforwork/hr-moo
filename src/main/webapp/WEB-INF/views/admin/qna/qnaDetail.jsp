<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
function go_listPage() {
	with (document.search_form) {
		target="_self";
		encoding = "application/x-www-form-urlencoded";
		submit();
	}
}
function goAnswer(){
	if(!confirm("답변을 등록하시겠습니까?")) {
		return;
	}
	jQuery("#procTypeT").val("reply");
	var params = jQuery("#frm").serialize();
	$.ajax({
		type: 'POST',
		url: "/admin/qnaProcess",
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
</script>
<title>무림 채용</title>
</head>
<body>
<div id="wrap">
<c:import url="/inc/adm_header.jsp?m=3&s=1"></c:import>
			<!-- 왼쪽 메뉴 시작 -->
		<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 페이지 타이틀 영역-->
			<div class="page_title">
				<span class="title">채용문의 관리</span>
				<ul class="location">
					<li>
						<a href="">Home</a>
					</li>
					<li>
						<a href="">채용문의 관리</a>
					</li>
					<li class="currentpage">
						<a href="#">채용문의</a>
					</li>
				</ul>
			</div>
				
				
				
				<div class="contetns">	


				<form method="get" name="search_form" id="search_form" action="qnaList">
					<input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo }">
					<input type="hidden" name="searchType" value="${vo.searchType }">
					<input type="hidden" name="idx" value="${rs.idx }">
					<input type="hidden" name="procType" id="procType">
				</form>
				<form method="post" name="frm" id="frm">
					<input type="hidden" name="IDX" value="${rs.IDX }">
					<input type="hidden" name="procType" id="procTypeT">
					
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
					${rs.CONTENT_Q}"
				</td>
			</tr>
			<tr>
				<th>답변등록</th>
				<td class="recnoti_contents" colspan="3">
					<textarea name="CONTENT_A" style="width:620px; height:120px;">${rs.CONTENT_A}"</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	 <div class="btn_wrap center">
	 <c:choose>
	 <c:when test="${rs.STATUS eq '1' }">
	 <a href="javascript:void(0);" onclick="javascript:goAnswer();" class="btn_a color_a" title="답변 등록" href=""><span>답변 등록</span></a>
	 </c:when>
	 <c:when test="${rs.STATUS eq '2' }">
	 <a href="javascript:void(0);" onclick="javascript:goAnswer();" class="btn_a color_a" title="답변 수정" href=""><span>답변 수정</span></a>
	 </c:when>
	 </c:choose>
	 	<a href="javascript:void(0);" onclick="javascript:go_listPage();" class="btn_a color_b" title="취소" href=""><span>취소</span></a>
	</div>

         			</form>
 			
 			
 			
 			</div><!-- 컨텐츠 영역 끝 -->
		</div>
	</div>		
<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>