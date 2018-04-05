<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function() {
		$(".calendar_input").datepicker({
			dateFormat : 'yy.mm.dd'
		});
	});
	
	function goView(idx){
		var frm = document.search_form;
		frm.method = "post";
		if(!isNullStr(idx)){
			frm.idx.value = idx;	
		}
		frm.action = "/admin/faq/faq0002";
		frm.submit();
	}
	
	function goDelete(idx){
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		var frm = document.search_form;
		frm.method = "post";
		frm.procType.value = 'del';
		frm.idx.value = idx;
		
		$("#procType").val("del");
		var params = $("#search_form").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/faq/faqProcess",
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
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
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
			
					<div class="table_search">
						<div class="input_area">
							<form name="search_form" id="search_form" method="post" action="/admin/faq/faq0001">
								<input type="hidden" name="idx"> 
								<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
								<input type="hidden" name="procType">
								
							
								<table>
									<caption>검색 조건 테이블</caption>
									<tbody>
										<tr>
											<th>
												FAQ 검색
											</th>
											<td>
												<select name="searchType">
													<option value="">전체</option>
													<option value="1" <c:if test="${pCommon.searchType eq '1'}"> selected</c:if>>제목</option>
													<option value="2" <c:if test="${pCommon.searchType eq '2'}"> selected</c:if>>작성자명</option>
													<option value="3" <c:if test="${pCommon.searchType eq '3'}"> selected</c:if>>내용</option>
												</select> 
												<input type="text" name="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
						<div class="btn_area">
							<a class="search_btn" href="#" onclick="javascript:document.search_form.submit();" title="검색"><span>검색</span></a>
						</div>
					</div>
				
					<div class="table_header admin">
						<div class="total">
							총 <c:out value="${paginationInfo.totalRecordCount }" />건
						</div>
						<div class="btn_area">
							<a href="javascript:void(0);" onclick="javascript:goView();" class="btn_c color_a additem"><span>등록하기</span></a>
						</div>
					</div>
			
					<table class="list_table admin">
						<caption>FAQ 목록. No, 제목, 작성자, 작성일, 게시여부, 삭제로 구성.</caption>
					  <colgroup>
					    <col style="width:30px;" />
					    <col style="width:;" />
					    <col style="width:140px;" />
					    <col style="width:120px;" />
					    <col style="width:120px;" />
					    <col style="width:90px;" />
					    <col style="width:90px;" />
					  </colgroup>
					  <thead>
					    <tr>
					      <th>No</th>
					      <th>제목</th>
					      <th>작성자</th>
					      <th>작성일</th>
					      <th>게시여부</th>
					      <th>삭제</th>
					    </tr>
					  </thead>
					  <tbody>
							<c:choose>
								<c:when test="${rsList.size() < 1 }">
									<tr>
										<td colspan="6">검색된 문의사항이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${rsList }" varStatus="status">
										<tr>
											<td>${paginationInfo.totalRecordCount - list.ROW + 1}</td>
											<td class="left">
												<a href="javascript:void(0);" onclick="javascript:goView('${list.IDX}');"><c:out value="${list.TITLE }" /></a></td>
											<td width="150px"><c:out value="${list.REG_NAME }" /></td>
											<td><fmt:formatDate value="${list.REG_DT }" pattern="yyyy.MM.dd" /></td>
											<td>
												<c:out value="${list.DEL_YN eq true ? 'Y' : 'N' }" />
											</td>
											<td>
												<a href="javascript:void(0);" onclick="javascript:goDelete('${list.IDX}');">삭제</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />			
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>