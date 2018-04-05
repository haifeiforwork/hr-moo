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
		<c:if test="${procType eq 'new' }">
			$('[name*=".qIntro"]').each(function(index) { $(this).attr("name", "interviewList[" + index + "].qIntro"); });
			$('[name*=".qDtl"]').each(function(index) { $(this).attr("name", "interviewList[" + index + "].qDtl"); });
		</c:if>
		<c:if test="${procType eq 'mod' }">
			$('[name*=".qIntro"]').each(function(index) { $(this).attr("name", "qIntro"); });
			$('[name*=".qDtl"]').each(function(index) { $(this).attr("name", "qDtl"); });
		</c:if>
		
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="interviewList"]').each(function(index) { 
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}
	
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
		<c:if test="${procType eq 'new' }">
			$('[name*=".qIntro"]').each(function() {
				$(this).rules("add", {required : ['문항인트로']})
			});
			$('[name*=".qDtl"]').each(function() {
				$(this).rules("add", {required : ['심층문항']})
			});
		</c:if>
		<c:if test="${procType eq 'mod' }">
			$('[name*="qIntro"]').each(function() {
				$(this).rules("add", {required : ['문항인트로']})
			});
			$('[name*="qDtl"]').each(function() {
				$(this).rules("add", {required : ['심층문항']})
			});
		</c:if>
		
		
	}
	
	function goSave(){
		$("#iForm").beforSubmitRenameForModelAttribute();
		$.beforeSubmitAddRule();
		
		var rUrl = "";
		<c:if test="${procType eq 'new' }">
		rUrl = "/admin/common/insertItm0002Pop"
		</c:if>
		<c:if test="${procType eq 'mod' }">
		rUrl = "/admin/common/updateItm0002Pop"
		</c:if>

		if(!$("#iForm").valid()) {
			validator.focusInvalid();
			return false;
		}
		
		$.ajax({
			type: 'POST',
			url: rUrl,
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
					<c:if test="${procType eq 'new' }">
					$("#iForm").afterSubmitRenameForView();
					</c:if>
					alert(data.json.msg);
				}
				
			},
			error : function() {
				<c:if test="${procType eq 'new' }">
				$("#iForm").afterSubmitRenameForView();
				</c:if>
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	function goDelete(obj){
		$(obj).closest('tr').next().remove();
		$(obj).closest('tr').remove();
	}
	function addMenuTemplate(){
		$('#tblInterviewTemplate').tmpl().appendTo('#interviewTable');
	}
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">인성면접 항목 등록</div>
			<div class="button_area">
				<a href="" title="닫기" class="close_btn">닫기</a>
			</div>
		</div>
		<div class="popup_contents">

			<div class="table_header admin">
				<div class="btn_area">
					<c:if test="${procType ne 'mod' }">
					<a href="javascript:void(0);" onclick="addMenuTemplate();" class="btn_c color_a additem"><span>추가</span></a>
					</c:if>
					<a href="javascript:void(0);" onclick="goSave();" class="btn_c color_a additem"><span>저장</span></a>
				</div>
			</div>
			
			<form id="iForm" name="iForm" method="post">
				<input type="hidden" name="idx" id="idx" value="${rs.IDX }">
				<input type="hidden" name="procType" id="procType" value="${procType }">
				<input type="hidden" name="eStepCode" value="51020">
				<table class="contents_table admin marginbottom_20" id="interviewTable">
					<caption>문항요소, 문항인트로, 심층문항으로 구성</caption>
					<colgroup>
						<col style="width: 120px;"/>
						<col style="width: *" />
						<col style="width: 120px;"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="text_center">문항요소</th>
							<td colspan="2">
								<select name="qCode" >
							    	<c:forEach items="${code.code60 }" var="cd" varStatus="idx">
										<option value="${cd.code }" ${rs.Q_CODE eq cd.code ? 'selected="selected"':'' } >${cd.name }</option>	
									</c:forEach>
							    </select>
							</td>
						</tr>
						<tr>
							<th class="text_center">문항 인트로</th>
							<td>
								<textarea id="textarea_contents" name="interviewList.qIntro" style="width: 500px; height: 100px;">${rs.Q_INTRO }</textarea>
							</td>
							<td rowspan="2" class="text_center">
								
							</td>
						</tr>
						<tr>
							<th class="text_center">심층문항</th>
							<td>
								<textarea id="textarea_contents" name="interviewList.qDtl" style="width: 500px; height: 100px;">${rs.Q_DTL }</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btn_wrap center">
				<a class="btn_a color_b" title="닫기" href='javascript:window.close();'><span>닫기</span></a>
			</div>
		</div>
	</div>



<script id="tblInterviewTemplate" type="text/x-jquery-tmpl">
<tr>
	<th class="text_center">문항 인트로</th>
	<td>
		<textarea id="textarea_contents" name="interviewList.qIntro" style="width: 500px; height: 100px;"></textarea>
	</td>
	<td rowspan="2" class="text_center">
		<a href="javascript:void(0);" onclick="javascript:goDelete(this);" class="btn_c color_a"><span>삭제</span></a>
	</td>
</tr>
<tr>
	<th class="text_center">심층문항</th>
	<td>
		<textarea id="textarea_contents" name="interviewList.qDtl" style="width: 500px; height: 100px;"></textarea>
	</td>
</tr>
</script>		
</body>
</html>