<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {
		$(".calendar_input").datepicker({
			dateFormat : 'yy.mm.dd'
		});
	});
	function goWrite() {
		var frm = document.search_form;
		frm.action = "qnaWrite";
		frm.submit();
	}
	function goView(idx, lock_yn) {
		
		var frm = document.search_form;
		if(lock_yn=="Y") {
			frm.action = "/client/qnaPwd";	
		} else {
			frm.action = "/client/qnaDetail";
		}
		
		frm.idx.value = idx;
		frm.submit();
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
				<div class="table_header btn_in">
					<div class="btn_wrap right">
						<a class="btn_c color_a" href="javascript:void(0);" onclick="javascript:goWrite();" title="1:1 문의하기" ><span>1:1 문의하기</span></a>
					</div>
				</div>
				<div class="table_header">

					<form name="search_form" id="search_form" method="get" action="qnaList">
						<input type="hidden" name="idx"> 
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
						<input type="hidden" name="lockYn" id="lockYn" value="">

						<div class="search">
							<select name="searchType">
								<option value="">전체</option>
								<option value="1" <c:if test="${pCommon.searchType eq '1'}"> selected</c:if>>제목</option>
								<option value="2" <c:if test="${pCommon.searchType eq '2'}"> selected</c:if>>작성자명</option>
								<option value="3" <c:if test="${pCommon.searchType eq '3'}"> selected</c:if>>내용</option>
							</select> 
							<input type="text" name="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>"> 
							<a class="search_btn" onclick="javascript:document.search_form.submit();" >검색</a>
						</div>
<!-- 						<div class="btn_wrap right"> -->
<!-- 							<a class="btn_a color_a" title="등록" href="javascript:void(0);" onclick="javascript:goWrite();"><span>등록하기</span></a> -->
<!-- 						</div>			 -->

					</form>
					<div class="total">
						총
						<c:out value="${paginationInfo.totalRecordCount }" />
						건
					</div>
				</div>

				<table class="list_table">
					<colgroup>
						<col style="width: 60px;" />
						<col style="width: *;" />
						<col style="width: 120px;" />
						<col style="width: 120px;" />
						<col style="width: 120px;" />
					</colgroup>
					<thead>
						<tr>
							<td>번호</td>
							<td>제목</td>
							<td>글쓴이</td>
							<td>작성일</td>
							<td>상태</td>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${rsList.size() < 1 }">
								<tr>
									<td colspan="5">검색된 문의사항이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="list" items="${rsList }" varStatus="status">
									<tr>
										<td>${paginationInfo.totalRecordCount - list.ROW + 1}</td>
										<td class="noti_title">
										<c:if test="${list.LOCK_YN eq 'Y' }">
										<span class="secret">비밀글</span>
										</c:if>
											<a href="javascript:void(0);" onclick="javascript:goView('${list.IDX}', '${list.LOCK_YN}');"><c:out value="${list.TITLE }" /></a></td>
										<td width="150px"><c:out value="${list.REG_NAME }" /></td>
										<td>
											<fmt:formatDate value="${list.REG_DATE }" pattern="yyyy.MM.dd" /></td>
										<td>
										<span class="qna_type type${list.STATUS }">
										
										<c:choose>
										<c:when test="${list.STATUS eq '1' }">접수완료</c:when><c:otherwise>답변 완료</c:otherwise>
										</c:choose>
										</span></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
				


			</div>
			
			
		</div>
		<!-- 컨텐츠 영역 끝 -->



	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>