<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	#file {width:0; height:0 !important;}
</style>
<script type="text/javascript">
	var validator;
	$(document).ready(function() {

		$('.btn_a').on('click', function(e) {
			e.preventDefault();
		});

		/************************************************
		* 응시직무 동적 selectbox 제어
		************************************************/
		$.fn.makeCombo = function(depth, value) {
			var _this = $(this);

			var params = new Object();
			params.rIdx = $('#rIdx').val();
			params.depth = depth;

			if(depth == '2') {
				params.rCode1 = (value != null) ? value[0] : _this.prev().val();
			} else if(depth == '3') {
				params.rCode1 = (value != null) ? value[0] : _this.prev().prev().val();
				params.rCode2 = (value != null) ? value[1] : _this.prev().val();
			}

			$.ajax({
				url : "/client/job/getNoticeOptions",
				global: false,
				dataType : "json",
				data : params,
				beforeSend : function() {
					//기존 옵션 삭제
					_this.find("option").each(function(index) { if(index > 0) $(this).remove(); });
					//loading option 추가
					_this.prepend("<option val='load'>&#160;&#160;&#160;&#160;loading</option>");
					//loading option 선택
					_this.find('option').eq(0).prop("selected", true);
					//loading image 추가
					if($('#loadingCombo').length == 0) {
						var loadingImg = "<div id='loadingCombo' style='position:absolute; left:50%; top:40%; z-index:10000;'>";
					    loadingImg += " <img src='/resources/images/ajax-loader.gif'/>";
					    loadingImg += "</div>";

					    //화면에 레이어 추가
					    $('body').append(loadingImg);

					    $('#loadingCombo').css("position","absolute");
					    $('#loadingCombo').css("top", _this.offset().top + _this.height()/2);
					    $('#loadingCombo').css("left", _this.offset().left + 5);
					    $('#loadingCombo').show();
					}
				},
				success : function(data) {
					if(data.result == 'success') {
						//loading image 삭제
						$('#loadingCombo').remove();
						//loading option 삭제
						_this.find('option').eq(0).remove();
						//신규 옵션 추가
						$.each(data.optionList, function(index) {
							_this.append("<option value='"+data.optionList[index].CODE+"'>"+data.optionList[index].NAME+"</option>");
						});
						//option=value 선택
						if(value != null) _this.val(value[depth-1]).prop("selected", true);
					} else {
						alert(data.message);
					}
				}
			});
	    };

	    $.fn.comboChageEvent = function(depth) {
	    	var _this = $(this);

	    	_this.change(function(e) {
	    		//1depth일 경우 3depth selectbox 초기화
	    		if(depth == 1) _this.next().next().find("option").each(function(index) { if(index > 0) $(this).remove(); });
	    		//다음 depth selectbox생성
	    		_this.next().makeCombo(depth+1);
	    	});
	    }

	    // 초기값배열
	    var comboInitData1 = ['${rs.R_JOB_KIND_CODE1}', '${rs.R_JOB_PART_CODE1}', '${rs.R_JOB_AREA_CODE1}'];
	    var comboInitData2 = ['${rs.R_JOB_KIND_CODE2}', '${rs.R_JOB_PART_CODE2}', '${rs.R_JOB_AREA_CODE2}'];

	    // selectbox 초기화
	    $('#rJobKindCode1').makeCombo(1, comboInitData1);
		$('#rJobKindCode2').makeCombo(1, comboInitData2);
	    $('#rJobPartCode1').makeCombo(2, comboInitData1);
		$('#rJobPartCode2').makeCombo(2, comboInitData2);
	    $('#rJobAreaCode1').makeCombo(3, comboInitData1);
		$('#rJobAreaCode2').makeCombo(3, comboInitData2);

		// 직무,직군 변경이벤트 binding
		$('#rJobKindCode1').comboChageEvent(1);
	    $('#rJobKindCode2').comboChageEvent(1);
	    $('#rJobPartCode1').comboChageEvent(2);
	    $('#rJobPartCode2').comboChageEvent(2);
	    /************************************************
		* END - 응시직무 동적 selectbox 제어
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
			number:"{0}는 숫자만 입력할 수 있습니다."
		});

		jQuery.validator.addMethod('selectcheck', function (value, element, params) {
	        return (value != '');
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));

		validator = $("#recruitForm").validate({
			rules: {
				rHname: {required : ['성명(한자)']}
				,rEname: {required : ['성명(영문)']}
				,rBirthCode: {selectcheck : ['양/음력']}
				,rSexCode: {selectcheck : ['성별']}
				,rJobKindCode1: {selectcheck : ['1지망 직군']}
				,rJobPartCode1: {selectcheck : ['1지망 직무']}
				,rJobAreaCode1: {selectcheck : ['1지망 지역']}
				,rJobKindCode2: {selectcheck : ['2지망 직군']}
				,rJobPartCode2: {selectcheck : ['2지망 직무']}
				,rJobAreaCode2: {selectcheck : ['2지망 지역']}
				,rPost: {required : ['우편번호']}
				,rAddr1: {required : ['주소']}
				,rAddr2: {required : ['주소']}
				,rTel02: {required : ['전화번호'], number : ['전화번호']}
				,rTel03: {required : ['전화번호'], number : ['전화번호']}
				,rHp01: {selectcheck : ['무선전화번호']}
				,rHp02: {required : ['무선전화번호'], number : ['무선전화번호']}
				,rHp03: {required : ['무선전화번호'], number : ['무선전화번호']}
				,rEmail01: {required : ['이메일 주소']}
				,rEmail02: {required : ['이메일 주소']}
			}
		});
		/************************************************
		* END - form validation
		************************************************/

		/************************************************
		* photo
		************************************************/
		$('#btn-file-upload').click(function(e) {
			e.preventDefault();
			$('input:file').click();
		});

		$('input:file').change(function(e) {
			var _this = this;
			var ext = $('input:file').val().split(".").pop().toLowerCase();
			if(ext.length > 0) {
				if($.inArray(ext, ["gif", "png", "jpg", "jpeg"]) == -1) {
					alert("gif,png,jpg 파일만 업로드 할 수 있습니다.");
					return;
				}
			}
			$('input:file').val().toLowerCase();

			$("#fileFrm").ajaxForm({
				url: "/client/job/uploadFileReg",
				enctype: "multipart/form-data",
	            error : function(){
	                alert("에러가 발생하였습니다.");
	                return;
	            },
	            success : function(data){
	            	if(data.json.result == 'success') {
	            		var _realPhoto = data.json.list[0].file_info;
	            		$('#rPhoto').val(_realPhoto);
	            		preview(_this);
		                //alert("사진이 등록되었습니다.");
	            	} else {
	            		alert("에러가 발생하였습니다.");
	            		return;
	            	}
	            }
	        });

			$("#fileFrm").submit();
		});
		/************************************************
		* END - photo
		************************************************/

	}); // END - document.ready

	function preview(input) {
		if(input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#photoPreview').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}
	/************************************************
	* END - photo
	************************************************/

	/************************************************
	* [이전]
	************************************************/
	function goList() {
		with (document.recruitForm) {
			if($('#editMode').val() == "init") {
				action = "jobNotice";
			} else {
				action = "recViewLogin";
			}
			target="_self";
			submit();
		}
	}

	/************************************************
	* [개인신상 저장]
	************************************************/
	function recSave() {
		if(!$("#recruitForm").valid()) {
			validator.focusInvalid();
			return;
		}

		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				arr.push(
					{name : 'rTel', value : $('#rTel01').val() + '-' + $('#rTel02').val() + '-' + $('#rTel03').val()}
					, {name : 'rHp', value : $('#rHp01').val() + '-' + $('#rHp02').val() + '-' + $('#rHp03').val()}
					, {name : 'rEmail', value : $('#rEmail01').val() + '@' + $('#rEmail02').val()}
					, {name : 'rArmySdate', value : $('#rArmySdate01').val() + $('#rArmySdate02').val()}
					, {name : 'rArmyEdate', value : $('#rArmyEdate01').val() + $('#rArmyEdate02').val()}
				)
			},
			url: "/client/job/saveApplyMaster",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.json.result == 'success') {
            		$('#rApCode').val(data.vo.rApCode);

            		goNext();
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

		$("#recruitForm").submit();
	}

	/************************************************
	* [다음단계로]
	************************************************/
	function goNext() {
		with (document.recruitForm) {
			action = "myRecStep02";
			target="_self";
			submit();
		}
	}

	/************************************************
	* [우편번호 찾기]
	************************************************/
	function execPostCode() {
		new daum.Postcode({
            oncomplete: function(data) {
            	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('rPost').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('rAddr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('rAddr2').focus();
            }
        }).open();
	}

</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=1&s=1" />
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
				<form name="fileFrm" id="fileFrm" method="post" enctype="multipart/form-data">
				    <input type="file" name="file" id="file">
				    <input type="hidden" name="file_dir" value="job">
				    <input type="hidden" name="exts" value="jpg|jpeg|gif|png" />
				</form>
				<form method="post" name="recruitForm" id="recruitForm" action="">
				<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${pCommon.pageNo}"/>">
				<input type="hidden" name="searchType" value="<c:out value="${pCommon.searchType}"/>">
				<input type="hidden" name="SKEY_1" id="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
				<input type="hidden" name="procType" id="procType" value="${rs.procType}"">
				<input type="hidden" name="editMode" id="editMode" value="${recruit.editMode}" />
				<input type="hidden" name="rApCode" id="rApCode" value="${rs.R_AP_CODE}" />
				<input type="hidden" name="rIdx" id="rIdx" value="${rs.R_IDX}" />
				<input type="hidden" name="rName" value="${rs.R_NAME}" />
				<input type="hidden" name="rGubun" value="${rs.R_GUBUN}" />
				<input type="hidden" name="rPwd" value="${rs.R_PWD}" />
				<input type="hidden" name="rBirth" value="${rs.R_BIRTH}" />
				<input type="hidden" name="rAge" value="${rs.R_AGE}" />
				<input type="hidden" name="rPhoto" id="rPhoto" value="${rs.R_PHOTO}" />
				<ul class="jobapp_tab">
					<li class="current"><span>개인신상</span></li>
					<li><span>학력사항</span></li>
					<li><span>경력/어학/자격</span></li>
					<li><span>자기소개서</span></li>
				</ul>

				<h2>기본정보</h2>
				<table class="jobapp_table">
					<caption>기본정보 목록. 성명, 생년월일, 성별, 나이, 응시직무로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				    <col style="width:170px;" />
				  </colgroup>
					<tbody>
						<tr>
							<th><span class="req">성명</span></th>
							<td>
								<span class="labelset">
									<span class="label">한글</span>
									<input type="text" readonly value="${rs.R_NAME}"/>
								</span>
								<span class="labelset">
									<span class="label">한자</span>
									<input type="text" name="rHname" id="rHname" value="${rs.R_HNAME}" />
								</span>
								<br  />
								<span class="labelset margintop_10">
									<span class="label">영문</span>
									<input type="text" style="width:372px;" name="rEname" id="rEname" value="${rs.R_ENAME}" />
								</span>
							</td>
							<td rowspan="4" class="photo">
								<c:choose>
									<c:when test="${not empty rs.R_PHOTO}">
										<c:set var="photoFile" value="${fn:split(rs.R_PHOTO,'*')}" />
										<img src="${pageContext.request.contextPath}/client/job/getPic?pic_no=${photoFile[0]}" id="photoPreview" />
									</c:when>
									<c:otherwise>
										<img src="${pageContext.request.contextPath}/resources/images/no_photo.jpg" id="photoPreview" />
									</c:otherwise>
								</c:choose>
								<a class="btn_b color_a" id="btn-file-upload" title="사진등록" href="javascript:void(0);"><span>사진등록</span></a>
							</td>
						</tr>
						<tr>
							<th><span class="req">생년월일</span></th>
							<td>
								${fn:substring(rs.R_BIRTH, 0, 4)}년 ${fn:substring(rs.R_BIRTH, 4, 6)}월 ${fn:substring(rs.R_BIRTH, 6, 8)}일
								<select name="rBirthCode" id="rBirthCode">
								    <option value>양/음력</option>
								    <option value="1" <c:if test="${rs.R_BIRTH_CODE eq '1'}">selected</c:if>>양력</option>
								    <option value="2" <c:if test="${rs.R_BIRTH_CODE eq '2'}">selected</c:if>>음력</option>
							  	</select>
							</td>
						</tr>
						<tr>
							<th><span class="req">성별</span></th>
							<td>
								<select name="rSexCode" id="rSexCode">
							    	<option value>성별</option>
							    	<option value="1" <c:if test="${rs.R_SEX_CODE eq '1'}">selected</c:if>>남</option>
							    	<option value="2" <c:if test="${rs.R_SEX_CODE eq '2'}">selected</c:if>>여</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><span>나이</span></th>
							<td>
								만 ${rs.R_AGE}세
							</td>
						</tr>
						<tr>
							<th rowspan="2" class="endrow"><span class="req">응시직무</span></th>
							<td colspan="3">
								<span class="label">1지망</span>
								<select class="width_30" name="rJobKindCode1" id="rJobKindCode1">
							    	<option value>직군</option>
							 	</select>
								<select class="width_30" name="rJobPartCode1" id="rJobPartCode1">
							    	<option value>직무</option>
							  	</select>
								<select class="width_30" name="rJobAreaCode1" id="rJobAreaCode1">
							    	<option value>지역</option>
							  	</select>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<span class="label">2지망</span>
								<select class="width_30" name="rJobKindCode2" id="rJobKindCode2">
									<option value>직군</option>
								</select>
								<select class="width_30" name="rJobPartCode2" id="rJobPartCode2">
									<option value>직무</option>
								</select>
								<select class="width_30" name="rJobAreaCode2" id="rJobAreaCode2">
									<option value>지역</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>

				<h2>연락처</h2>
				<table class="jobapp_table">
					<caption>연락처 목록. 주소, 연락처, 이메일주소로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				  </colgroup>
					<tbody>
						<tr>
							<th rowspan="2"><span class="req">주소</span></th>
							<td>
								<input type="text" name="rPost" id="rPost" value="${rs.R_POST}" onclick="execPostCode();" />
								<a class="btn_b color_a" title="사진등록" href="javascript:execPostCode();"><span>우편번호 검색</span></a>
								<input type="text" style="width:500px;" name="rAddr1" id="rAddr1" value="${rs.R_ADDR1}" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">상세주소</span>
								<input type="text" style="width:696px;" name="rAddr2" id="rAddr2" value="${rs.R_ADDR2}" />
							</td>
						</tr>
						<tr>
							<th rowspan="2"><span class="req">연락처</span></th>
							<td>
								<c:set var="tels" value="${fn:split(rs.R_TEL, '-')}" />
								<span class="label">유선번호</span>
								<select name="rTel01" id="rTel01">
									<option value="02" <c:if test="${tels[0] eq '02'}">selected</c:if>>02</option>
									<option value="031" <c:if test="${tels[0] eq '031'}">selected</c:if>>031</option>
									<option value="032" <c:if test="${tels[0] eq '032'}">selected</c:if>>032</option>
									<option value="033" <c:if test="${tels[0] eq '033'}">selected</c:if>>033</option>
									<option value="041" <c:if test="${tels[0] eq '041'}">selected</c:if>>041</option>
									<option value="042" <c:if test="${tels[0] eq '042'}">selected</c:if>>042</option>
									<option value="043" <c:if test="${tels[0] eq '043'}">selected</c:if>>043</option>
									<option value="044" <c:if test="${tels[0] eq '044'}">selected</c:if>>044</option>
									<option value="051" <c:if test="${tels[0] eq '051'}">selected</c:if>>051</option>
									<option value="052" <c:if test="${tels[0] eq '052'}">selected</c:if>>052</option>
									<option value="053" <c:if test="${tels[0] eq '053'}">selected</c:if>>053</option>
									<option value="054" <c:if test="${tels[0] eq '054'}">selected</c:if>>054</option>
									<option value="055" <c:if test="${tels[0] eq '055'}">selected</c:if>>055</option>
									<option value="061" <c:if test="${tels[0] eq '061'}">selected</c:if>>061</option>
									<option value="062" <c:if test="${tels[0] eq '062'}">selected</c:if>>062</option>
									<option value="063" <c:if test="${tels[0] eq '063'}">selected</c:if>>063</option>
									<option value="064" <c:if test="${tels[0] eq '064'}">selected</c:if>>064</option>
									<option value="070" <c:if test="${tels[0] eq '070'}">selected</c:if>>070</option>
									<option value="010" <c:if test="${tels[0] eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${tels[0] eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${tels[0] eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${tels[0] eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${tels[0] eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${tels[0] eq '019'}">selected</c:if>>019</option>
								</select>
								-
								<input type="text" name="rTel02" id="rTel02" value="${tels[1]}" />
								-
								<input type="text" name="rTel03" id="rTel03" value="${tels[2]}" />
							</td>
						</tr>
						<tr>
							<td>
								<c:set var="cells" value="${fn:split(rs.R_HP, '-')}" />
								<span class="label">무선번호</span>
								<select name="rHp01" id="rHp01">
									<option value>선택</option>
									<option value="010" <c:if test="${cells[0] eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${cells[0] eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${cells[0] eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${cells[0] eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${cells[0] eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${cells[0] eq '019'}">selected</c:if>>019</option>
								</select>
								-
								<input type="text" name="rHp02" id="rHp02" value="${cells[1]}" />
								-
								<input type="text" name="rHp03" id="rHp03" value="${cells[2]}" />
							</td>
						</tr>
						<tr>
							<th><span class="req">이메일주소</span></th>
							<td>
								<c:set var="emails" value="${fn:split(rs.R_EMAIL, '@')}" />
								<input type="text" name="rEmail01" id="rEmail01" value="${emails[0]}" />
								@
								<input type="text" name="rEmail02" id="rEmail02" value="${emails[1]}" />
								<select onchange="recruitForm.rEmail02.value = this.value;">
							    	<option value>선택하세요</option>
									<option value="naver.com">naver.com</option>
									<option value="chol.com">chol.com</option>
									<option value="dreamwiz.com">dreamwiz.com</option>
									<option value="empal.com">empal.com</option>
									<option value="freechal.com">freechal.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanafos.com">hanafos.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hanmir.com">hanmir.com</option>
									<option value="hitel.net">hitel.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="korea.com">korea.com</option>
									<option value="lycos.co.kr">lycos.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="netian.com">netian.com</option>
									<option value="paran.com">paran.com</option>
									<option value="yahoo.com">yahoo.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value>직접입력</option>
							  	</select>
							</td>
						</tr>
					</tbody>
				</table>

				<h2>보훈/병력사항</h2>
				<table class="jobapp_table">
					<caption>보훈/병력사항 목록. 보훈, 병력사항으로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				  </colgroup>
					<tbody>
						<tr>
							<th rowspan="2"><span>보훈</span></th>
							<td>
								<span class="labelset">
									<span class="label">보훈종류</span>
									<select name="rBohunKind" id="rBohunKind">
								    	<option value>보훈종류</option>
								    	<c:if test="${not empty bohunCodes}">
								    		<c:forEach var="code" items="${bohunCodes}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${rs.R_BOHUN_KIND eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
								  	</select>
								</span>
								<span class="labelset">
									<span class="label">보훈번호</span>
									<input type="text" name="rBohunNum" id="rBohunNum" value="${rs.R_BOHUN_NUM}" />
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">보훈자관계</span>
								<select name="rBohunRelation" id="rBohunRelation">
									<option value>관계</option>
									<option value="부" <c:if test="${rs.R_BOHUN_RELATION eq '부'}">selected</c:if>>부</option>
									<option value="모" <c:if test="${rs.R_BOHUN_RELATION eq '모'}">selected</c:if>>모</option>
									<option value="조부" <c:if test="${rs.R_BOHUN_RELATION eq '조부'}">selected</c:if>>조부</option>
									<option value="조모" <c:if test="${rs.R_BOHUN_RELATION eq '조모'}">selected</c:if>>조모</option>
									<option value="본인" <c:if test="${rs.R_BOHUN_RELATION eq '본인'}">selected</c:if>>본인</option>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="4"><span>병력사항</span></th>
							<td>
								<span class="labelset">
									<span class="label">역종</span>
									<select name="rArmyKind" id="rArmyKind">
								    	<option value>역종</option>
								    	<c:if test="${not empty armyKindCodes}">
								    		<c:forEach var="code" items="${armyKindCodes}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${rs.R_ARMY_KIND eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
								  	</select>
								</span>
								<span class="labelset">
									<span class="label">군별</span>
									<select name="rArmyType" id="rArmyType">
								    	<option value>군별</option>
								    	<c:if test="${not empty armyTypeCodes}">
								    		<c:forEach var="code" items="${armyTypeCodes}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${rs.R_ARMY_TYPE eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
								  	</select>
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="labelset">
									<span class="label">병과</span>
									<select name="rArmyBranch" id="rArmyBranch">
										<option value>병과</option>
										<c:if test="${not empty armyBranchCodes}">
								    		<c:forEach var="code" items="${armyBranchCodes}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${rs.R_ARMY_BRANCH eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
									</select>
								</span>
								<span class="labelset">
									<span class="label">계급</span>
									<select name="rArmyClass" id="rArmyClass">
										<option value>계급</option>
										<c:if test="${not empty armyClassCodes}">
								    		<c:forEach var="code" items="${armyClassCodes}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${rs.R_ARMY_CLASS eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<c:set var="armySdateYear" value="${fn:substring(rs.R_ARMY_SDATE, 0, 4)}" />
								<c:set var="armySdateMonth" value="${fn:substring(rs.R_ARMY_SDATE, 5, 6)}" />
								<c:set var="armyEdateYear" value="${fn:substring(rs.R_ARMY_EDATE, 0, 4)}" />
								<c:set var="armyEdateMonth" value="${fn:substring(rs.R_ARMY_EDATE, 5, 6)}" />
								<span class="labelset">
									<c:set var="now" value="<%=new java.util.Date()%>" />
									<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
									<span class="label">복무기간</span>
									<select name="rArmySdate01" id="rArmySdate01">
										<option value>연도</option>
										<c:forEach var="i" begin="0" end="${sysYear-1950}">
											<c:set var="yearOption" value="${sysYear-i}" />
											<option value="${yearOption}" <c:if test="${armySdateYear eq yearOption}">selected</c:if>>${yearOption}</option>
										</c:forEach>
									</select>
									년
									<select name="rArmySdate02" id="rArmySdate02">
										<option value>월</option>
										<c:forEach var="i" begin="1" end="12">
											<c:set var="monthOption" value="${i}" />
											<option value="<fmt:formatNumber value="${monthOption}" pattern="00" />" <c:if test="${armySdateMonth eq monthOption}">selected</c:if>>${monthOption}</option>
										</c:forEach>
									</select>
									월
									~
									<select name="rArmyEdate01" id="rArmyEdate01">
										<option value>연도</option>
										<c:forEach var="i" begin="0" end="${sysYear-1950}">
											<c:set var="yearOption" value="${sysYear-i}" />
											<option value="${yearOption}" <c:if test="${armyEdateYear eq yearOption}">selected</c:if>>${yearOption}</option>
										</c:forEach>
									</select>
									년
									<select name="rArmyEdate02" id="rArmyEdate02">
										<option value>월</option>
										<c:forEach var="i" begin="1" end="12">
											<c:set var="monthOption" value="${i}" />
											<option value="<fmt:formatNumber value="${monthOption}" pattern="00" />" <c:if test="${armyEdateMonth eq monthOption}">selected</c:if>>${monthOption}</option>
										</c:forEach>
									</select>
									월
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="labelset">
									<span class="label">면제사유</span>
									<input type="text" style="width:696px;" name="rArmyExceptReason" id="rArmyExceptReason" value="${rs.R_ARMY_EXCEPT_REASON}" />
							</td>
						</tr>
					</tbody>
				</table>
				</form>

				<div class="btn_wrap center">
					<a class="btn_a color_b" title="이전" href="" onclick="goList();"><span>이전</span></a>
					<a class="btn_a color_a" title="다음 단계로" href="" onclick="recSave();"><span>다음 단계로</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>