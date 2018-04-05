<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
var validator;
var isUpdFlag = false;
	$(document).ready(function() {
		formValidation();
	});
	
	/************************************************
	* form validation
	************************************************/
	function formValidation(){
		
		$.validator.setDefaults({
		    onkeyup:false,
		    onclick:false,
		    onfocusout:false,
		    showErrors:function(errorMap, errorList){
		        if(this.numberOfInvalids()) {
		            alert(errorList[0].message);
		        }
		    }
		});
		
		jQuery.extend(jQuery.validator.messages, {
			required:"{0}을(를) 입력해주세요.",
			number:"{0}는 숫자만 입력할 수 있습니다."
		});
		
		validator = $("#iForm").validate({
				ignore : "",
				rules: {
					mCode:     {required : ['전공코드']}
				  , mName:     {required : ['전공(학과명)']}
			    }
		});
	}
	
	function goView(){
		if(isUpdFlag){
			alert("수정 목록이 존재합니다.\n확인 후 등록하시기 바랍니다.");
			return false;
		}
		var frm = document.frm;	
		frm.action = "/admin/common/com0101Pop";
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
	
	function addMenuTemplate(code,obj){
		if(!isUpdFlag){
			$.ajax({
				type: 'POST',
				url: "/admin/common/com0101Detail",
				data: {"mCode" : code},
				async: false,
		        cache: false,
				success: function(data) {
					var idx = $(obj).closest('tr').index();
					$(obj).closest('tr').hide();
					$("#majorTable tr").eq(idx+1).after($('#tblMajorTemplate').tmpl(data.json))
					isUpdFlag = true;
				},
				error : function() {
					alert("알수 없는 에러가 발생했습니다.");
				},
				dataType: "json"
			}); 
		}else{
			alert("저장 또는 취소 후 이용하시기 바랍니다.");
			return false;
		}
		
	}
	
	function cancelRow(obj){
		$(obj).closest('tr').prev().show();
		$(obj).closest('tr').remove();
		isUpdFlag = false;
	}
	
	function goDelete(idx){
		if(isUpdFlag){
			alert("수정 목록이 존재합니다.\n확인 후 삭제하시기 바랍니다.");
			return false;
		}
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/deleteCom0101",
			data: {"mCode" : idx },
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
	
	function updateRow(){
		if(!$("#iForm").valid()) {
			validator.focusInvalid();
			return false;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/updateCom0101",
			data: $("#iForm").serialize(),
			async: false,
	        cache: false,
	        beforeSend:function(){

	        },
			success: function(data) {
				if(data.json.result == "success"){
					document.search_form.submit();	
				}else{
					alert(data.json.msg);
				}
				
			},
			error : function() {
				$("#iForm").afterSubmitRenameForView();
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
	<c:import url="/inc/adm_header.jsp?m=4&s=2"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">학과등록</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">공통관리</a>
						</li>
						<li class="currentpage">
							<a href="#">학과등록</a>
						</li>
					</ul>
				</div>
				
				
				
				<div class="contetns">	
			
					<div class="table_search">
						<div class="input_area">
							<form name="search_form" id="search_form" method="post" action="/admin/common/com0101">
								<input type="hidden" name="idx"> 
								<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
								
								<table>
									<caption>검색 조건 테이블</caption>
									<colgroup>
										<col width="80">
										<col width="80">
										<col width="80">
										<col width="80">
									</colgroup>
									<tbody>
										<tr>
											<th>
												학과검색
											</th>
											<td colspan="3">
												<select name="searchType">
													<option value="">전체</option>
													<option value="1" <c:if test="${pCommon.searchType eq '1'}"> selected</c:if>>전공코드</option>
													<option value="2" <c:if test="${pCommon.searchType eq '2'}"> selected</c:if>>전공명</option>
												</select> 
												<input type="text" name="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
											</td>
										</tr>
										<tr>
											<th>
												전공구분
											</th>
											<td>
												<select name="gubunType1">
													<option value="">전체</option>
													<option value="1" <c:if test="${pCommon.gubunType1 eq '1'}"> selected</c:if>>인문계</option>
													<option value="2" <c:if test="${pCommon.gubunType1 eq '2'}"> selected</c:if>>자연계</option>
												</select> 
											</td>
											<th>
												전공계열
											</th>
											<td>
												<select name="gubunType2">
													<option value="">전체</option>
													<c:forEach var="cd" items="${code.code15 }">
														<option value="${cd.code }" <c:if test="${pCommon.gubunType2 eq cd.code}"> selected</c:if>>${cd.name }</option>		
													</c:forEach>
												</select> 
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

<script id="tblMajorTemplate" type="text/x-jquery-tmpl">
<tr>
	<td>
		<input type="hidden" name="mCode" value="{{= M_CODE }}"  />
		{{= M_CODE }}
	</td>
	<td>
		<input type="text" class="width_90" name="mName" value="{{= M_NAME }}" />
	</td>
	<td>
		<select name="mGubun">
			<option value="1" {{if M_GUBUN== '1'}}selected="selected" {{/if}}>인문계</option>
			<option value="2" {{if M_GUBUN== '2'}}selected="selected" {{/if}}>자연계</option>
		</select> 
	</td>
	<td>
		<select name="mCategory">
			<c:forEach var="cd" items="${code.code15 }">
				<option value="${cd.code }"  {{if M_CATEGORY== ${cd.code }}}selected="selected" {{/if}}>${cd.name }</option>		
			</c:forEach>
		</select> 
	</td>
    <td>
	  <a href="javascript:void(0);" onclick="javascript:updateRow();" class="btn_c color_a"><span>저장</span></a>
	  <a href="javascript:void(0);" onclick="javascript:cancelRow(this);" class="btn_c color_a"><span>취소</span></a>
	</td>
</tr> 
</script>	

</body>
</html>