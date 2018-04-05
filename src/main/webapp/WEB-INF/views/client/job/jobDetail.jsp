<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	function goRecruit() {
		with (document.search_form) {
			action = "reclogin";
			target="_self";
			submit();
		}
	}

	function goList() {
		with (document.search_form) {
			action = "jobNotice";
			target="_self";
			encoding = "application/x-www-form-urlencoded";
			submit();
		}
	}
</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=2&s=1" />

		<!-- 컨텐츠 영역 시작 -->
		<div class="contents_wrap lnb_open">
			<!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 컨텐츠 타이틀 -->
			<div class="page_title">
				<span class="title">채용공고</span> <span class="description">무림
					그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
				<ul class="location">
					<li><a href="">Home</a></li>
					<li><a href="">채용안내</a></li>
					<li class="currentpage"><a href="">인재상</a></li>
				</ul>
			</div>
			<!-- 컨텐츠 내용 -->
			<div class="contetns">
				<form method="get" name="search_form" id="search_form" action="jobNotice">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${pCommon.pageNo}"/>">
					<input type="hidden" name="searchType" value="<c:out value="${pCommon.searchType}"/>">
					<input type="hidden" name="idx" value="<c:out value="${pCommon.idx}"/>">
					<input type="hidden" name="SKEY_1" id="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
				</form>
				<table class="contents_table">
				  <colgroup>
				    <col style="width:150px;" />
				    <col style="width:;" />
				  </colgroup>
					<tbody>
						<tr>
							<td colspan="2" class="title">${rs.R_TITLE}</td>
						</tr>
						<tr>
							<th>상태</th>
							<td>${rs.JOB_STATUS_TXT}</td>
						</tr>
						<tr>
							<th>채용유형</th>
							<td>${rs.R_GUBUN_TXT}</td>
						</tr>
						<tr>
							<th>공고게시 기간</th>
							<td>${fn:substring(rs.R_SDATE, 0, 4)}년 ${fn:substring(rs.R_SDATE, 4, 6)}월 ${fn:substring(rs.R_SDATE, 6, 8)}일 ~ ${fn:substring(rs.R_EDATE, 0, 4)}년 ${fn:substring(rs.R_EDATE, 4, 6)}월 ${fn:substring(rs.R_EDATE, 6, 8)}일</td>
						</tr>
						<tr class="endrow"><!-- 공고 상세내용 바로 전 tr에 class="endrow"로 border-bottom 값을 진하게 함 -->
							<th>첨부파일</th>
							<td><c:if test="${fileView ne null}">${fileView}</c:if></td>
						</tr>
						<tr>
							<td class="recnoti_contents" colspan="2">
								<c:out value="${rs.R_CONTENT}" escapeXml="false" />
							</td>
						</tr>
					</tbody>
				</table>
			
				<div class="btn_wrap center">
					<c:if test="${rs.JOB_STATUS eq '2'}">
					<a class="btn_a color_a" title="입사지원서 작성" href="javascript:goRecruit();"><span>입사지원서 작성</span></a> <!-- 버튼의 경우 button 과 a 모두 사용가능 -->
					</c:if>
					<a class="btn_a color_b" title="목록" href="javascript:goList();"><span>목록</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>