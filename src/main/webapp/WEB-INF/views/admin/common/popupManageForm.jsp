<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
var currentYear = new Date().getFullYear();
var validator;

	$(document).ready(function() {
		alert("화면과 스크립트, java까지 만들어둠. 쿼리 만들면됨");
		fn_smartEditorInit( "textarea_contents", true, false, true );
		picker();
		formValidation();
	});
	
	/************************************************
	* 달력
	************************************************/
	function picker(){
		$('.dateinput').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
	}
	
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
		
		jQuery.validator.addMethod('selectcheck', function (value, element, params) {
	        return (value != '');
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));
		
		
		validator = $("#iForm").validate({
			ignore : "",
			rules: {
				    rTitle:     {required : ['제목']}
				  , rGubun:     {selectcheck : ['채용구분']}
				  , rSdate:     {required : ['시작일자']} 
				  , rSdateTime: {selectcheck : ['시작시간']}
				  , rEdate:     {required : ['종료일자']}
				  , rEdateTime: {selectcheck : ['종료시간']}
				  , rSnum:      {required : ['수험번호'], number: ['수험번호']}
				  
			}
		});
	}
	
	
	function popSave() {
		fn_smartEditorUpdateContentsField();
		
		$("#iForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				if(!$("#iForm").valid()) {
					validator.focusInvalid();
					return;
				}
			},
			type: "POST",
			url: "/admin/common/PopupManageProcess",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	
            	if(data.json.result == 'success') {
            		goList();
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
	
	function goList(){
		document.search_form.submit();
	}
	
	/************************************************
	* 달력버튼 event
	************************************************/
	function showDatepicker(obj) {
		$(obj).prev().prev().datepicker("show");
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
						<input type="hidden" name="idx" value="${pCommon.idx }"> 
						<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
						<input type="hidden" name="procType" value="${procType }">
					</form>
					
					<form id="iForm" name="iForm" method="post">
						
					</form>
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>