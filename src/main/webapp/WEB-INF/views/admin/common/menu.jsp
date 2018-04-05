<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
	<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">

	<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />	 
	<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.edatagrid.js"></script>
	
<script type="text/javascript">
var validator;
	$(function(){
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
			number:"{0}는 숫자만 입력할 수 있습니다.",
			minlength:"{0}자리 이상 입력하세요.",
			rangelength : '코드는 {0}자리의 숫자로 입력하세요.'
		});
		
		jQuery.validator.addMethod('selectcheck', function (value, element, params) {
	        return (value != '');
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));
		
		
		validator = $("#iForm").validate({ignore : ""});
			
		
	}
	
	// Submit전 객체의 name 속성을 MODEL list 형태로 변환
	$.fn.beforSubmitRenameForModelAttribute = function() {
		$('[name*=".catCode"]').each(function(index) { $(this).attr("name", "adminMenuList[" + index + "].catCode"); });
		$('[name*=".catNm"]').each(function(index) { $(this).attr("name", "adminMenuList[" + index + "].catNm"); });
		$('[name*=".carAuthYn"]').each(function(index) { $(this).attr("name", "adminMenuList[" + index + "].carAuthYn"); });
		$('[name*=".admAuthYn"]').each(function(index) { $(this).attr("name", "adminMenuList[" + index + "].admAuthYn"); });
		$('[name*=".displayYn"]').each(function(index) { $(this).attr("name", "adminMenuList[" + index + "].displayYn"); });
		
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="adminMenuList"]').each(function(index) { 
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}
	
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
		$('[name*=".catCode"]').each(function() {
			$(this).rules("add", {required : ['코드'], number : ['코드'],rangelength : [5,5]})
		});
		$('[name*=".catNm"]').each(function() {
			$(this).rules("add", {required : ['대메뉴명']})
		});
		
	}
	
	function goDelete(catCode){
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/deleteMenu",
			data: {"catCode" : catCode},
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.json.msg);
				if(data.json.result == "SUCCESS"){
					document.iForm.action = "/admin/common/menu";
					document.iForm.submit();
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	
	function deleteRow(obj){
		$(obj).closest('tr').remove();
	}
	
	function addMenuTemplate(){
		$('#tblMenuTemplate').tmpl().appendTo('#menuTable');
	}
	
	function addMenuTemplate2(code,obj){
		$.ajax({
			type: 'POST',
			url: "/admin/common/menuDetail",
			data: {"catCode" : code},
			async: false,
	        cache: false,
			success: function(data) {
				var idx = $(obj).closest('tr').index();
				
				//$('#tblMenuTemplate2').tmpl(data.json).appendTo();
				$(obj).closest('tr').hide();
				$("#menuTable tr").eq(idx+1).after($('#tblMenuTemplate2').tmpl(data.json))
				
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	
	function cancelRow(obj){
		$(obj).closest('tr').prev().show();
		$(obj).closest('tr').remove();
	}
	
	function saveRows(){
		$("#iForm").beforSubmitRenameForModelAttribute();
		$.beforeSubmitAddRule();

		if(!$("#iForm").valid()) {
			validator.focusInvalid();
			return false;
		}
		
		if(!confirm("저장하시겠습니까?")) {
			return;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/menuProcess",
			data: $("#iForm").serialize(),
			async: false,
	        cache: false,
	        beforeSend:function(){

	        },
			success: function(data) {
				$("#iForm").afterSubmitRenameForView();
				document.iForm.action = "/admin/common/menu";
				document.iForm.submit();
			},
			error : function() {
				$("#iForm").afterSubmitRenameForView();
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/adm_header.jsp?m=5&s=2"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">메뉴 관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">시스템관리</a>
						</li>
						<li class="currentpage">
							<a href="#">메뉴 관리</a>
						</li>
					</ul>
				</div>
				
				<div class="contetns">	
			
					
				
					<div class="table_header admin">
						<div class="btn_area">
							<a href="javascript:void(0);" onclick="javascript:addMenuTemplate();" class="btn_c color_a additem"><span>추가</span></a>
							<a href="javascript:void(0);" onclick="javascript:saveRows();" class="btn_c color_a additem"><span>일괄저장</span></a>
						</div>
					</div>
					<form name="iForm" id="iForm" method="post" >
						<table class="list_table admin" id="menuTable">
							<caption>대분류, 문항요소, 문항, 순서(신입), 순서(경력), 최소길이, 최대길이, 관리로 구성.</caption>
							<colgroup>
								<col style="width:80px;" />
								<col style="width:80px;" />
								<col style="width:80px;" />
								<col style="width:80px;" />
								<col style="width:80px;" />
								<col style="width:150px;" />
							</colgroup>
							<thead>
								<tr>
									<th>코드</th>
									<th>대메뉴명</th>
									<th>채용담당자</th>
									<th>시스템관리자</th>
									<th>사용여부</th>
									<th>수정</th>
								</tr>
							</thead>
						  <tbody>
						  	  <c:choose>
									<c:when test="${rsList.size() < 1 }">
										<tr>
											<td colspan="8">등록된 항목이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${rsList }" varStatus="status">
											<%--${list.IDX } --%>
											<tr>
										      <td>
										      	<c:out value="${list.CAT_CODE }" />
										      </td>
										      <td><c:out value="${list.CAT_CODE_NM }" /></td>
										      <td><c:out value="${list.CAR_AUTH_YN }" /></td>
										      <td><c:out value="${list.ADM_AUTH_YN }" /></td>
										      <td><c:out value="${list.DISPLAY_YN }" /></td>
										      <td>
										      	<a href="javascript:void(0);" onclick="javascript:addMenuTemplate2('${list.CAT_CODE }',this);" class="btn_c color_a"><span>수정</span></a>
										      	<a href="javascript:void(0);" onclick="javascript:goDelete('${list.CAT_CODE }');" class="btn_c color_a"><span>삭제</span></a>
										      </td>
										    </tr>
										</c:forEach>
										
									</c:otherwise>
								</c:choose>
						  </tbody>
						</table>
					</form>	
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>

<script id="tblMenuTemplate" type="text/x-jquery-tmpl">
<tr>
   <td>
		<input type="hidden" name="adminMenuList.editType" value="new">
		<input type="text" name="adminMenuList.catCode">
	</td>
   <td><input type="text" name="adminMenuList.catNm"></td>
   <td>
		<select name="adminMenuList.carAuthYn">
			<option value="Y">허용</option>
            <option value="N">불가</option>
        </select>
		
   </td>
   <td>
		<select name="adminMenuList.admAuthYn">
			<option value="Y">허용</option>
            <option value="N">불가</option>
        </select>
		
   </td>
   <td>
		<select name="adminMenuList.displayYn">
			<option value="Y">사용</option>
            <option value="N">미사용</option>
        </select>
		
   </td>
   <td>
   	<a href="javascript:void(0);" onclick="javascript:deleteRow(this);" class="btn_c color_a"><span>삭제</span></a>
  </td>
</tr>  
</script>
<script id="tblMenuTemplate2" type="text/x-jquery-tmpl">

<tr>
   <td>
		<input type="hidden" name="adminMenuList.editType" value="mod">
		<input type="text" name="adminMenuList.catCode" value="{{= CAT_CODE}}">
	</td>
   <td><input type="text" name="adminMenuList.catNm" value="{{= CAT_CODE_NM}}"></td>
   <td>
		<select name="adminMenuList.carAuthYn">
			<option value="Y" {{if CAR_AUTH_YN== 'Y'}}selected="selected" {{/if}}>허용</option>
            <option value="N" {{if CAR_AUTH_YN== 'N'}}selected="selected" {{/if}}>불가</option>
        </select>
		
   </td>
   <td>
		<select name="adminMenuList.admAuthYn">
			<option value="Y" {{if ADM_AUTH_YN== 'Y'}}selected="selected" {{/if}}>허용</option>
            <option value="N" {{if ADM_AUTH_YN== 'N'}}selected="selected" {{/if}}>불가</option>
        </select>
		
   </td>
   <td>
		<select name="adminMenuList.displayYn">
			<option value="Y" {{if DISPLAY_YN== 'Y'}}selected="selected" {{/if}}>사용</option>
            <option value="N" {{if DISPLAY_YN== 'N'}}selected="selected" {{/if}}>미사용</option>
        </select>
		
   </td>
   <td>
		<a href="javascript:void(0);" onclick="javascript:cancelRow(this);" class="btn_c color_a"><span>취소</span></a>
  </td>
</tr>  
</script>
</body>
</html>