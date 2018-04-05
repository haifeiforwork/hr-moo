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
	
	function setStatusChange(){
		if(isNullStr($("#status").val())){
			alert("지원상태를 선택하시기 바랍니다.");
			return flase;
		}
		
		$("input[name='rStatusCode']").val($("#status").val());
		var params = $("#iForm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/recruit/updateRec0300",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.json.msg);
				if(data.json.result == "success"){
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
					<span class="title">지원확인</span>
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
					<form name="search_form" id="search_form" method="post" action="/admin/recruit/rec0300">
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
					
						<div class="step_wrap">
							<ul class="step3">
								<li class="current"><a href="/admin/recruit/rec0300"><span>시스템 평가</span></a></li>
								<li><a href="/admin/recruit/rec0301"><span>자기소개서 배정</span></a></li>
								<li><a href="/admin/recruit/rec0302"><span>집계 및 확정</span></a></li>
							</ul>
						</div>
					
						<div class="table_header admin">
							<div class="total">
								총 <c:out value="${paginationInfo.totalRecordCount }" />명
									<select name="rows" onchange="setRows();">
										<option value="10"  <c:if test="${pCommon.rows eq '10'}">selected="selected"</c:if>>10명씩</option>
										<option value="20"  <c:if test="${pCommon.rows eq '20'}">selected="selected"</c:if>>20명씩</option>
										<option value="50"  <c:if test="${pCommon.rows eq '50'}">selected="selected"</c:if>>50명씩</option>
										<option value="100" <c:if test="${pCommon.rows eq '100'}">selected="selected"</c:if>>100명씩</option>
									</select>
							</div>
							<div class="btn_area">
								<!-- 
								<a href="#" class="btn_c color_a margin_0"><span>점수 계산</span></a>
								<a href="#" class="btn_c color_c marginright_10"><span>점수 초기화</span></a>
								 -->
								<select name="SKEY_2" id="SKEY_2">
							    	<c:forEach items="${code.code50 }" var="cd" varStatus="idx">
							    		<c:if test="${ cd.code eq '50002'
							    		            or cd.code eq '50003'
							    		            or cd.code eq '50010' }">
							    			<option value="${cd.code }" ${cd.code eq pCommon.SKEY_2 ? 'selected="selected"' : '' } >${cd.name }</option>
							    		</c:if>
									</c:forEach>
								</select>
								<a href="javascript:void(0);" onclick="setNotice();" class="btn_c color_a"><span>검색</span></a>
								
								<select id="status">
									<option value="">지원상태</option>
							    	<c:forEach items="${code.code50 }" var="cd" varStatus="idx">
							    		<c:if test="${ cd.code eq '50002'
							    		            or cd.code eq '50003'
							    		            or cd.code eq '50010' }">
							    			<option value="${cd.code }">${cd.name }</option>
							    		</c:if>
									</c:forEach>
								</select>
								<a href="javascript:void(0);" onclick="setStatusChange();" class="btn_c color_a"><span>상태 변경</span></a>
							</div>
						</div>
					</form>
					<form name="iForm" id="iForm" method="post">
						<input type="hidden" name="rStatusCode">
						<table class="list_table admin">
							<caption>서류전형 목록. 수험번호, 구분, 이름, 직군/직무, 점수(전공), 점수(성적), 점수(영어), 점수(제2외국어), 점수(자격), 서류1총점, 지원상태로 구성.</caption>
						  <colgroup>
						    <col style="width:40px;" />
						    <col style="width:100px;" />
						    <col style="width:80px;" />
						    <col style="width:80px;" />
						    <col style="width:;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:60px;" />
						    <col style="width:110px;" />
						  </colgroup>
						  <thead>
						    <tr>
						      <th><input type="checkbox"></th>
						      <th>수험번호</th>
						      <th>구분</th>
						      <th>이름</th>
						      <th>직군/직무</th>
						      <th>점수<br />(전공)</th>
						      <th>점수<br />(성적)</th>
						      <th>점수<br />(영어)</th>
						      <th>점수<br />(제2<br />외국어)</th>
						      <th>점수<br />(자격)</th>
						      <th>서류1<br />총점</th>
						      <th>지원상태</th>
						    </tr>
						  </thead>
						  <tbody>
					  		<c:choose>
								<c:when test="${rsList.size() < 1 or empty rsList }">
									<tr>
										<td colspan="13">등록된 지원자가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${rsList }" varStatus="status">
										 <tr>
									      <td>
									      	<input type="checkbox" name="volList[${status.index }].rApCode" value="<c:out value="${list.R_AP_CODE }" />">
									      	<input type="hidden" name="volList[${status.index }].rIdx" value="<c:out value="${list.R_IDX }" />">
									      </td>
									      <td><c:out value="${list.R_AP_CODE }" /></td>
									      <td><c:out value="${list.R_GUBUN_NM }" /></td>
									      <td><c:out value="${list.R_NAME }" /></td>
									      <td><c:out value="${list.R_JOB_KIND_CODE1_NM }" /> - <c:out value="${list.R_JOB_PART_CODE1_NM }" /></td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td>00</td>
									      <td><c:out value="${list.R_STATUS_CODE_NM }" /></td>
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