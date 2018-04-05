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
		    $('[name*=".idx"]').each(function(index) { $(this).attr("name", "itemList[" + index + "].idx"); });
			$('[name*=".eItem"]').each(function(index) { $(this).attr("name", "itemList[" + index + "].eItem"); });
			$('[name*=".eContent"]').each(function(index) { $(this).attr("name", "itemList[" + index + "].eContent"); });
		
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="itemList"]').each(function(index) { 
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}
	
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
			$('[name*=".eItem"]').each(function() {
				$(this).rules("add", {required : ['평가요소']})
			});
			$('[name*=".eContent"]').each(function() {
				$(this).rules("add", {required : ['평가기준']})
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
			url: "/admin/common/evalItmProcess",
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
		var $obj = $(obj).closest('tr');
		var idx = $obj.find("input[name='itemList.idx']").val();
		if(isNullStr(idx)){
			$obj.next().remove();
			$obj.remove();	
		}else{
			$.ajax({
				type: 'POST',
				url: "/admin/common/evalItmDelete",
				data: {"idx" : idx},
				async: false,
		        cache: false,
		        beforeSend:function(){

		        },
				success: function(data) {
					if(data.json.result == "SUCCESS"){
						$obj.next().remove();
						$obj.remove();	
					}else{
						alert(data.json.msg);
					}
					
				},
				error : function() {
					alert("알수 없는 에러가 발생했습니다.");
				},
				dataType: "json"
			}); 
		}
		
	}
	function addMenuTemplate(){
		$('#tblItemTemplate').tmpl().appendTo('#itemTable');
	}
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">인성면접 평가 등록</div>
			<div class="button_area">
				<a href="" title="닫기" class="close_btn">닫기</a>
			</div>
		</div>
		<div class="popup_contents">

			<div class="table_header admin">
				<div class="btn_area">
					<a href="javascript:void(0);" onclick="addMenuTemplate();" class="btn_c color_a additem"><span>추가</span></a>
					<a href="javascript:void(0);" onclick="goSave();" class="btn_c color_a additem"><span>저장</span></a>
				</div>
			</div>
			
			<form id="iForm" name="iForm" method="post">
				<input type="hidden" name="itemIndex" id="itemIndex" value="${rs.IDX }">
				<input type="hidden" name="procType" id="procType" value="${procType }">
				<input type="hidden" name="eStepCode" value="51020">
				<table class="contents_table admin marginbottom_20" id="itemTable">
					<caption>문항요소, 문항인트로, 심층문항으로 구성</caption>
					<colgroup>
						<col style="width: 120px;"/>
						<col style="width: *" />
						<col style="width: 120px;"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="text_center">평가단계</th>
							<td colspan="2">인성면접</td>
						</tr>
						<tr>
							<th class="text_center">문항요소</th>
							<td colspan="2"><c:out value="${rs.Q_CODE_NM }" /></td>
						</tr>
						<tr>
							<th class="text_center">문항 인트로</th>
							<td colspan="2">
								<c:out value="${rs.Q_INTRO }" />
							</td>
						</tr>
						<tr>
							<th class="text_center">심층문항</th>
							<td colspan="2">
								<c:out value="${rs.Q_DTL }" />
							</td>
						</tr>
						
						<c:if test="${procType eq 'new'}">
							<tr>
								<th class="text_center">평가요소</th>
								<td>
									<input type="hidden" name="itemList.idx" value="">
									<textarea id="textarea_contents" name="itemList.eItem" style="width: 500px; height: 100px;"></textarea>
								</td>
								<td rowspan="2" class="text_center">
									
								</td>
							</tr>
							<tr>
								<th class="text_center">평가기준</th>
								<td>
									<textarea id="textarea_contents" name="itemList.eContent" style="width: 500px; height: 100px;"></textarea>
								</td>
							</tr>
						</c:if>
						<c:if test="${procType eq 'mod'}">
							<c:if test="${!empty rsList }">
								<c:forEach var="item" items="${rsList }">
									<tr>
										<th class="text_center">평가요소</th>
										<td>
											<input type="hidden" name="itemList.idx" value="${item.IDX }">
											<textarea id="textarea_contents" name="itemList.eItem" style="width: 500px; height: 100px;"><c:out value="${item.E_ITEM }" /></textarea>
										</td>
										<td rowspan="2" class="text_center">
											<a href="javascript:void(0);" onclick="javascript:goDelete(this);" class="btn_c color_a"><span>삭제</span></a>
										</td>
									</tr>
									<tr>
										<th class="text_center">평가기준</th>
										<td>
											<textarea id="textarea_contents" name="itemList.eContent" style="width: 500px; height: 100px;"><c:out value="${item.E_CONTENT }" /></textarea>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</c:if>
						
						
					</tbody>
				</table>
			</form>
			<div class="btn_wrap center">
				<a class="btn_a color_b" title="닫기" href='javascript:window.close();'><span>닫기</span></a>
			</div>
		</div>
	</div>



<script id="tblItemTemplate" type="text/x-jquery-tmpl">
<tr>
	<th class="text_center">평가요소</th>
	<td>
		<input type="hidden" name="itemList.idx" value="">
		<textarea id="textarea_contents" name="itemList.eItem" style="width: 500px; height: 100px;"></textarea>
	</td>
	<td rowspan="2" class="text_center">
		<a href="javascript:void(0);" onclick="javascript:goDelete(this);" class="btn_c color_a"><span>삭제</span></a>
	</td>
</tr>
<tr>
	<th class="text_center">평가기준</th>
	<td>
		<textarea id="textarea_contents" name="itemList.eContent" style="width: 500px; height: 100px;"></textarea>
	</td>
</tr>
</script>		
</body>
</html>