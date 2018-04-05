<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
	}

	function toggleQuestion(obj){
		var $questionTd = $(obj).closest('td');
		
		if(!$questionTd.hasClass('ans_off')){
			$questionTd.addClass("ans_off");
			$questionTd.removeClass("ans_on");
		}else{
			$("td.ans_on").addClass("ans_off").removeClass("ans_on");
			$questionTd.addClass("ans_on").removeClass("ans_off");	
		}
	}
	
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=4&s=1" />

		<!-- 컨텐츠 영역 시작 -->
		<div class="contents_wrap lnb_open">
			<!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 컨텐츠 타이틀 -->
			<div class="page_title">
				<span class="title">채용문의</span> <span class="description">무림
					그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
				<ul class="location">
					<li><a href="">Home</a></li>
					<li><a href="">채용문의</a></li>
					<li class="currentpage"><a href="">FAQ</a></li>
				</ul>
			</div>
			<!-- 컨텐츠 내용 -->
			<div class="contetns">
				<div class="table_header">

					<form name="search_form" id="search_form" method="post" action="/client/faq">
						<input type="hidden" name="idx"> 
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">

						<div class="search">
							<select name="searchType">
								<option value="">전체</option>
								<option value="1" <c:if test="${pCommon.searchType eq '1'}"> selected</c:if>>제목</option>
								<option value="3" <c:if test="${pCommon.searchType eq '3'}"> selected</c:if>>내용</option>
							</select> 
							<input type="text" name="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>"> 
							<a class="search_btn" onclick="javascript:document.search_form.submit();" >검색</a>
						</div>
						<div class="total">
							총
							<c:out value="${paginationInfo.totalRecordCount }" />
							건
						</div>

					</form>
				</div>
				<table class="list_table faq">
					<colgroup>
				     <col />
				    </colgroup>
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
								      <td class="ans_off">
											<div class="question_q">
												<span class="label">Q</span>
												<span class="text"><a href="javascript:void(0);" onclick="toggleQuestion(this);"><c:out value="${list.TITLE }" /></a></span>
											</div>
											<div class="question_a" >
												<span class="label">A</span>
												<span class="text">
													<c:out value="${list.CONTENT_Q }" escapeXml="false" />
												</span> 
											</div>
										</td>
								    </tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<!-- 
				<div class="dataBox_footer">
					<a href="javascript:void(0);" onclick="javscript:goWrite();" class="bt004"><span>등록</span></a>
				</div>
				 -->
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>