<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	var currentYear = new Date().getFullYear();
	var validator;
	$(document).ready(function() {
		
		$('.btn_a').on('click', function(e) {
			e.preventDefault();
		});
		
		/************************************************
		* 달력
		************************************************/
		$(".dateinput").moorimDatePicker({dateFormat : 'yy.mm.dd', yearRange : '1960:'+currentYear});
		$('.dateinput').on('keyup', function(event) {
			event.preventDefault();
			$(this).val('');
		});
		$(".dateinput_btn").click(function() {
			$(".dateinput").datepicker("show");
		});
		/************************************************
		* END - 달력
		************************************************/
		
		/************************************************
		* form validation
		************************************************/
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
			minlength:"{0}자리 이상 입력하세요."
		});
		
		jQuery.validator.addMethod('selectcheck', function (value, element, params) {
	        return (value != '');
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));
		
		validator = $("#recruitForm").validate({
			ignore: "",
			rules: {
				rIdx: {selectcheck : ['공고']},
				rName: {required : ['성명'], minlength : 2},
				rBirth: {required : ['생년월일']},
				rGubun: {selectcheck : ['지원구분']},
				rPwd: {required : ['비밀번호'], rangelength : [6, 12]}
			},
			messages: {
				rPwd: {rangelength : '비밀번호는 {0}~{1}자리의 숫자 또는 문자로 입력하세요.'}
			}
		});
		
	});
	
	function existCheck() {
		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				if(!$("#recruitForm").valid()) {
					validator.focusInvalid();
					return;
				}
			},
			url: "/client/job/appyCheckLogin",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.applyCode == null || data.applyCode == '') {
            		alert("해당공고에 지원내역이 없습니다.\n정확한 정보를 확인해주세요.");
            		return;
            	} else {
            		$('#rApCode').val(data.applyCode);
            		recNext();
            	}
            }
        });
		
		$("#recruitForm").submit();
	}
	
	function recNext() {
		with (document.recruitForm) {
			action = "/client/acceptedList";
			target="_self";
			submit();
		}
	}
	
	/************************************************
	* 비밀번호 찾기 페이지 이동
	************************************************/
	function searchPwd(){
		var $rIdx = $("select[name=rIdx]");
		
		if($rIdx.val() == "" || $rIdx.val() == undefined){
			alert("공고를 선택하세요.");
			$rIdx.focus();
			return false;
		}
		
		var frm = document.recruitForm;
		frm.action = "/client/job/searchPwd";
		frm.submit();
	}
</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=3&s=2" />

		<!-- 컨텐츠 영역 시작 -->
		<div class="contents_wrap lnb_open">
			<!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 컨텐츠 타이틀 -->
			<div class="page_title">
				<span class="title">채용공고</span> <span class="description">무림
					그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
				<ul class="location">
					<li><a href="">Home</a></li>
					<li><a href="">채용안내</a></li>
					<li class="currentpage"><a href="">인재상</a></li>
				</ul>
			</div>
			<!-- 컨텐츠 내용 -->
			<div class="contetns">
				<form method="post" name="recruitForm" id="recruitForm">
				<input type="hidden" name="rApCode" id="rApCode" />
				<div class="jobapp_login">
					<h1>합격자 <b>발표</b></h1>
					<ul class="login_list">
						<li class="rec_title">
							<span class="label">공고명</span>
							<select name="rIdx">
						    	<option value="">채용공고를 선택하세요.</option>
						    	<c:if test="${not empty rsList}">
									<c:forEach var="rs" items="${rsList}" varStatus="status">
										<option value="${rs.IDX}">${rs.R_TITLE}</option>
									</c:forEach>
								</c:if>
						  	</select>
						</li>
						<li>
							<span class="label">성명</span>
							<input type="text" name="rName" />
						</li>
						<li>
							<span class="label">생년월일</span>
							<input type="text" class="dateinput" name="rBirth" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색">날짜검색</a>
						</li>
						<li>
							<span class="label">지원구분</span>
							<select name="rGubun">
								<option value="" >전체</option>
								<c:forEach items="${code.code40 }" var="cd" varStatus="">
									<option value="${cd.code }">${cd.name }</option>	
								</c:forEach>
							</select>
						</li>
						<li>
							<span class="label">비밀번호</span>
							<input type="password" name="rPwd" />
							<span class="disc">6~12자리 숫자 또는 문자</span>
						</li>
					</ul>
					<ul class="login_disc">
						<li>입사지원서 작성시 입력한 <b>성명</b>과 <b>생년월일</b>, <b>비밀번호</b>를 입력하세요.</li>
						<li>전형결과는 공고 지원의 <b>결과확인</b> 페이지에서 하실 수 있습니다.</li>
						<li>기타 문의 사항은 <b>채용문의</b>를 이용해 주시기 바랍니다.</li>
					</ul>
				</div>
				</form>
			
				<div class="btn_wrap center">
					<a class="btn_a color_a" title="확인" href="" onclick="existCheck();"><span>확인</span></a>
					<a class="btn_a color_b" title="비밀번호 찾기" href="javascript:void(0);" onclick="searchPwd();"><span>비밀번호 찾기</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>