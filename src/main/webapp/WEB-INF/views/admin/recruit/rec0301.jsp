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
			url: "/admin/recruit/updateRec0301",
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
			return false;
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
	
	function changeSelectbox(obj){
		var $obj = $(obj);
		var $iobj = $("#evalItem");
		
		if(isNullStr($iobj.val())){
			alert("항목을 선택하세요.");
			$("#evalItem").focus();
			$(obj).val("").attr("selected","selected");
			return false;
		}
		
		var oVal = $obj.val();
		var itemVal = $iobj.val()
		
		$("#listTable tbody tr").each(function(index){
			var chk = $(this).find("td input[type='checkbox']").is(":checked");
			
			if(chk){
				if(itemVal == '1'){
					$(this).find(".combo1").val(oVal).attr("selected","selected");
				}else if(itemVal == '2'){
					$(this).find(".combo2").val(oVal).attr("selected","selected");
				}else if(itemVal == '3'){
					$(this).find(".combo3").val(oVal).attr("selected","selected");
				}else{
					$(this).find(".combo4").val(oVal).attr("selected","selected");
				}		
			}
			
		})
		
	}
	
	function toggleSelectbox(obj){
		var val = $(obj).val();
		var $eval = $("#evalmember");
		
		if(val == '1' || val == '2'){
			$eval.find("option[type='1']").show();
			$eval.find("option[type='2']").hide();
		}else if(val == '3' || val == '4'){
			$eval.find("option[type='2']").show();
			$eval.find("option[type='1']").hide();
		}else{
			$(obj).val("").attr("selected","selected");
			$eval.find("option[type='1']").hide();
			$eval.find("option[type='2']").hide();
		}
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
					<form name="search_form" id="search_form" method="post" action="/admin/recruit/rec0301">
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
								<li><a href="/admin/recruit/rec0300"><span>시스템 평가</span></a></li>
								<li class="current"><a href="/admin/recruit/rec0301"><span>자기소개서 배정</span></a></li>
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
								 <%--
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
								 --%>
								 <%--
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
								 --%>
								
								<select id="evalItem" onchange="toggleSelectbox(this);">
									<option value="">선택</option>
									<option value="1">인성1</option>
									<option value="2">인성2</option>
									<option value="3">직무1</option>
									<option value="4">직무2</option>
								</select>
								<select id="evalmember" onchange="changeSelectbox(this);">
									<option value="">평가위원</option>
									<c:forEach var="rs" items="${evalMem }" varStatus="idx">
										<option value="${rs.EMP_NO }" type="${rs.EV_ROLE_1 eq 'Y' ? '1' :'2' }" style="display: none;">${rs.USER_NAME }</option>
									</c:forEach>
								</select>
								<a href="javascript:void(0);" onclick="" class="btn_c color_a"><span>일괄 저장</span></a>
							</div>
						</div>
					</form>
					<form name="iForm" id="iForm" method="post">
						<input type="hidden" name="rStatusCode">
						<table class="list_table admin" id="listTable">
							<caption>서류전형 목록. 수험번호, 구분, 이름, 직군/직무, 지원상태, 서류1 총점, 배정(자소1), 배정(자소2), 배정(자소3), 배정(자소4), 관리로 구성.</caption>
						  <colgroup>
						    <col style="width:40px;" />
						    <col style="width:100px;" />
						    <col style="width:80px;" />
						    <col style="width:;" />
						    <col style="width:110px;" />
						    <col style="width:60px;" />
						    <col style="width:90px;" />
						    <col style="width:90px;" />
						    <col style="width:90px;" />
						    <col style="width:90px;" />
						    <col style="width:90px;" />
						  </colgroup>
						  <thead>
						  	 <tr>
						      <th><input type="checkbox"></th>
						      <th>수험번호</th>
						      <th>이름</th>
						      <th>직군/직무</th>
						      <th>지원상태</th>
						      <th>서류1<br />총점</th>
						      <th>배정<br />(인성1)</th>
						      <th>배정<br />(인성2)</th>
						      <th>배정<br />(직무3)</th>
						      <th>배정<br />(직무4)</th>
						      <th>관리</th>
						    </tr>
						  </thead>
						  <tbody>
					  		<c:choose>
								<c:when test="${rsList.size() < 1 or empty rsList }">
									<tr>
										<td colspan="10">등록된 지원자가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${rsList }" varStatus="status">
										 <tr>
									      <td>
									      	<input type="checkbox" id="test1" name="volList[${status.index }].rApCode" value="<c:out value="${list.R_AP_CODE }" />">
									      	<input type="hidden" name="volList[${status.index }].rIdx" value="<c:out value="${list.R_IDX }" />">
									      </td>
									      <td><c:out value="${list.R_AP_CODE }" /></td>
									      <td><c:out value="${list.R_NAME }" /></td>
									      <td><c:out value="${list.R_JOB_KIND_CODE1_NM }" /> - <c:out value="${list.R_JOB_PART_CODE1_NM }" /></td>
									      <td><c:out value="${list.R_STATUS_CODE_NM }" /></td>
									      <td>00</td>
									      <td>
											<select class="width_100 combo1">
												<option value="">평가위원</option>
												<c:forEach var="rs" items="${evalMem }" varStatus="idx">
													<c:if test="${rs.EV_ROLE_1 eq 'Y' }">
														<option value="${rs.EMP_NO }">${rs.USER_NAME }</option>
													</c:if>
												</c:forEach>
											</select>
										  </td>
									      <td>
											<select class="width_100 combo2">
												<option value="">평가위원</option>
												<c:forEach var="rs" items="${evalMem }" varStatus="idx">
													<c:if test="${rs.EV_ROLE_1 eq 'Y' }">
														<option value="${rs.EMP_NO }">${rs.USER_NAME }</option>
													</c:if>
												</c:forEach>
											</select>
										  </td>
									      <td>
											<select class="width_100 combo3">
												<option value="">평가위원</option>
												<c:forEach var="rs" items="${evalMem }" varStatus="idx">
													<c:if test="${rs.EV_ROLE_2 eq 'Y' }">
														<option value="${rs.EMP_NO }">${rs.USER_NAME }</option>
													</c:if>
												</c:forEach>
											</select>
										  </td>
									      <td>
											<select class="width_100 combo4">
												<option value="">평가위원</option>
												<c:forEach var="rs" items="${evalMem }" varStatus="idx">
													<c:if test="${rs.EV_ROLE_2 eq 'Y' }">
														<option value="${rs.EMP_NO }">${rs.USER_NAME }</option>
													</c:if>
												</c:forEach>
											</select>
										  </td>
  										  <td><a href="javascript:void(0);" onclick="" class="btn_c color_a"><span>수정</span></a></td>
									    </tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						  </tbody>
						</table>
					</form>
					
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
					
					<h3 class="margintop_30">평가위원 배정현황</h3>

					<table class="list_table admin">
						<caption>평가위원 목록. 성명, 직급, 부서, 사업장, 배정, 배정인원으로 구성.</caption>
					  <colgroup>
					    <col style="width:100px;" />
					    <col style="width:100px;" />
					    <col style="width:180px;" />
					    <col style="width:100px;" />
					    <col style="width:;" />
					    <col style="width:70px;" />
					  </colgroup>
					  <thead>
					    <tr>
					      <th>성명</th>
					      <th>직급</th>
					      <th>부서</th>
					      <th>사업장</th>
					      <th>배정</th>
					      <th>배정인원</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:if test="${empty evalMem }">
					  		<tr><td colspan="6">등록된 평가위원이 없습니다.</td></tr>
					  	</c:if>
					  	<c:if test="${!empty evalMem }">
					  		<c:forEach var="rs" items="${evalMem }" varStatus="idx">
								<tr>
							      <td><c:out value="${rs.USER_NAME }" /></td>
							      <td><c:out value="${rs.JOB_TITLE }" /></td>
							      <td><c:out value="${rs.GROUP_NAME }" /></td>
							      <td><c:out value="${rs.WORK_PLACE }" /></td>
							      <td>
							      	<c:choose>
							      		<c:when test="${rs.EV_ROLE_1 eq 'Y'}">자기소개서(인성)</c:when>
							      		<c:when test="${rs.EV_ROLE_2 eq 'Y'}">자기소개서(직무)</c:when>
							      	</c:choose>
							      </td>
							      <td></td>
							    </tr>
							</c:forEach>
					  	</c:if>
					  </tbody>
					</table>			
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>