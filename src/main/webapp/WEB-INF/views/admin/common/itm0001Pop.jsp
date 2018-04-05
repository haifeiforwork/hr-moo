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
		
		validator = $("#iForm").validate({
			ignore : "",
			rules: {
					  itemCat     : {required : ['대분류']}
					, itemTitle   : {required : ['문항요소']}
					, priorNew    : {required : ['순서(신입)'], number: ['순서(신입)']}
					, priorCareer : {required : ['순서(신입)'], number: ['순서(신입)']}
					, lengthMin   : {required : ['최소글자수'], number: ['최소글자수']}
					, lengthMax   : {required : ['최대글자수'], number: ['최대글자수']}
					, itemDesc    : {required : ['문항내용']}
				  
			}
		});
	}
	
	function goSave(){
		var rUrl = "";
		<c:if test="${procType eq 'new' }">
		rUrl = "/admin/common/insertItm0001Pop"
		</c:if>
		<c:if test="${procType eq 'mod' }">
		rUrl = "/admin/common/updateItm0001Pop"
		</c:if>
		
		$("#iForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				if(!$("#iForm").valid()) {
					validator.focusInvalid();
					return;
				}
			},
			type: "POST",
			url: rUrl,
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.json.result == 'success') {
            		alert(data.json.msg);
            		opener.parent.location.reload();
            		window.close();
            	} else {
            		if(data.json.errors != null) {
	            		var errors = data.json.errors;
	            		//console.log(errors);
	            		
	            		var errorMessage = '';
	            		$.each(errors, function(i, item) {
	            			if(i > 0) errorMessage += "\n";
	            			errorMessage += errors[i].rejectedValue + " : " + errors[i].defaultMessage;
	            		});
	            		
	            		alert(errorMessage);
            		} else {
     	       			alert("에러가 발생하였습니다.");
            		}
            		
            		return;
            	}
            }
        });
		
		$("#iForm").submit();
	}
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">자기소개서 항목 등록</div>
			<div class="button_area">
				<a href="" title="닫기" class="close_btn">닫기</a>
			</div>
		</div>
		<div class="popup_contents">

			<div class="table_header admin">
				<div class="btn_area">
					<a href="javascript:void(0);" onclick="goSave();" class="btn_c color_a additem"><span>저장하기</span></a>
				</div>
			</div>
			
			<form id="iForm" name="iForm" method="post">
				<input type="hidden" name="idx" id="idx" value="${rs.IDX }">
				<input type="hidden" name="procType" id="procType" value="${procType }">
				<table class="contents_table admin marginbottom_20">
					<caption>지원서 지원정보 목록. 채용공고, 수험번호, 지원상태로 구성.</caption>
					<colgroup>
						<col style="width: 120px;" />
						<col style="width: 120px" />
						<col style="width: 120px;" />
						<col style="width: 120px" />
					</colgroup>
					<tbody>
						<tr>
							<th class="text_center">대분류</th>
							<td><input type="text" class="width_90" name="itemCat"  value="${rs.ITEM_CAT }"/></td>
							<th class="text_center">문항요소</th>
							<td><input type="text" class="width_90" name="itemTitle" value="${rs.ITEM_TITLE }"/></td>
						</tr>
						<tr>
							<th class="text_center">순서(신입)</th>
							<td><input type="text" class="width_90" name="priorNew"   value="${rs.PRIOR_NEW }"/></td>
							<th class="text_center">순서(경력)</th>
							<td><input type="text" class="width_90" name="priorCareer" value="${rs.PRIOR_CAREER }"/></td>
						</tr>
						<tr>
							<th class="text_center">최소글자수</th>
							<td><input type="text" class="width_90" name="lengthMin" value="${rs.LENGTH_MIN }"/></td>
							<th class="text_center">최대글자수</th>
							<td><input type="text" class="width_90" name="lengthMax" value="${rs.LENGTH_MAX }"/></td>
						</tr>
						<tr>
							<th class="text_center">문항</th>
							<td colspan="3">
								<textarea id="textarea_contents" name="itemDesc" style="width: 680px; height: 100px;">${rs.ITEM_DESC }</textarea>
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
</body>
</html>