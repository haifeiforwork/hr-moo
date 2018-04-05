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
		
		jQuery.validator.addMethod('emailcheck', function (value, element, params) {
        	return chkEmail(value);
	    }, jQuery.validator.format("이메일을 형식에 맞게 작성하세요."));
		
		validator = $("#frm").validate({
			ignore: "",
			rules: {
				rName: {
					required : true,
					minlength : 2
				},
				rBirth: {
					required : true
				},
				rGubun: {
					required : true
				},
				rEmail: {
					required : true,
					emailcheck : true
				}
				
			},
			messages: {
				rName: {
					required : '이름을 입력해주세요.'
					, minlength : $.validator.format('이름은 {0}자 이상이어야 합니다.')
				},
				rBirth: {
					required : '생년월일을 입력해주세요.'
				},
				rGubun: {
					required : '지원구분을 선택해주세요.'
				},
				rEmail: {
					required : '이메일을 입력해주세요'
				}
				
			}
		});
		
	});
	
	function chkEmail(value) 
	{
		var newstr = '';
		var at = false;
		var dot = false;
		var checkString = value;

		if ( checkString.length < 6 ){
			return false;
		}

		if (checkString.indexOf('@') != -1) {
			at = true;
		} else if (checkString.indexOf('.') != -1) {
			dot = true;
		}

		for (var i = 0; i < checkString.length; i++) {
			ch = checkString.substring(i, i + 1);
			
			if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z')|| (ch == '@') || (ch == '.') || (ch == '_')|| (ch == '-') || (ch >= '0' && ch <= '9')) {
				newstr += ch;
				if (ch == '@') {
					at=true;
				}
				if (ch == '.') {
					dot=true;
				}
			} else {
				at = false;
				dot = false;
				break;
	  		}
		}
		
		if ((at == true) && (dot == true)) {
			return true;
		} else {
			// DISPLAY ERROR MESSAGE
			return false;
		}
	}
	
	function existCheck() {
		if(!$("#frm").valid()) {
			validator.focusInvalid();
			return;
		}
		
		$("#frm").ajaxForm({
			url: "/client/job/appyExistPwdCheck",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.json.result == 'fail') {
            		alert("해당 공고에 지원한 이력이 없습니다.\n입력정보를 확인하시기 바랍니다.");
            		return;
            	}else if(data.json.result == 'error'){
            		alert("시스템 에러.\n관리자에게 문의하시기 바랍니다..");
            		return;
            	} else {
            		alert("입력된 이메일 정보로 비밀번호를 발송했습니다.");
            		recNext();
            	}
            }
        });
		
		$("#frm").submit();
	}
	
	function recNext(){
		var frm =document.frm;
		frm.action = "/client/job/recViewLogin";
		frm.submit();
	}
	
	
</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=3&s=3" />

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
				<form method="post" name="frm" id="frm" action="jobNotice">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${pCommon.pageNo}"/>">
					<input type="hidden" name="searchType" value="<c:out value="${pCommon.searchType}"/>">
					
					<input type="hidden" name="SKEY_1" id="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
					<c:if test="${!empty rs.IDX}">
						<input type="hidden" name="idx" value="<c:out value="${rs.IDX}"/>">
						<input type="hidden" name="rIdx" value="<c:out value="${rs.IDX}"/>">
					</c:if>
					
					<div class="jobapp_login">
						<h1><b>비밀번호</b> 찾기</h1>
						<ul class="login_list">
							<li class="rec_title">
								<span class="label">공고명</span>
								<c:choose>
									<c:when test="${!empty rs.IDX}">${rs.R_TITLE}</c:when>
									<c:otherwise>
										<select name="rIdx">
									    	<option value="">채용공고를 선택하세요.</option>
									    	<c:if test="${not empty rsList}">
												<c:forEach var="rs" items="${rsList}" varStatus="status">
													<option value="${rs.IDX}">${rs.R_TITLE}</option>
												</c:forEach>
											</c:if>
									  	</select>
									</c:otherwise>
								</c:choose>
								 
							</li>
							<li>
								<span class="label">성명</span>
								<input type="text" name="rName" id="rName" />
							</li>
							<li>
								<span class="label">생년월일</span>
								<span class="date">
									<input type="text" class="dateinput" name="rBirth" id="rBirth" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색">날짜검색</a>
								</span>
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
								<span class="label">이메일</span>
								<input type="text" name="rEmail" id="rEmail" />
							</li>
						</ul>
						<ul class="login_disc">
							<li><b>성명</b>과 <b>생년월일</b>, <b>이메일</b>을 입력하신 뒤 확인 버튼을 누르시면 <br />입사지원서 작성시 입력한 이메일로 비밀번호를 발송해 드립니다.</li>
						</ul>
					</div>
				
					<div class="btn_wrap center">
						<a class="btn_a color_a" title="확인" href="javascript:void(0)" onclick="existCheck();"><span>확인</span></a>
					</div>
					
				</form>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>