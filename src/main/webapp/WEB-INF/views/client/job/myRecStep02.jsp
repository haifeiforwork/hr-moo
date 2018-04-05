<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<style>
.file { width:0; height:0 !important; }
</style>
<script type="text/javascript">
	jQuery.browser = {};
	(function () {
	    jQuery.browser.msie = false;
	    jQuery.browser.version = 0;
	    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
	        jQuery.browser.msie = true;
	        jQuery.browser.version = RegExp.$1;
	    }
	})();

	var currentYear = new Date().getFullYear();
	var validator;

	var _fileTarget;
	var _fileTxtTarget;
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
		* File
		************************************************/
		$.fileChage = function() {
			var _this = $('input:file');
			var ext = _this.val().split(".").pop().toLowerCase();
			if(ext.length > 0) {
				if($.inArray(ext, ["hwp", "xls", "xlsx", "doc", "docx", "ppt", "pptx", "pdf", "txt", "zip"]) == -1) {
					alert("문서 파일만 업로드 할 수 있습니다.");
					return;
				}
			}
			_this.val().toLowerCase();

			$("#fileFrm").ajaxForm({
				url: "/client/job/uploadFileReg",
				enctype: "multipart/form-data",
	            error : function(){
	                alert("서버 에러가 발생하였습니다.");
	                return;
	            },
	            success : function(data){
	            	if(data.json.result == 'success') {
	            		var fileInfo = data.json.list[0].file_info;
	            		_fileTarget.val(fileInfo);
	            		_fileTxtTarget.val(fileInfo.split("*")[1]);
	            	} else {
	            		alert("파일등록이 실패하였습니다.");
	            		return;
	            	}

	            	if ($.browser.msie) {
	            		_this.replaceWith(_this.clone(true));
	            		_this.change(function() {
	            			$.fileChage();
	            		});
	            	} else {
	            		_this.val("");
	            	}
	            }
	        });

			$("#fileFrm").submit();
		}

		$('#btn-file1-upload').click(function(e) {
			e.preventDefault();
			_fileTarget = $('#gradeList2sThesis1File');
			_fileTxtTarget = $('#gradeList2sThesis1FileTxt');
			$('input:file').click();
		});

		$('#btn-file2-upload').click(function(e) {
			e.preventDefault();
			_fileTarget = $('#gradeList2sThesis2File');
			_fileTxtTarget = $('#gradeList2sThesis2FileTxt');
			$('input:file').click();
		});

		$('input:file').change(function(e) {
			$.fileChage();
		});
		/************************************************
		* END - File
		************************************************/

		/************************************************
		* calendar
		************************************************/
		$('.dateinput').on('keyup', function(event) {
			event.preventDefault();
			$(this).val('');
		});

		$('#schoolList0sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList0sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList1sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList1sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList2sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList2sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList3sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList3sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList4sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList4sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList5sEntMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		$('#schoolList5sGraMonth').MonthPicker({Button: false, MonthFormat: 'yy.mm'});
		/************************************************
		* END - calendar
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
			number:"숫자만 입력할 수 있습니다."
		});

		jQuery.validator.addMethod('floatCheck', function (value) {
	        return /^\d*(\.\d{0,2})?$/.test(value);
	    }, "소수점 둘쨰자리까지만 입력할 수 있습니다.");

		validator = $("#recruitForm").validate({
			rules: {
				"gradeList[0].sScore11": {number : true, floatCheck : true}
				,"gradeList[0].sScore12": {number : true, floatCheck : true}
				,"gradeList[0].sScoreAvg": {number : true, floatCheck : true}
				,"gradeList[0].sScoreFull": {number : true, floatCheck : true}
				,"gradeList[0].sScore21": {number : true, floatCheck : true}
				,"gradeList[0].sScore22": {number : true, floatCheck : true}
				,"gradeList[0].sScore31": {number : true, floatCheck : true}
				,"gradeList[0].sScore32": {number : true, floatCheck : true}
				,"gradeList[1].sScore11": {number : true, floatCheck : true}
				,"gradeList[1].sScore12": {number : true, floatCheck : true}
				,"gradeList[1].sScoreAvg": {number : true, floatCheck : true}
				,"gradeList[1].sScoreFull": {number : true, floatCheck : true}
				,"gradeList[1].sScore21": {number : true, floatCheck : true}
				,"gradeList[1].sScore22": {number : true, floatCheck : true}
				,"gradeList[1].sScore31": {number : true, floatCheck : true}
				,"gradeList[1].sScore32": {number : true, floatCheck : true}
				,"gradeList[1].sScore41": {number : true, floatCheck : true}
				,"gradeList[1].sScore42": {number : true, floatCheck : true}
				,"gradeList[2].sScore11": {number : true, floatCheck : true}
				,"gradeList[2].sScore12": {number : true, floatCheck : true}
				,"gradeList[2].sScoreAvg": {number : true, floatCheck : true}
				,"gradeList[2].sScoreFull": {number : true, floatCheck : true}
				,"gradeList[2].sScore21": {number : true, floatCheck : true}
				,"gradeList[2].sScore22": {number : true, floatCheck : true}
			}
		});
		/************************************************
		* END - form validation
		************************************************/

		/************************************************
		* School search autocomplete
		************************************************/
		$.fn.autoSchoolSearch = function(gubun, uType) {
			var _this = $(this);

			this.autocomplete({
				source : function(request, response) {
					$.ajax({
						type : "POST",
						url : "/client/job/searchSchool",
						global: false,
						dataType : "json",
						data : {
							gubun : gubun,
							uType : uType,
							searchSchulNm : request.term
						},
						beforeSend : function(arr) {
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
							var schools = $.parseJSON(data.result);
							response(
	                            $.map(schools.dataSearch.content, function(item) {
                                	if(gubun == 'high_list') {
	                                	return {
		                                    label: item.schoolName + " - " + item.region,
		                                    value: item.schoolName
	                                	}
	                                } else {
	                                	return {
		                                	label: item.schoolName + "(" + item.campusName + ")",
		                                    value: item.schoolName + "(" + item.campusName + ")"
	                                	}
	                                }
	                            })
	                        );
						}
					});
				},
				minLength : 2,
				select : function(event, ui) {
					$(this).val(ui.item.value);
					$(this).blur();
				},
				focus : function(event, ui) {
					event.preventDefault();
				},
				change: function (event, ui) {
	                if(!ui.item){
	                    $(this).val("");
	                }
	            }
			});
	    };

	    $("#schoolList0sName").autoSchoolSearch('high_list');
	    $("#schoolList1sName").autoSchoolSearch('univ_list', '100322');
	    $("#schoolList2sName").autoSchoolSearch('univ_list', '100323');
	    $("#schoolList3sName").autoSchoolSearch('univ_list', '100323');
	    $("#schoolList4sName").autoSchoolSearch('univ_list', '100323');
	    $("#schoolList5sName").autoSchoolSearch('univ_list', '100323');
		/************************************************
		* END - School autocomplete
		************************************************/

	});

	/************************************************
	* [학력사항 저장]
	************************************************/
	function recSave() {
		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				// monthpicker 값 변환 (yyyy.mm -> yyyymm)
				$.each(arr, function(i) {
					if(arr[i].name.indexOf("sEntMonth") > -1 || arr[i].name.indexOf("sGraMonth") > -1) {
						arr[i].value = arr[i].value.replace(/\./g,'');
					}
				});

				if(!$("#recruitForm").valid()) {
					validator.focusInvalid();
					return;
				}

				// 학력 값 확인
				var hasSchoolValues = [false, false, false, false, false, false];
				for (var i = 0; i < 6; i++) {
					$('input[name^="schoolList['+i+']."]').each(function(index) {
						if($(this).val()) {
							hasSchoolValues[i] = true;
						}
					});
				}

				// SCHOOL default value set
				var schoolTypes = ['19001', '19002', '19003', '19003', '19003', '19003'];
				$.each(hasSchoolValues, function(index) {
					if(hasSchoolValues[index]) {
						arr.push(
							{name : 'schoolList['+index+'].rApCode', value : $('#rApCode').val()}
							, {name : 'schoolList['+index+'].rIdx', value : $('#rIdx').val()}
							, {name : 'schoolList['+index+'].sIdx', value : index}
							, {name : 'schoolList['+index+'].sTypeCode', value : schoolTypes[index]}
						);
					}
				});

				// 성적 값 확인
				var hasGradeValues = [false, false, false];
				for (var i = 0; i < 3; i++) {
					$('input[name^="gradeList['+i+']."]').each(function(index) {
						if($(this).val()) {
							hasGradeValues[i] = true;
						}
					});
				}

				// GRADE default value set
				schoolTypes = ['19001', '19003', '19003'];
				$.each(hasGradeValues, function(index) {
					if(hasGradeValues[index]) {
						arr.push(
							{name : 'gradeList['+index+'].rApCode', value : $('#rApCode').val()}
							, {name : 'gradeList['+index+'].rIdx', value : $('#rIdx').val()}
							, {name : 'gradeList['+index+'].sIdx', value : index}
							, {name : 'gradeList['+index+'].sTypeCode', value : schoolTypes[index]}
						);
					}
				});
			},
			url: "/client/job/saveApplyEdu",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
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
			action = "myRecStep03";
			target="_self";
			submit();
		}
	}

	/************************************************
	* [이전]
	************************************************/
	function goPrev() {
		with (document.recruitForm) {
			action = "myRecStep01";
			target="_self";
			submit();
		}
	}

	// 달력 버튼 event
	function showMonthpicker(obj) {
		$(obj).prev().MonthPicker("Open");
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
				    <input type="file" name="file" id="file" class="file" />
				    <input type="hidden" name="file_dir" value="job" />
				    <input type="hidden" name="exts" value="hwp|xls|xlsx|doc|docx|ppt|pptx|pdf|txt|zip" />
				</form>
				<form method="post" name="recruitForm" id="recruitForm">
				<input type="hidden" name="rApCode" id="rApCode" value="${recruit.rApCode}" />
				<input type="hidden" name="rIdx" id="rIdx" value="${recruit.rIdx}" />
				<input type="hidden" name="editMode" id="editMode" value="${recruit.editMode}" />
				<ul class="jobapp_tab">
					<li data-action="myRecStep01"><span>개인신상</span></li>
					<li class="current"><span>학력사항</span></li>
					<li><span>경력/어학/자격</span></li>
					<li><span>자기소개서</span></li>
				</ul>

				<h2>학력사항</h2>
				<table class="jobapp_table">
					<caption>학력사항 목록. 고등학교, (전문)대학, 대학교, 대학교(편입 시), 석사, 박사로 구성.</caption>
					<colgroup>
						<col style="width:130px;" />
						<col style="width:;" />
						<col style="width:;" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="2">고등학교</th>
							<td>
								<input type="text" name="schoolList[0].sName" id="schoolList0sName" value="${rsSchool0.S_NAME}" placeholder="검색후 선택" />
								고등학교
							</td>
							<td class="text_right">
								<select name="schoolList[0].sMajorGroup" id="schoolList[0].sMajorGroup">
									<option value="">계열</option>
									<c:if test="${not empty hMajorGroupCodes}">
										<c:forEach var="code" items="${hMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool0.S_MAJOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[0].sMajor" id="schoolList[0].sMajor" value="${rsSchool0.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool0.S_ENT_MONTH}" var="ent0Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[0].sEntMonth" id="schoolList0sEntMonth" value="<fmt:formatDate value="${ent0Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool0.S_GRA_MONTH}" var="gra0Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[0].sGraMonth" id="schoolList0sGraMonth" value="<fmt:formatDate value="${gra0Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[0].sGraType" id="schoolList[0].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool0.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<select name="schoolList[0].sDnCode" id="schoolList[0].sDnCode">
									<option value="">주/야</option>
									<c:if test="${not empty schoolDnCodes}">
										<c:forEach var="code" items="${schoolDnCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool0.S_DN_CODE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="2">(전문)대학</th>
							<td>
								<input type="text" name="schoolList[1].sName" id="schoolList1sName" value="${rsSchool1.S_NAME}" placeholder="검색후 선택" />
								전문대학
							</td>
							<td class="text_right">
								<select disabled>
									<option value="">계열</option>
								</select>
								<input type="text" name="schoolList[1].sMajor" id="schoolList[1].sMajor" value="${rsSchool1.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool1.S_ENT_MONTH}" var="ent1Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[1].sEntMonth" id="schoolList1sEntMonth" value="<fmt:formatDate value="${ent1Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool1.S_GRA_MONTH}" var="gra1Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[1].sGraMonth" id="schoolList1sGraMonth" value="<fmt:formatDate value="${gra1Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[1].sGraType" id="schoolList[1].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool1.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<select name="schoolList[1].sDnCode" id="schoolList[1].sDnCode">
									<option value="">주/야</option>
									<c:if test="${not empty schoolDnCodes}">
										<c:forEach var="code" items="${schoolDnCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool1.S_DN_CODE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="3">대학교</th>
							<td>
								<input type="text" name="schoolList[2].sName" id="schoolList2sName" value="${rsSchool2.S_NAME}" placeholder="검색후 선택" />
								대학교
							</td>
							<td class="text_right">
								<span class="label">주전공</span>
								<select name="schoolList[2].sMajorGroup" id="schoolList[2].sMajorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool2.S_MAJOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[2].sMajor" id="schoolList[2].sMajor" value="${rsSchool2.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">부전공</span>
								<select name="schoolList[2].sMinorGroup" id="schoolList[2].sMinorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool2.S_MINOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[2].sMinor" id="schoolList[2].sMinor" value="${rsSchool2.S_MINOR}" placeholder="과" />
							</td>
							<td class="text_right">
								<span class="label">복수전공</span>
								<select name="schoolList[2].sDualGroup" id="schoolList[2].sDualGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool2.S_DUAL_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[2].sDual" id="schoolList[2].sDual" value="${rsSchool2.S_DUAL}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool2.S_ENT_MONTH}" var="ent2Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[2].sEntMonth" id="schoolList2sEntMonth" value="<fmt:formatDate value="${ent2Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool2.S_GRA_MONTH}" var="gra2Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[2].sGraMonth" id="schoolList2sGraMonth" value="<fmt:formatDate value="${gra2Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[2].sGraType" id="schoolList[2].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool2.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<select name="schoolList[2].sDnCode" id="schoolList[2].sDnCode">
									<option value="">주/야</option>
									<c:if test="${not empty schoolDnCodes}">
										<c:forEach var="code" items="${schoolDnCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool2.S_DN_CODE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="3">대학교(편입 시)</th>
							<td>
								<input type="text" name="schoolList[3].sName" id="schoolList3sName" value="${rsSchool3.S_NAME}" placeholder="검색후 선택" />
								대학교
							</td>
							<td class="text_right">
								<span class="label">주전공</span>
								<select name="schoolList[3].sMajorGroup" id="schoolList[3].sMajorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool3.S_MAJOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[3].sMajor" id="schoolList[3].sMajor" value="${rsSchool3.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">부전공</span>
								<select name="schoolList[3].sMinorGroup" id="schoolList[3].sMinorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool3.S_MINOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[3].sMinor" id="schoolList[3].sMinor" value="${rsSchool3.S_MINOR}" placeholder="과" />
							</td>
							<td class="text_right">
								<span class="label">복수전공</span>
								<select name="schoolList[3].sDualGroup" id="schoolList[3].sDualGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool3.S_DUAL_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[3].sDual" id="schoolList[3].sDual" value="${rsSchool3.S_DUAL}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool3.S_ENT_MONTH}" var="ent3Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[3].sEntMonth" id="schoolList3sEntMonth" value="<fmt:formatDate value="${ent3Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool3.S_GRA_MONTH}" var="gra3Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[3].sGraMonth" id="schoolList3sGraMonth" value="<fmt:formatDate value="${gra3Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[3].sGraType" id="schoolList[3].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool3.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<select name="schoolList[3].sDnCode" id="schoolList[3].sDnCode">
									<option value="">주/야</option>
									<c:if test="${not empty schoolDnCodes}">
										<c:forEach var="code" items="${schoolDnCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool3.S_DN_CODE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th rowspan="2">석사</th>
							<td>
								<input type="text" name="schoolList[4].sName" id="schoolList4sName" value="${rsSchool4.S_NAME}" placeholder="검색후 선택" />
								대학교
							</td>
							<td class="text_right">
								<select name="schoolList[4].sMajorGroup" id="schoolList[4].sMajorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool4.S_MAJOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[4].sMajor" id="schoolList[4].sMajor" value="${rsSchool4.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool4.S_ENT_MONTH}" var="ent4Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[4].sEntMonth" id="schoolList4sEntMonth" value="<fmt:formatDate value="${ent4Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool4.S_GRA_MONTH}" var="gra4Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[4].sGraMonth" id="schoolList4sGraMonth" value="<fmt:formatDate value="${gra4Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[4].sGraType" id="schoolList[4].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool4.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<span class="label">세부전공</span>
								<input type="text" name="schoolList[4].sMajorDetail" id="schoolList[4].sMajorDetail" value="${rsSchool4.S_MAJOR_DETAIL}" />
							</td>
						</tr>
						<tr>
							<th rowspan="2" class="endrow">박사</th>
							<td>
								<input type="text" name="schoolList[5].sName" id="schoolList5sName" value="${rsSchool5.S_NAME}" placeholder="검색후 선택" />
								대학교
							</td>
							<td class="text_right">
								<select name="schoolList[5].sMajorGroup" id="schoolList[5].sMajorGroup">
									<option value="">계열</option>
									<c:if test="${not empty uMajorGroupCodes}">
										<c:forEach var="code" items="${uMajorGroupCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool5.S_MAJOR_GROUP eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<input type="text" name="schoolList[5].sMajor" id="schoolList[5].sMajor" value="${rsSchool5.S_MAJOR}" placeholder="과" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="label">기간</span>
								<fmt:parseDate value="${rsSchool5.S_ENT_MONTH}" var="ent5Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[5].sEntMonth" id="schoolList5sEntMonth" value="<fmt:formatDate value="${ent5Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								~
								<fmt:parseDate value="${rsSchool5.S_GRA_MONTH}" var="gra5Month" pattern="yyyyMM" />
								<input type="text" class="dateinput" name="schoolList[5].sGraMonth" id="schoolList5sGraMonth" value="<fmt:formatDate value="${gra5Month}" pattern="yyyy.MM"/>" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색" onclick="showMonthpicker(this);">날짜검색</a>
								<select name="schoolList[5].sGraType" id="schoolList[5].sGraType">
									<option value="">졸업구분</option>
									<c:if test="${not empty gradeTypeCodes}">
										<c:forEach var="code" items="${gradeTypeCodes}" varStatus="status">
											<option value="${code.code}" <c:if test="${rsSchool5.S_GRA_TYPE eq code.code}">selected</c:if>>${code.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<td class="text_right">
								<span class="label">세부전공</span>
								<input type="text" name="schoolList[5].sMajorDetail" id="schoolList[5].sMajorDetail" value="${rsSchool5.S_MAJOR_DETAIL}" />
							</td>
						</tr>
					</tbody>
				</table>

				<h2>성적</h2>
				<table class="jobapp_table list">
					<caption>성적 목록. 고등학교, (전문)대학, 대학교, 대학교(편입 시), 석사, 박사로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:120px;" />
				    <col style="width:;" />
				    <col style="width:;" />
				    <col style="width:;" />
				  </colgroup>
					<thead>
						<tr>
							<th colspan="2"></th>
							<th>1학기</th>
							<th>2학기</th>
							<th>평점</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th rowspan="3">고등학교</th>
							<td><span class="label">1학년</span></td>
							<td>
								<input type="text" name="gradeList[0].sScore11" id="gradeList0sScore11" value="${rsGrade0.S_SCORE_11}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[0].sScore12" id="gradeList0sScore12" value="${rsGrade0.S_SCORE_12}" class="width_100"/>
							</td>
							<td rowspan="3">
								<input type="text" name="gradeList[0].sScoreAvg" id="gradeList0sScoreAvg" value="${rsGrade0.S_SCORE_AVG}" style="width:80px;"/>
								/
								<input type="text" name="gradeList[0].sScoreFull" id="gradeList0sScoreFull" value="${rsGrade0.S_SCORE_FULL}" style="width:80px;" placeholder="만점"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">2학년</span></td>
							<td>
								<input type="text" name="gradeList[0].sScore21" id="gradeList0sScore21" value="${rsGrade0.S_SCORE_21}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[0].sScore22" id="gradeList0sScore22" value="${rsGrade0.S_SCORE_22}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">3학년</span></td>
							<td>
								<input type="text" name="gradeList[0].sScore31" id="gradeList0sScore31" value="${rsGrade0.S_SCORE_31}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[0].sScore32" id="gradeList0sScore32" value="${rsGrade0.S_SCORE_32}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<th rowspan="4">대학/대학교<br />(편입추가)</th>
							<td><span class="label">1학년</span></td>
							<td>
								<input type="text" name="gradeList[1].sScore11" id="gradeList1sScore11" value="${rsGrade1.S_SCORE_11}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[1].sScore12" id="gradeList1sScore12" value="${rsGrade1.S_SCORE_12}" class="width_100"/>
							</td>
							<td rowspan="4">
								<input type="text" name="gradeList[1].sScoreAvg" id="gradeList1sScoreAvg" value="${rsGrade1.S_SCORE_AVG}" style="width:80px;"/>
								/
								<input type="text" name="gradeList[1].sScoreFull" id="gradeList1sScoreFull" value="${rsGrade1.S_SCORE_FULL}" style="width:80px;" placeholder="만점"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">2학년</span></td>
							<td>
								<input type="text" name="gradeList[1].sScore21" id="gradeList1sScore21" value="${rsGrade1.S_SCORE_21}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[1].sScore22" id="gradeList1sScore22" value="${rsGrade1.S_SCORE_22}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">3학년</span></td>
							<td>
								<input type="text" name="gradeList[1].sScore31" id="gradeList1sScore31" value="${rsGrade1.S_SCORE_31}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[1].sScore32" id="gradeList1sScore32" value="${rsGrade1.S_SCORE_32}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">4학년</span></td>
							<td>
								<input type="text" name="gradeList[1].sScore41" id="gradeList1sScore41" value="${rsGrade1.S_SCORE_41}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[1].sScore42" id="gradeList1sScore42" value="${rsGrade1.S_SCORE_42}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<th rowspan="2">석사</th>
							<td><span class="label">1학년</span></td>
							<td>
								<input type="text" name="gradeList[2].sScore11" id="gradeList2sScore11" value="${rsGrade2.S_SCORE_11}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[2].sScore12" id="gradeList2sScore12" value="${rsGrade2.S_SCORE_21}" class="width_100"/>
							</td>
							<td rowspan="2">
								<input type="text" name="gradeList[2].sScoreAvg" id="gradeList2sScoreAvg" value="${rsGrade2.S_SCORE_AVG}" style="width:80px;"/>
								/
								<input type="text" name="gradeList[2].sScoreFull" id="gradeList2sScoreFull" value="${rsGrade2.S_SCORE_FULL}" style="width:80px;" placeholder="만점"/>
							</td>
						</tr>
						<tr>
							<td><span class="label">2학년</span></td>
							<td>
								<input type="text" name="gradeList[2].sScore21" id="gradeList2sScore21" value="${rsGrade2.S_SCORE_21}" class="width_100"/>
							</td>
							<td>
								<input type="text" name="gradeList[2].sScore22" id="gradeList2sScore22" value="${rsGrade2.S_SCORE_22}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<th rowspan="2">석사논문</th>
							<td><span class="label">학위논문제목</span></td>
							<td colspan="3">
								<input type="text" name="gradeList[2].sThesis1" id="gradeList2sThesis1" value="${rsGrade2.S_THESIS1}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="text_left">
								<c:set var="sThesis1File" value="${fn:split(rsGrade2.S_THESIS1_FILE,'*')}" />
								<input type="hidden" name="gradeList[2].sThesis1File" id="gradeList2sThesis1File" value="${rsGrade2.S_THESIS1_FILE}" />
								<input type="text" name="gradeList[2].sThesis1FileTxt" id="gradeList2sThesis1FileTxt" value="${sThesis1File[1]}" class="width_60" />
								<a class="btn_b color_b" id="btn-file1-upload" title="첨부파일" href="javascript:void(0);"><span>첨부파일</span></a>
								<span class="disc">학위논문 요약 첨부(A4 10장내 요약)</span>
							</td>
						</tr>
						<tr>
							<th rowspan="2" class="endrow">박사논문</th>
							<td><span class="label">학위논문제목</span></td>
							<td colspan="3">
								<input type="text" name="gradeList[2].sThesis2" id="gradeList[2].sThesis2" value="${rsGrade2.S_THESIS2}" class="width_100"/>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="text_left">
								<c:set var="sThesis2File" value="${fn:split(rsGrade2.S_THESIS2_FILE,'*')}" />
								<input type="hidden" name="gradeList[2].sThesis2File" id="gradeList2sThesis2File" value="${rsGrade2.S_THESIS2_FILE}" />
								<input type="text" name="gradeList[2].sThesis2FileTxt" id="gradeList2sThesis2FileTxt" value="${sThesis2File[1]}" class="width_60" />
								<a class="btn_b color_b" id="btn-file2-upload" title="첨부파일" href=""><span>첨부파일</span></a>
								<span class="disc">학위논문 요약 첨부(A4 10장내 요약)</span>
							</td>
						</tr>
					</tbody>
				</table>
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