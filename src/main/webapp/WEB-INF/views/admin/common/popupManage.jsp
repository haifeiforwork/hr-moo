<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {
		alert("화면과 스크립트, java까지 만들어둠. 쿼리 만들면됨");
	});
	
	function goView(type,idx){
		var frm = document.search_form;	
		frm.procType.value = type;
		frm.idx.value = idx;
		frm.action = "/admin/common/popupManageForm";
		frm.submit();
	}
	
	function goDelete(idx){
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/deletePopup",
			data: {"idx" : idx },
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
	<c:import url="/inc/adm_header.jsp?m=5&s=8"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">팝업관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">시스템관리</a>
						</li>
						<li class="currentpage">
							<a href="#">팝업관리</a>
						</li>
					</ul>
				</div>
				
				
				
				<div class="contetns">	
					<form name="search_form" id="search_form" method="post" action="/admin/common/popupManage">
						<input type="hidden" name="idx"> 
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
						<input type="hidden" name="procType" value="">
					</form>
					
					<div class="table_header admin">
						<div class="total">
							총 <c:out value="${paginationInfo.totalRecordCount }" />건
						</div>
						<div class="btn_area">
							<a href="javascript:void(0);" onclick="javascript:goView('new');" class="btn_c color_a additem"><span>등록하기</span></a>
						</div>
					</div>
					
					<form name="frm" id="frm" method="post" >
						<input type="hidden" name="mCode">
					</form>
					
					<form id="iForm" name="iForm" method="post">
						<table class="list_table admin" id="majorTable">
							<caption>전공코드, 전공(학과)명, 전공구분, 전공계열, 수정,삭제로 구성.</caption>
							<colgroup>
								<col style="width:50px;" />
								<col style="width:50px;" />
								<col style="width:50px;" />
								<col style="width:50px;" />
								<col style="width:50px;" />
							</colgroup>
							<thead>
								<tr>
									<th>전공코드</th>
									<th>전공(학과)명</th>
									<th>전공구분</th>
									<th>전공계열</th>
									<th>수정 및 삭제</th>
								</tr>
							</thead>
						  <tbody>
						  	  <c:choose>
									<c:when test="${empty rsList}">
										<tr>
											<td colspan="5">검색된 학과가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${rsList }" varStatus="status">
											<tr>
										      <td><c:out value="${list.M_CODE }" /></td>
										      <td><c:out value="${list.M_NAME }" /></td>
										      <td>
										      	<c:choose>
										      		<c:when test="${list.M_GUBUN eq '1' }">인문계</c:when>
										      		<c:otherwise>자연계</c:otherwise>
										      	</c:choose>
										      </td>
										      <td><c:out value="${list.M_CATEGORY_NM }" /></td>
										      <td>
										      	<a href="javascript:void(0);" onclick="javascript:addMenuTemplate('${list.M_CODE }',this);" class="btn_c color_a"><span>수정</span></a>
											    <a href="javascript:void(0);" onclick="javascript:goDelete('${list.M_CODE }');" class="btn_c color_a"><span>삭제</span></a>
										      </td>
										    </tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
						  </tbody>
						</table>
					</form>
					
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />			
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>