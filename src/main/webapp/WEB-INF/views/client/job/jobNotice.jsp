<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function() {
		
		$(".search_btn").click(function() {
			$("#pageNo").val("1");
			$('#search_form').submit();
		});
		
	});
	
	function goView(idx) {
		var frm = document.search_form;
		frm.idx.value = idx;
		frm.action = "/client/job/jobDetail";
		frm.submit();
	}
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
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
				<div class="table_header">
					<form name="search_form" id="search_form" method="post" action="jobNotice" accept-charset="uft-8">
						<input type="hidden" name="idx">
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
						<div class="search">
						  <select name="searchType">
						    <option value="ALL" <c:if test="${pCommon.searchType eq 'ALL'}"> selected</c:if>>전체</option>
						    <c:if test="${not empty recGubunList}">
								<c:forEach var="code" items="${recGubunList}" varStatus="status">
									<option value="${code.code}" <c:if test="${pCommon.searchType eq code.code}">selected</c:if>>${code.name}</option>
								</c:forEach>
							</c:if>
						  </select>
						  <input type="text" name="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
						  <a class="search_btn" href="javascript:void(0);"><span>검색</span></a>
						</div>
					</form>
					<div class="total">
						총 ${paginationInfo.totalRecordCount}건
					</div>
				</div>
				<table class="list_table">
				  <colgroup>
				    <col style="width:120px;" />
				    <col style="width:;" />
				    <col style="width:200px;" />
				    <col style="width:120px;" />
				  </colgroup>
				  <thead>
				    <tr>
				      <td>유형</td>
				      <td>채용공고</td>
				      <td>모집기간</td>
				      <td>상태</td>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:choose>
						<c:when test="${topRsList.size() > 0}">
							<c:forEach var="top" items="${topRsList}" varStatus="status">
								<fmt:parseDate value="${top.R_SDATE}" var="startFmt" pattern="yyyyMMdd" />
								<fmt:parseDate value="${top.R_EDATE}" var="endFmt" pattern="yyyyMMdd" />
                                <tr>
                                	<c:if test="${top.R_GUBUN eq '40001'}"><c:set var="rGubunClass" value="type2" /></c:if>
                                	<c:if test="${top.R_GUBUN eq '40002'}"><c:set var="rGubunClass" value="type1" /></c:if>
                                	<c:if test="${top.R_GUBUN eq '40003'}"><c:set var="rGubunClass" value="type3" /></c:if>
							    	<td><span class="rec_cat ${rGubunClass}">${top.R_GUBUN_TXT}</span></td>
							    	<td class="noti_title"><a href="javascript:goView('${top.IDX}');">${top.R_TITLE}</a></td>
							    	<td><fmt:formatDate value="${startFmt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${endFmt}" pattern="yyyy.MM.dd"/></td>
							    	<td><span class="rec_type type${top.JOB_STATUS}">${top.JOB_STATUS_TXT}</span></td>
                            	</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				  	<c:choose>
						<c:when test="${rsList.size() < 1}">
                                <tr>
				                    <td colspan="4">검색된 채용공고가 없습니다.</td>
                                 </tr>							
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${rsList }" varStatus="status">
								<fmt:parseDate value="${list.R_SDATE}" var="startFmt" pattern="yyyyMMdd" />
								<fmt:parseDate value="${list.R_EDATE}" var="endFmt" pattern="yyyyMMdd" />
                                <tr>
                                	<c:if test="${list.R_GUBUN eq '40001'}"><c:set var="rGubunClass" value="type2" /></c:if>
                                	<c:if test="${list.R_GUBUN eq '40002'}"><c:set var="rGubunClass" value="type1" /></c:if>
                                	<c:if test="${list.R_GUBUN eq '40003'}"><c:set var="rGubunClass" value="type3" /></c:if>
							    	<td><span class="rec_cat ${rGubunClass}">${list.R_GUBUN_TXT}</span></td>
							    	<td class="noti_title"><a href="javascript:goView('${list.IDX}');">${list.R_TITLE}</a></td>
							    	<td><fmt:formatDate value="${startFmt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${endFmt}" pattern="yyyy.MM.dd"/></td>
							    	<td><span class="rec_type type${list.JOB_STATUS}">${list.JOB_STATUS_TXT}</span></td>
                            	</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				  </tbody>
				</table>
				
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
			</div>
		</div>
	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>