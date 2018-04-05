<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />

<c:set var="SQUOT">'</c:set>
<c:set var="resJsonNatCodes" value="${fn:replace(jsonNatCodes, SQUOT, '’')}" />
<c:set var="resJsonLanguageCodes" value="${fn:replace(jsonLanguageCodes, SQUOT, '’')}" />
<c:set var="resJsonExamCodes" value="${fn:replace(jsonExamCodes, SQUOT, '’')}" />
<c:set var="resJsonCertGradeCodes" value="${fn:replace(jsonCertGradeCodes, SQUOT, '’')}" />

<script type="text/javascript">
	var currentYear = new Date().getFullYear();

	// 학기 array
	var termArr = ['1', '2', '3', '4', '5', '6', '7', '8'];
	// 국가 공통코드
	var jsonNatCodes = $.parseJSON('${resJsonNatCodes}');
	// 외국어명 공통코드
	var jsonLanguageCodes = $.parseJSON('${resJsonLanguageCodes}');
	// 시험명 공통코드
	var jsonExamCodes = $.parseJSON('${resJsonExamCodes}');
	// 자격등급 공통코드
	var jsonCertGradeCodes = $.parseJSON('${resJsonCertGradeCodes}');

	var validator;

	$(document).ready(function() {

		$('.btn_a').on('click', function(e) {
			e.preventDefault();
		});

		$('.jobapp_tab > li').click(function(e) {
			if($(this).data("action")) {
				with (document.recruitForm) {
					action = $(this).data("action");
					target="_self";
					submit();
				}
			} else {
				e.preventDefault();
			}
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

		jQuery.extend(jQuery.validator.messages, {
			required:"{0}을(를) 입력해주세요.",
			number:"{0}는 숫자만 입력할 수 있습니다.",
			digits:"{0}은 숫자만 입력할 수 있습니다."
		});

		validator = $("#recruitForm").validate();
		/************************************************
		* END - form validation
		************************************************/

		/************************************************
		* 입력 추가 버튼
		************************************************/
		$('#addCareerBtn').on('click', function(e) {
			e.preventDefault();
			$('#tblCareerTemplate').tmpl().appendTo('#tableCareer');
			$('input[name="careerList.cSmonth"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="careerList.cSmonth"]:last').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
			$('input[name="careerList.cEmonth"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="careerList.cEmonth"]:last').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		});

		$('#addTrainingBtn').on('click', function(e) {
			e.preventDefault();
			$('#tblTrainingTemplate').tmpl().appendTo('#tableTraining');
			$('input[name="trainingList.tSdate"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="trainingList.tSdate"]:last').moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear});
			$('input[name="trainingList.tEdate"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="trainingList.tEdate"]:last').moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear});
		});

		$('#addLanguageBtn').on('click', function(e) {
			e.preventDefault();
			$('#tblLanguageTemplate').tmpl().appendTo('#tableLanguage');
			$('input[name="languageList.lEdate"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="languageList.lEdate"]:last').moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear});
		});

		$('#addCertBtn').on('click', function(e) {
			e.preventDefault();
			$('#tblCertTemplate').tmpl().appendTo('#tableCert');
			$('input[name="certList.cEdate"]:last').on('keyup', function(event) {event.preventDefault(); $(this).val('');});
			$('input[name="certList.cEdate"]:last').moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear});
			$('input[name="certList.cName"]:last').autoSchoolSearch();
		});
		/************************************************
		* END - 입력 추가 버튼
		************************************************/

		/************************************************
		* calendar
		************************************************/
		$('.dateinput').on('keyup', function(event) {
			event.preventDefault();
			$(this).val('');
		});

		$('input[name="careerList.cSmonth"]').each(function() { $(this).MonthPicker({Button: false, MonthFormat: 'yy.mm'}); });
		$('input[name="careerList.cEmonth"]').each(function() { $(this).MonthPicker({Button: false, MonthFormat: 'yy.mm'}); });
		$('input[name="trainingList.tSdate"]').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
		$('input[name="trainingList.tEdate"]').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
		$('input[name="languageList.lEdate"]').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
		$('input[name="certList.cEdate"]').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
		/************************************************
		* END - calendar
		************************************************/

		/************************************************
		* 자격증 search autocomplete
		************************************************/
		$.fn.autoSchoolSearch = function() {
			var _this = $(this);

			this.autocomplete({
				delay: 0,
				source : function(request, response) {
					$.ajax({
						type: "POST",
						url : "/client/job/searchCert",
						global: false,
						dataType : "json",
						data : {
							searchTxt : request.term
						},
						beforeSend : function() {
							//loading image 추가
							if($('#autoLoadingImg').length == 0) {
								var loadingImg = "<div id='autoLoadingImg' style='position:absolute; left:50%; top:40%; z-index:10000;'>";
							    loadingImg += " <img src='/resources/images/ajax-loader.gif'/>";
							    loadingImg += "</div>";

							    //화면에 레이어 추가
							    $('body').append(loadingImg);

							    $('#autoLoadingImg').css("position","absolute");
							    $('#autoLoadingImg').css("top", _this.offset().top + _this.height()/2);
							    $('#autoLoadingImg').css("left", _this.offset().left + _this.width()-30);
							    $('#autoLoadingImg').show();
							}
						},
						success : function(data) {
							//loading image 삭제
							$('#autoLoadingImg').remove();
							//검색값 display
							var certs = data.result;
							response(
	                            $.map(certs, function(item) {
	                               	return {
	                                    label: item.name,
	                                    value: item.code
	                               	}
	                            })
	                        );
						}
					});
				},
				minLength : 2,
				focus : function(event, ui) {
					event.preventDefault();
				},
				select : function(event, ui) {
					$(this).val(ui.item.label);
					$(this).prev().val(ui.item.value);
					return false;
				},
				change: function (event, ui) {
	                if(!ui.item){
	                    $(this).val("");
	                }

	            }
			});
		}

		$('input[name="certList.cName"]').each(function() {
			$(this).autoSchoolSearch();
		});
		/************************************************
		* END - 자격증 search autocomplete
		************************************************/
	});

	/************************************************
	* [경력/어학/자격 저장]
	************************************************/
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
		$('[name*=".cIncome"]').each(function() {
			$(this).rules("add", {digits: '연봉'})
		});
	}

	// Submit전 객체의 name 속성을 MODEL list 형태로 변환
	$.fn.beforSubmitRenameForModelAttribute = function() {
		$('[name="careerList.cName"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cName"); });
		$('[name="careerList.cPart"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cPart"); });
		$('[name="careerList.cIncome"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cIncome"); });
		$('[name="careerList.cPosition"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cPosition"); });
		$('[name="careerList.cWork"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cWork"); });
		$('[name="careerList.cSmonth"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cSmonth"); });
		$('[name="careerList.cEmonth"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cEmonth"); });
		$('[name="careerList.cPerform"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cPerform"); });
		$('[name="careerList.cType"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cType"); });
		$('[name="careerList.cRelYn"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cRelYn"); });
		$('[name="careerList.cReason"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].cReason"); });
		$('[name="trainingList.tGubunCode"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tGubunCode"); });
		$('[name="trainingList.tNatCode"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tNatCode"); });
		$('[name="trainingList.tInstitution"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tInstitution"); });
		$('[name="trainingList.tSdate"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tSdate"); });
		$('[name="trainingList.tEdate"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tEdate"); });
		$('[name="trainingList.tTerm"]').each(function(index) { $(this).attr("name", "trainingList[" + index + "].tTerm"); });
		$('[name="languageList.lLanguage"]').each(function(index) { $(this).attr("name", "languageList[" + index + "].lLanguage"); });
		$('[name="languageList.lExam"]').each(function(index) { $(this).attr("name", "languageList[" + index + "].lExam"); });
		$('[name="languageList.lScore"]').each(function(index) { $(this).attr("name", "languageList[" + index + "].lScore"); });
		$('[name="languageList.lEdate"]').each(function(index) { $(this).attr("name", "languageList[" + index + "].lEdate"); });
		$('[name="languageList.lInstit"]').each(function(index) { $(this).attr("name", "languageList[" + index + "].lInstit"); });
		$('[name="certList.cCode"]').each(function(index) { $(this).attr("name", "certList[" + index + "].cCode"); });
		$('[name="certList.cName"]').each(function(index) { $(this).attr("name", "certList[" + index + "].cName"); });
		$('[name="certList.cGrade"]').each(function(index) { $(this).attr("name", "certList[" + index + "].cGrade"); });
		$('[name="certList.cEdate"]').each(function(index) { $(this).attr("name", "certList[" + index + "].cEdate"); });
		$('[name="certList.cInstit"]').each(function(index) { $(this).attr("name", "certList[" + index + "].cInstit"); });
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="careerList"]').each(function(index) {
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
		$('[name^="trainingList"]').each(function(index) {
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
		$('[name^="languageList"]').each(function(index) {
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
		$('[name^="certList"]').each(function(index) {
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}

	function recSave() {
		$("#recruitForm").beforSubmitRenameForModelAttribute();

		$.beforeSubmitAddRule();

		if(!$("#recruitForm").valid()) {
			validator.focusInvalid();
			return false;
		}

		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				var rApcode = $('#rApCode').val();
				var rIdx = $('#rIdx').val();

				// monthpicker 값 변환 (yyyy.mm -> yyyymm)
				$.each(arr, function(i) {
					if(arr[i].name.indexOf("cSmonth") > -1 || arr[i].name.indexOf("cEmonth") > -1) {
						arr[i].value = arr[i].value.replace(/\./g,'');
					}
				});

				// 경력 값 확인
				var careerLenth = $('[name*="cIncome"]').size();
				var hasCareerValues = new Array();
				for (var i = 0; i < careerLenth; i++) {
					$('input[name^="careerList['+i+']."]').each(function(index) {
						if($(this).attr('type') == 'checkbox') {
							if($(this).is(":checked")) {
								hasCareerValues[i] = true;
							}
						} else {
							if($(this).val()) {
								hasCareerValues[i] = true;
							}
						}
					});
				}

				// 경력 default value set
				$.each(hasCareerValues, function(index) {
					if(hasCareerValues[index]) {
						arr.push(
							{name : 'careerList['+index+'].rApCode', value : rApcode}
							, {name : 'careerList['+index+'].rIdx', value : rIdx}
							, {name : 'careerList['+index+'].cSeq', value : index}
						);
					}
				});

				// 교환학생/어학연수 값 확인
				var trainingLength = $('[name*="tGubunCode"]').size();
				var hasTrainingValues = new Array();
				for (var i = 0; i < trainingLength; i++) {
					$('input[name^="trainingList['+i+']."]').each(function(index) {
						if($(this).val()) {
							hasTrainingValues[i] = true;
						}
					});
				}

				// 교환학생/어학연수 default value set
				$.each(hasTrainingValues, function(index) {
					if(hasTrainingValues[index]) {
						arr.push(
							{name : 'trainingList['+index+'].rApCode', value : rApcode}
							, {name : 'trainingList['+index+'].rIdx', value : rIdx}
							, {name : 'trainingList['+index+'].tSeq', value : index}
						);
					}
				});

				// 어학 값 확인
				var languageLength = $('[name*="lLanguage"]').size();
				var hasLanguageValues = new Array();
				for (var i = 0; i < languageLength; i++) {
					$('input[name^="languageList['+i+']."]').each(function(index) {
						if($(this).val()) {
							hasLanguageValues[i] = true;
						}
					});
				}

				// 어학 default value set
				$.each(hasLanguageValues, function(index) {
					if(hasLanguageValues[index]) {
						arr.push(
							{name : 'languageList['+index+'].rApCode', value : rApcode}
							, {name : 'languageList['+index+'].rIdx', value : rIdx}
							, {name : 'languageList['+index+'].lSeq', value : index}
						);
					}
				});

				// 자격증 값 확인
				var certLength = $('[name*="cInstit"]').size();
				var hasCertValues = new Array();
				for (var i = 0; i < certLength; i++) {
					$('input[name^="certList['+i+']."]').each(function(index) {
						if($(this).val()) {
							hasCertValues[i] = true;
						}
					});
				}

				// 경력 default value set
				$.each(hasCertValues, function(index) {
					if(hasCertValues[index]) {
						arr.push(
							{name : 'certList['+index+'].rApCode', value : rApcode}
							, {name : 'certList['+index+'].rIdx', value : rIdx}
							, {name : 'certList['+index+'].cSeq', value : index}
						);
					}
				});
			},
			url: "/client/job/saveApplyCareer",
            error : function(){
            	$("#recruitForm").afterSubmitRenameForView();
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	$("#recruitForm").afterSubmitRenameForView();

            	if(data.json.result == 'success') {
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
			action = "myRecStep04";
			target="_self";
			submit();
		}
	}

	/************************************************
	* [이전]
	************************************************/
	function goPrev() {
		with (document.recruitForm) {
			action = "myRecStep02";
			target="_self";
			submit();
		}
	}

	/************************************************
	* 경력 삭제
	************************************************/
	function delCareerLine(obj) {
		var targetTR = $(obj).parent().parent();

		targetTR.next().next().next().remove();
		targetTR.next().next().remove();
		targetTR.next().remove();
		targetTR.remove();
	}

	/************************************************
	* 해당 TR 삭제
	************************************************/
	function delTRLine(obj) {
		var targetTR = $(obj).parent().parent();

		targetTR.remove();
	}

	/************************************************
	* 달력버튼 event
	************************************************/
	function showMonthpicker(obj) {
		$(obj).prev().MonthPicker("Open");
	}

	function showDatepicker(obj) {
		$(obj).prev().prev().datepicker("show");
	}

</script>

<script id="tblCareerTemplate" type="text/x-jquery-tmpl">
    <tr>
		<td><input type="text" class="width_100" name="careerList.cName" /></td>
		<td><input type="text" class="width_100" name="careerList.cPart" /></td>
		<td><input type="text" class="width_100" name="careerList.cIncome" placeholder="만원" /></td>
		<td><input type="text" class="width_100" name="careerList.cPosition" /></td>
		<td><input type="text" class="width_100" name="careerList.cWork" /></td>
		<td><input type="text" class="dateinput" name="careerList.cSmonth" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
			~
			<input type="text" class="dateinput" name="careerList.cEmonth" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a></td>
		<td rowspan="4" class="endrow"><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delCareerLine(this);">삭제</a></td>
	</tr>
	<tr>
		<td><span class="label">수행업무</span></td>
		<td colspan="5" class="text_left"><textarea class="width_100" rows="2" name="careerList.cPerform" ></textarea></td>
	</tr>
	<tr>
		<td><span class="label">근무지 유형</span></td>
		<td colspan="5" class="text_left">
			<select name="careerList.cType">
				<option value="">근무지 유형</option>
				<option value="1">일반기업</option>
				<option value="2">공공기관</option>
				<option value="3">기타</option>
			</select>
			<span class="marginleft_10 vert_middle">
				<input type="checkbox" name="careerList.cRelYn" value="1" />
				<label for="chk" class="checklabel">지원업무와 관련 있음</label>
			</span>
		</td>
	</tr>
	<tr class="endrow">
		<td><span class="label">사직사유</span></td>
		<td colspan="5" class="text_left"><input type="text" class="width_100" name="careerList.cReason" /></td>
	</tr>
</script>

<script id="tblTrainingTemplate" type="text/x-jquery-tmpl">
    <tr>
		<td>
			<select class="width_100" name="trainingList.tGubunCode">
				<option value="">구분</option>
				<option value="교환학생">교환학생</option>
				<option value="어학연수">어학연수</option>
			</select>
		</td>
		<td>
			<select class="width_100" name="trainingList.tNatCode">
				<option value="">국가</option>
				{{each(i, item) jsonNatCodes}}
					<option value="\${item.code}">\${item.expr}</option>
				{{/each}}
			</select>
		</td>
		<td><input type="text" class="width_100" name="trainingList.tInstitution" /></td>
		<td>
			<input type="text" class="dateinput" name="trainingList.tSdate" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
			~
			<input type="text" class="dateinput" name="trainingList.tEdate" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
		</td>
		<td>
			<select class="width_100" name="trainingList.tTerm">
				<option value="">학기</option>
				{{each termArr}}
					<option value="\${\$value}">\${\$value}학기</option>
				{{/each}}
			</select>
		</td>
		<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
	</tr>
</script>

<script id="tblLanguageTemplate" type="text/x-jquery-tmpl">
    <tr>
		<td>
			<select class="width_100" name="languageList.lLanguage">
				<option value="">외국어명</option>
				{{each(i, item) jsonLanguageCodes}}
					<option value="\${item.code}">\${item.name}</option>
				{{/each}}
			</select>
		</td>
		<td>
			<select class="width_100" name="languageList.lExam">
				<option value="">시험명</option>
				{{each(i, item) jsonExamCodes}}
					<option value="\${item.code}">\${item.name}</option>
				{{/each}}
			</select>
		</td>
		<td><input type="text" class="width_100" name="languageList.lScore" /></td>
		<td><input type="text" class="dateinput" name="languageList.lEdate" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>	</td>
		<td><input type="text" class="width_100" name="languageList.lInstit" /></td>
		<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
	</tr>
</script>

<script id="tblCertTemplate" type="text/x-jquery-tmpl">
    <tr>
		<td><input type="hidden" name="certList.cCode" /><input type="text" class="width_100" name="certList.cName" placeholder="검색후 선택" /></td>
		<td>
			<select class="width_100" name="certList.cGrade">
				<option value="">등급</option>
				{{each(i, item) jsonCertGradeCodes}}
					<option value="\${item.code}">\${item.name}</option>
				{{/each}}
			</select>
		</td>
		<td><input type="text" class="dateinput" name="certList.cEdate" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a></td>
		<td><input type="text" class="width_100" name="certList.cInstit" /></td>
		<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
	</tr>
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
				<form method="post" name="recruitForm" id="recruitForm">
				<input type="hidden" name="rApCode" id="rApCode" value="${recruit.rApCode}" />
				<input type="hidden" name="rIdx" id="rIdx" value="${recruit.rIdx}" />
				<input type="hidden" name="editMode" id="editMode" value="${recruit.editMode}" />
				<ul class="jobapp_tab">
					<li data-action="myRecStep01"><span>개인신상</span></li>
					<li data-action="myRecStep02"><span>학력사항</span></li>
					<li class="current"><span>경력/어학/자격</span></li>
					<li><span>자기소개서</span></li>
				</ul>

				<h2>경력사항</h2>
				<div class="btn_wrap jobapp">
					<a class="btn_c color_a additem" title="추가" id="addCareerBtn" href="#"><span>경력정보 추가</span></a>
				</div>
				<table class="jobapp_table list" id="tableCareer">
					<caption>경력사항 목록. 근무지 명, 부서명, 연봉, 직급, 담당업무, 근무기간, 수행업무, 근무지 유형, 사직사유 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				    <col style="width:;" />
				    <col style="width:;" />
				    <col style="width:;" />
				    <col style="width:260px;" />
				    <col style="width:55px;" />
				  </colgroup>
					<thead>
						<tr>
							<th>근무지 명</th>
							<th>부서명</th>
							<th>연봉</th>
							<th>직급</th>
							<th>담당업무</th>
							<th>근무기간</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="width_100" name="careerList.cName" value="${rsCareerList[0].C_NAME}" />
							</td>
							<td>
								<input type="text" class="width_100" name="careerList.cPart" value="${rsCareerList[0].C_PART}" />
							</td>
							<td>
								<input type="text" class="width_100" name="careerList.cIncome" placeholder="만원" value="${rsCareerList[0].C_INCOME}" />
							</td>
							<td>
								<input type="text" class="width_100" name="careerList.cPosition" value="${rsCareerList[0].C_POSITION}" />
							</td>
							<td>
								<input type="text" class="width_100" name="careerList.cWork" value="${rsCareerList[0].C_WORK}" />
							</td>
							<td>
								<fmt:parseDate value="${rsCareerList[0].C_SMONTH}" var="careerCsmonth" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="careerList.cSmonth" value="<fmt:formatDate value="${careerCsmonth}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsCareerList[0].C_EMONTH}" var="careerCemonth" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="careerList.cEmonth" value="<fmt:formatDate value="${careerCemonth}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
							</td>
							<td rowspan="4" class="endrow"></td>
						</tr>
						<tr>
							<td><span class="label">수행업무</span></td>
							<td colspan="5" class="text_left">
								<textarea class="width_100" rows="2" name="careerList.cPerform">${rsCareerList[0].C_PERFORM}</textarea>
							</td>
						</tr>
						<tr>
							<td><span class="label">근무지 유형</span></td>
							<td colspan="5" class="text_left">
								<select name="careerList.cType">
									<option value="">근무지 유형</option>
									<option value="1" <c:if test="${rsCareerList[0].C_TYPE eq '1'}">selected</c:if>>일반기업</option>
									<option value="2" <c:if test="${rsCareerList[0].C_TYPE eq '2'}">selected</c:if>>공공기관</option>
									<option value="3" <c:if test="${rsCareerList[0].C_TYPE eq '3'}">selected</c:if>>기타</option>
								</select>
								<span class="marginleft_10 vert_middle">
									<input type="checkbox" name="careerList.cRelYn" value="1" <c:if test="${rsCareerList[0].C_REL_YN eq '1'}">checked</c:if> />
									<label for="chk" class="checklabel">지원업무와 관련 있음</label>
								</span>
							</td>
						</tr>
						<tr class="endrow">
							<td><span class="label">사직사유</span></td>
							<td colspan="5" class="text_left">
								<input type="text" class="width_100" name="careerList.cReason" value="${rsCareerList[0].C_REASON}" />
							</td>
						</tr>
						<c:if test="${rsCareerList.size() > 1}">
							<c:forEach var="career" items="${rsCareerList}" varStatus="status">
								<c:if test="${status.index > 0}">
									<tr>
										<td>
											<input type="text" class="width_100" name="careerList.cName" value="${career.C_NAME}" />
										</td>
										<td>
											<input type="text" class="width_100" name="careerList.cPart" value="${career.C_PART}" />
										</td>
										<td>
											<input type="text" class="width_100" name="careerList.cIncome" placeholder="만원" value="${career.C_INCOME}" />
										</td>
										<td>
											<input type="text" class="width_100" name="careerList.cPosition" value="${career.C_POSITION}" />
										</td>
										<td>
											<input type="text" class="width_100" name="careerList.cWork" value="${career.C_WORK}" />
										</td>
										<td>
											<fmt:parseDate value="${career.C_SMONTH}" var="careerCsmonth" pattern="yyyyMM" />
											<input type="text" class="dateinput" name="careerList.cSmonth" value="<fmt:formatDate value="${careerCsmonth}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
											~
											<fmt:parseDate value="${career.C_EMONTH}" var="careerCemonth" pattern="yyyyMM" />
											<input type="text" class="dateinput" name="careerList.cEmonth" value="<fmt:formatDate value="${careerCemonth}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
										</td>
										<td rowspan="4" class="endrow"><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delCareerLine(this);">삭제</a></td>
									</tr>
									<tr>
										<td><span class="label">수행업무</span></td>
										<td colspan="5" class="text_left">
											<textarea class="width_100" rows="2" name="careerList.cPerform">${career.C_PERFORM}</textarea>
										</td>
									</tr>
									<tr>
										<td><span class="label">근무지 유형</span></td>
										<td colspan="5" class="text_left">
											<select name="careerList.cType">
												<option value="">근무지 유형</option>
												<option value="1" <c:if test="${career.C_TYPE eq '1'}">selected</c:if>>일반기업</option>
												<option value="2" <c:if test="${career.C_TYPE eq '2'}">selected</c:if>>공공기관</option>
												<option value="3" <c:if test="${career.C_TYPE eq '3'}">selected</c:if>>기타</option>
											</select>
											<span class="marginleft_10 vert_middle">
												<input type="checkbox" name="careerList.cRelYn" value="1" <c:if test="${career.C_REL_YN eq '1'}">checked</c:if> />
												<label for="chk" class="checklabel">지원업무와 관련 있음</label>
											</span>
										</td>
									</tr>
									<tr class="endrow">
										<td><span class="label">사직사유</span></td>
										<td colspan="5" class="text_left">
											<input type="text" class="width_100" name="careerList.cReason" value="${career.C_REASON}" />
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div class="disc jobapp">
					* 상단 우측의 ‘추가’ 버튼을 누르시면 복수의 경력정보를 입력하실 수 있습니다.
				</div>

				<h2>교환학생 및 어학연수 <span class="disc">(1년 이상 해외체류 시 작성)</span></h2>
				<div class="btn_wrap jobapp">
					<a class="btn_c color_a additem" title="추가" id="addTrainingBtn" href="#"><span>교환학생 및 어학연수 정보 추가</span></a>
				</div>
				<table class="jobapp_table list" id="tableTraining">
					<caption>교환학생 및 어학연수 목록. 구분, 국가, 기관, 기간, 총 이수학기, 삭제로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				    <col style="width:;" />
				    <col style="width:260px;" />
				    <col style="width:;" />
				    <col style="width:55px;" />
				  </colgroup>
					<thead>
						<tr>
							<th>구분</th>
							<th>국가</th>
							<th>기관</th>
							<th>기간</th>
							<th>총 이수학기</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select class="width_100" name="trainingList.tGubunCode">
									<option value="">구분</option>
									<option value="교환학생" <c:if test="${rsTrainingList[0].T_GUBUN_CODE eq '교환학생'}">selected</c:if>>교환학생</option>
									<option value="어학연수" <c:if test="${rsTrainingList[0].T_GUBUN_CODE eq '어학연수'}">selected</c:if>>어학연수</option>
								</select>
							</td>
							<td>
								<select class="width_100" name="trainingList.tNatCode">
									<option value="">국가</option>
									<c:if test="${not empty natCodes}">
										<c:forEach var="code" items="${natCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsTrainingList[0].T_NAT_CODE eq code.code}">selected</c:if>>${code.expr}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td>
								<input type="text" class="width_100" name="trainingList.tInstitution" value="${rsTrainingList[0].T_INSTITUTION}" />
							</td>
							<td>
								<fmt:parseDate value="${rsTrainingList[0].T_SDATE}" var="trainingTsdate" pattern="yyyyMMdd" />
								<input type="text" class="dateinput" name="trainingList.tSdate" value="<fmt:formatDate value="${trainingTsdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsTrainingList[0].T_EDATE}" var="trainingTedate" pattern="yyyyMMdd" />
								<input type="text" class="dateinput" name="trainingList.tEdate" value="<fmt:formatDate value="${trainingTedate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
							</td>
							<td>
								<select class="width_100" name="trainingList.tTerm">
									<option value="">학기</option>
									<c:forEach var="i" begin="1" end="8">
										<option value="${i}" <c:if test="${rsTrainingList[0].T_TERM eq i}">selected</c:if>>${i}학기</option>
									</c:forEach>
								</select>
							</td>
							<td></td>
						</tr>
						<c:if test="${rsTrainingList.size() > 1}">
							<c:forEach var="training" items="${rsTrainingList}" varStatus="status">
								<c:if test="${status.index > 0}">
									<tr>
										<td>
											<select class="width_100" name="trainingList.tGubunCode">
												<option value="">구분</option>
												<option value="교환학생" <c:if test="${training.T_GUBUN_CODE eq '교환학생'}">selected</c:if>>교환학생</option>
												<option value="어학연수" <c:if test="${training.T_GUBUN_CODE eq '어학연수'}">selected</c:if>>어학연수</option>
											</select>
										</td>
										<td>
											<select class="width_100" name="trainingList.tNatCode">
												<option value="">국가</option>
												<c:if test="${not empty natCodes}">
													<c:forEach var="code" items="${natCodes}" varStatus="status">
														<option value="${code.code}" <c:if test="${training.T_NAT_CODE eq code.code}">selected</c:if>>${code.expr}</option>
													</c:forEach>
												</c:if>
											</select>
										</td>
										<td>
											<input type="text" class="width_100" name="trainingList.tInstitution" value="${training.T_INSTITUTION}" />
										</td>
										<td>
											<fmt:parseDate value="${training.T_SDATE}" var="trainingTsdate" pattern="yyyyMMdd" />
											<input type="text" class="dateinput" name="trainingList.tSdate" value="<fmt:formatDate value="${trainingTsdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
											~
											<fmt:parseDate value="${training.T_EDATE}" var="trainingTedate" pattern="yyyyMMdd" />
											<input type="text" class="dateinput" name="trainingList.tEdate" value="<fmt:formatDate value="${trainingTedate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
										</td>
										<td>
											<select class="width_100" name="trainingList.tTerm">
												<option value="">학기</option>
												<c:forEach var="i" begin="1" end="8">
													<option value="${i}" <c:if test="${training.T_TERM eq i}">selected</c:if>>${i}학기</option>
												</c:forEach>
											</select>
										</td>
										<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div class="disc jobapp">
					* 상단 우측의 ‘추가’ 버튼을 누르시면 복수의 교환학생 및 어학연수 정보를 입력하실 수 있습니다.
				</div>

				<h2>어학능력</h2>
				<div class="btn_wrap jobapp">
					<a class="btn_c color_a additem" title="추가" id="addLanguageBtn" href="#"><span>어학능력 정보 추가</span></a>
				</div>
				<table class="jobapp_table list" id="tableLanguage">
					<caption>어학능력 목록. 외국어명, 시험명, 점수(급), 평가일, 주관처, 삭제로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:270px;" />
				    <col style="width:;" />
				    <col style="width:140px;" />
				    <col style="width:;" />
				    <col style="width:55px;" />
				  </colgroup>
					<thead>
						<tr>
							<th>외국어명</th>
							<th>시험명</th>
							<th>점수(급)</th>
							<th>평가일</th>
							<th>주관처</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select class="width_100" name="languageList.lLanguage">
									<option value="">외국어명</option>
									<c:if test="${not empty languageCodes}">
										<c:forEach var="code" items="${languageCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsLanguageList[0].L_LANGUAGE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td>
								<select class="width_100" name="languageList.lExam">
									<option value="">시험명</option>
									<c:if test="${not empty examCodes}">
										<c:forEach var="code" items="${examCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsLanguageList[0].L_EXAM eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td>
								<input type="text" class="width_100" name="languageList.lScore" value="${rsLanguageList[0].L_SCORE}" />
							</td>
							<td>
								<fmt:parseDate value="${rsLanguageList[0].L_EDATE}" var="languageEdate" pattern="yyyyMMdd" />
								<input type="text" class="dateinput" name="languageList.lEdate" value="<fmt:formatDate value="${languageEdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
							</td>
							<td>
								<input type="text" class="width_100" name="languageList.lInstit" value="${rsLanguageList[0].L_INSTIT}" />
							</td>
							<td></td>
						</tr>
						<c:if test="${rsLanguageList.size() > 1}">
							<c:forEach var="language" items="${rsLanguageList}" varStatus="status">
								<c:if test="${status.index > 0}">
									<tr>
										<td>
											<select class="width_100" name="languageList.lLanguage">
												<option value="">외국어명</option>
												<c:if test="${not empty languageCodes}">
													<c:forEach var="code" items="${languageCodes}" varStatus="status">
														<option value="${code.code}" <c:if test="${language.L_LANGUAGE eq code.code}">selected</c:if>>${code.name}</option>
													</c:forEach>
												</c:if>
											</select>
										</td>
										<td>
											<select class="width_100" name="languageList.lExam">
												<option value="">시험명</option>
												<c:if test="${not empty examCodes}">
													<c:forEach var="code" items="${examCodes}" varStatus="status">
														<option value="${code.code}" <c:if test="${language.L_EXAM eq code.code}">selected</c:if>>${code.name}</option>
													</c:forEach>
												</c:if>
											</select>
										</td>
										<td>
											<input type="text" class="width_100" name="languageList.lScore" value="${language.L_SCORE}" />
										</td>
										<td>
											<fmt:parseDate value="${language.L_EDATE}" var="languageEdate" pattern="yyyyMMdd" />
											<input type="text" class="dateinput" name="languageList.lEdate" value="<fmt:formatDate value="${languageEdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
										</td>
										<td>
											<input type="text" class="width_100" name="languageList.lInstit" value="${language.L_INSTIT}" />
										</td>
										<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div class="disc jobapp">
					* 상단 우측의 ‘추가’ 버튼을 누르시면 복수의 교환학생 및 어학연수 정보를 입력하실 수 있습니다.
				</div>

				<h2>자격사항</h2>
				<div class="btn_wrap jobapp">
					<a class="btn_c color_a additem" title="추가" id="addCertBtn" href="#"><span>자격사항 정보 추가</span></a>
				</div>
				<table class="jobapp_table list" id="tableCert">
					<caption>자격사항 목록. 자격증 명, 등급, 평가일, 발행처, 삭제로 구성.</caption>
				  <colgroup>
				    <col style="width:350px;" />
				    <col style="width:;" />
				    <col style="width:140px;" />
				    <col style="width:;" />
				    <col style="width:55px;" />
				  </colgroup>
					<thead>
						<tr>
							<th>자격증 명</th>
							<th>등급</th>
							<th>평가일</th>
							<th>발행처</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="hidden" name="certList.cCode" value="${rsCertList[0].C_CODE}" />
								<input type="text" class="width_100" name="certList.cName" value="${rsCertList[0].C_NAME}" placeholder="검색후 선택" />
							</td>
							<td>
								<select class="width_100" name="certList.cGrade">
									<option value="">등급</option>
									<c:if test="${not empty certGradeCodes}">
										<c:forEach var="code" items="${certGradeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsCertList[0].C_GRADE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td>
								<fmt:parseDate value="${rsCertList[0].C_EDATE}" var="certEdate" pattern="yyyyMMdd" />
								<input type="text" class="dateinput" name="certList.cEdate" value="<fmt:formatDate value="${certEdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
							</td>
							<td>
								<input type="text" class="width_100" name="certList.cInstit" value="${rsCertList[0].C_INSTIT}" />
							</td>
							<td></td>
						</tr>
						<c:if test="${rsCertList.size() > 1}">
							<c:forEach var="cert" items="${rsCertList}" varStatus="status">
								<c:if test="${status.index > 0}">
									<tr>
										<td>
											<input type="hidden" name="certList.cCode" value="${cert.C_CODE}" />
											<input type="text" class="width_100" name="certList.cName" value="${cert.C_NAME}" placeholder="검색후 선택" />
										</td>
										<td>
											<select class="width_100" name="certList.cGrade">
												<option value="">등급</option>
												<c:if test="${not empty certGradeCodes}">
													<c:forEach var="code" items="${certGradeCodes}" varStatus="status">
														<option value="${code.code}" <c:if test="${cert.C_GRADE eq code.code}">selected</c:if>>${code.name}</option>
													</c:forEach>
												</c:if>
											</select>
										</td>
										<td>
											<fmt:parseDate value="${cert.C_EDATE}" var="certEdate" pattern="yyyyMMdd" />
											<input type="text" class="dateinput" name="certList.cEdate" value="<fmt:formatDate value="${certEdate}" pattern="yyyy.MM.dd"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showDatepicker(this);">날짜검색</a>
										</td>
										<td>
											<input type="text" class="width_100" name="certList.cInstit" value="${cert.C_INSTIT}" />
										</td>
										<td><a href="javascript:void(0);" class="btn_del" title="삭제" onclick="delTRLine(this);">삭제</a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div class="disc jobapp">
					* 상단 우측의 ‘추가’ 버튼을 누르시면 복수의 교환학생 및 어학연수 정보를 입력하실 수 있습니다.
				</div>
				</form>

				<div class="btn_wrap center">
					<a class="btn_a color_b" title="이전" href="" onclick="goPrev();"><span>이전</span></a>
					<a class="btn_a color_a" title="다음 단계로" href="" onclick="recSave();"><span>다음 단계로</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>