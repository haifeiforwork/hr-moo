<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp"%>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
var validator;

	$(document).ready(function() {
		formValidation()
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
		
		validator = $("#iForm").validate({ignore : ""});
	}
	
	// Submit전 객체의 name 속성을 MODEL list 형태로 변환
	$.fn.beforSubmitRenameForModelAttribute = function() {
		$('[name*=".mCode"]').each(function(index) { $(this).attr("name", "majorList[" + index + "].mCode"); });
		$('[name*=".mName"]').each(function(index) { $(this).attr("name", "majorList[" + index + "].mName"); });
		$('[name*=".mGubun"]').each(function(index) { $(this).attr("name", "majorList[" + index + "].mGubun"); });
		$('[name*=".mCategory"]').each(function(index) { $(this).attr("name", "majorList[" + index + "].mCategory"); });
		
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="majorList"]').each(function(index) { 
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}
	
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
		$('[name*=".mCode"]').each(function() {
			$(this).rules("add", {required : ['전공코드']})
		});
		$('[name*=".mName"]').each(function() {
			$(this).rules("add", {required : ['전공(학과)명']})
		});
		
	}
	
	function goSave(){
		$("#iForm").beforSubmitRenameForModelAttribute();
		$.beforeSubmitAddRule();
		

		if(!$("#iForm").valid()) {
			validator.focusInvalid();
			return false;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/insertCom0101Pop",
			data: $("#iForm").serialize(),
			async: false,
	        cache: false,
	        beforeSend:function(){

	        },
			success: function(data) {
				if(data.json.result == "success"){
					alert(data.json.msg);
					opener.parent.location.reload();
            		window.close();
				}else{
					$("#iForm").afterSubmitRenameForView();
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
	function goDelete(obj){
		$(obj).closest('tr').remove();
	}
	function addMenuTemplate(){
		$('#tblMajorTemplate').tmpl().appendTo('#majorTable');
	}
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">학과등록</div>
			<div class="button_area">
				<a href="" title="닫기" class="close_btn">닫기</a>
			</div>
		</div>
		<div class="popup_contents">

			<div class="table_header admin">
				<div class="btn_area">
					<a href="javascript:void(0);" onclick="addMenuTemplate();" class="btn_c color_a additem"><span>추가</span></a>
					<a href="javascript:void(0);" onclick="goSave();" class="btn_c color_a additem"><span>저장하기</span></a>
				</div>
			</div>
			
			<form id="iForm" name="iForm" method="post">
				<table class="contents_table admin marginbottom_20" id="majorTable">
					<caption>지원서 지원정보 목록. 채용공고, 수험번호, 지원상태로 구성.</caption>
					<colgroup>
						<col style="width: 120px;" />
						<col style="width: 120px" />
						<col style="width: 120px;" />
						<col style="width: 120px" />
						<col style="width: 120px" />
					</colgroup>
					<thead>
						<tr>
							<th>전공코드</th>
							<th>전공(학과)명</th>
							<th>전공구분</th>
							<th>전공계열</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="width_90" name="majorList.mCode"  />
							</td>
							<td>
								<input type="text" class="width_90" name="majorList.mName"  />
							</td>
							<td>
								<select name="majorList.mGubun">
									<option value="1" >인문계</option>
									<option value="2" >자연계</option>
								</select> 
							</td>
							<td>
								<select name="majorList.mCategory">
									<c:forEach var="cd" items="${code.code15 }">
										<option value="${cd.code }" >${cd.name }</option>		
									</c:forEach>
								</select> 
							</td>
							<td>
						      	
						     </td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btn_wrap center">
				<a class="btn_a color_b" title="닫기" href='javascript:window.open("about:blank", "_self").close();'><span>닫기</span></a>
			</div>
		</div>
	</div>
	
<script id="tblMajorTemplate" type="text/x-jquery-tmpl">
<tr>
	<td>
		<input type="text" class="width_90" name="majorList.mCode"  />
	</td>
	<td>
		<input type="text" class="width_90" name="majorList.mName"  />
	</td>
	<td>
		<select name="majorList.mGubun">
			<option value="1" >인문계</option>
			<option value="2" >자연계</option>
		</select> 
	</td>
	<td>
		<select name="majorList.mCategory">
			<c:forEach var="cd" items="${code.code15 }">
				<option value="${cd.code }" >${cd.name }</option>		
			</c:forEach>
		</select> 
	</td>
    <td>
	  <a href="javascript:void(0);" onclick="javascript:goDelete(this);" class="btn_c color_a"><span>삭제</span></a>
	</td>
</tr> 
</script>	
</body>
</html>