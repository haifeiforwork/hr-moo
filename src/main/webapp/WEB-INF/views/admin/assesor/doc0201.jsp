<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
var currentYear = new Date().getFullYear();
var validator;

	$(document).ready(function() {

	});

	function goView(rIdx, rApCode){
		var frm = document.frm;	
		frm.rApCode.value = rApCode;
		frm.action = "/admin/assesor/doc0201Pop";
		frm.target = "popupView";
		
		
		var width=800, height=480;
		var left = (screen.availWidth - width)/2;
		var top = (screen.availHeight - height)/2;
		var options = "width=" + width;
		options += ",height=" + height;
		options += ",left=" + left;
		options += ",top=" + top;
	
		window.open("", "popupView", options);
		frm.submit();
		
	}
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
	}
	
	function setNotice(){
		if(isNullStr($("#SKEY_1").val())){
			alert("모집공고를 선택하시기 바랍니다.");
			return flase;
		}
		document.search_form.submit();
	}
	
	function setRows(){
		if(isNullStr($('input[name=idx]').val())) {
			alert("모집공고를 선택하시기 바랍니다.");
			return false;
		}
		
		document.search_form.submit();
	}
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/adm_header.jsp?m=2&s=3"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">자기소개서 평가</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용관리</a>
						</li>
						<li class="currentpage">
							<a href="#">지원확인</a>
						</li>
					</ul>
				</div>
				
				
				
				<div class="contetns">	
					<form name="search_form" id="search_form" method="post" action="/admin/assesor/doc0201">
						<input type="hidden" name="idx" value="${pCommon.SKEY_1 }"> 
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
						<h4>
							모집공고
							 <select name="SKEY_1" id="SKEY_1" onchange="setNotice();">
						    	<option value="">공고</option>
								<c:forEach var="rs" items="${notice}" varStatus="status">
									<option value="${rs.IDX}" ${pCommon.SKEY_1 eq rs.IDX ? 'selected="selected"':'' }>${rs.R_TITLE}</option>
								</c:forEach>
						  	</select>
						</h4>
					
						<div class="table_header admin">
							<div class="total">
								평가대상자 총 <c:out value="${paginationInfo.totalRecordCount }" />명
									<select name="rows" onchange="setRows();">
										<option value="10"  <c:if test="${pCommon.rows eq '10'}">selected="selected"</c:if>>10명씩</option>
										<option value="20"  <c:if test="${pCommon.rows eq '20'}">selected="selected"</c:if>>20명씩</option>
										<option value="50"  <c:if test="${pCommon.rows eq '50'}">selected="selected"</c:if>>50명씩</option>
										<option value="100" <c:if test="${pCommon.rows eq '100'}">selected="selected"</c:if>>100명씩</option>
									</select>
							</div>
							<div class="btn_area">
								
							</div>
						</div>
					</form>
					<form name="frm" id="frm" method="post" >
						<input type="hidden" name="rIdx" value="${pCommon.SKEY_1 }">
						<input type="hidden" name="rApCode">
					</form>
					<form name="iForm" id="iForm" method="post">
						<input type="hidden" name="rStatusCode">
						<table class="list_table admin">
							<caption>서류전형 목록. 수험번호, 구분, 이름, 직군/직무, 점수(전공), 점수(성적), 점수(영어), 점수(제2외국어), 점수(자격), 서류1총점, 지원상태로 구성.</caption>
						  <colgroup>
						    <col style="width:40px;" />
						    <col style="width:80px;" />
						    <col style="width:80px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						  </colgroup>
						  <thead>
						    <tr>
						      <th rowspan="2">수험번호</th>
						      <th rowspan="2">구분</th>
						      <th rowspan="2">이름</th>
						      <th rowspan="2">직군/직무</th>
						      <th colspan="4">조직적합도</th>
						      <th colspan="4">직무적합도</th>
						      <th rowspan="2">문장작성</th>
						      <th rowspan="2">총점</th>
						    </tr>
						     <tr>
						      <th>존중</th>
						      <th>책임감</th>
						      <th>끈기</th>
						      <th>소계</th>
						      
						      <th>직무이해</th>
						      <th>직무준비</th>
						      <th>경력</th>
						      <th>소계</th>
						    </tr>
						    
						    
						  </thead>
						  <tbody>
					  		<c:choose>
								<c:when test="${rsList.size() < 1 or empty rsList }">
									<tr>
										<td colspan="14">등록된 지원자가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${rsList }" varStatus="status">
										 <tr>
									      <td><c:out value="${list.R_AP_CODE }" /></td>
									      <td><a href="javascript:void(0);" onclick="goView('${list.R_IDX }','${list.R_AP_CODE }')"><c:out value="${list.R_GUBUN_NM }" /></a></td>
									      <td><c:out value="${list.R_NAME }" /></td>
									      <td><c:out value="${list.R_JOB_KIND_CODE1_NM }" /> - <c:out value="${list.R_JOB_PART_CODE1_NM }" /></td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
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