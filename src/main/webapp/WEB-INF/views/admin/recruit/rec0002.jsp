<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<style>
	#file {width:0; height:0 !important;}
</style>
<script type="text/javascript">
var currentYear = new Date().getFullYear();
var validator;

	$(document).ready(function() {
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
	* 모집부분 추가 버튼
	************************************************/
	function addCareerTemplate(){
		
		$('#tblCareerTemplate').tmpl().appendTo('#tableCareer');
	}
	
	/************************************************
	* 모집부분 삭제
	************************************************/
	function deleteCareer(obj){
		$(obj).closest('tr').remove();
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
	        return (!isNullStr(value));
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));
		
		
		validator = $("#recruitForm").validate({
			ignore : "",
			rules: {
				    rTitle:     {required : ['제목']}
				  , rGubun:     {selectcheck : ['채용구분']}
				  , rSdate:     {required : ['시작일자']} 
				  , rSdateTime: {selectcheck : ['시작시간']}
				  , rEdate:     {required : ['종료일자']}
				  , rEdateTime: {selectcheck : ['종료시간']}
				  , rSnum:      {required : ['수험번호'], number: ['수험번호']}
				  //, rContent:   {required : ['내용']}
				  
			}
		});
	}
	
	/************************************************
	* 공고 저장
	************************************************/
	// Submit전 객체의 name 속성을 MODEL list 형태로 변환
	$.fn.beforSubmitRenameForModelAttribute = function() {
		$('[name="careerList.rCode1"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].rCode1"); });
		$('[name="careerList.rCode2"]').each(function(index) { $(this).attr("name", "careerList[" + index + "].rCode2"); });
		$('#tableCareer tbody tr').each(function(index) { 
			$(this).find('[name="careerList.rCode3"]').attr("name", "careerList[" + index + "].rCode3"); }
		);
	}

	// Submit 후에 객체의 name 속성을 원래대로 변환
	$.fn.afterSubmitRenameForView = function() {
		$('[name^="careerList"]').each(function(index) { 
			var orgName = $(this).attr("name");
			$(this).attr("name", orgName.replace(/\[[0-9]\]/g, ''));
		});
	}
	
	function preSave(){
		fn_smartEditorUpdateContentsField();
		if( fileExistCheck() ) {
			fn_fileUpload( "document.recruitForm", "fileinfo", "recSave()", "N");
		}else{
			recSave();
		} 
	}
	
	// 전체 필드에 rule 추가
	$.beforeSubmitAddRule = function() {
		$('[name*=".rCode3"]').each(function() {
			$(this).rules("add", {selectcheck : ['지역']})
		});
		
	}
	
	function recSave() {
		
		
		
		$("#recruitForm").beforSubmitRenameForModelAttribute();
		$.beforeSubmitAddRule();
		var rUrl = "";
		<c:if test="${procType eq 'new' }">
		rUrl = "/admin/recruit/insertRec0002"
		</c:if>
		<c:if test="${procType eq 'mod' }">
		rUrl = "/admin/recruit/updateRec0002"
		</c:if>
		
		
		
		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				if(!$("#recruitForm").valid()) {
					validator.focusInvalid();
					return;
				}
				
			},
			type: "POST",
			url: rUrl,
            error : function(){
            	$("#recruitForm").afterSubmitRenameForView();
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	$("#recruitForm").afterSubmitRenameForView();
            	
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
		
		$("#recruitForm").submit();
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
		<c:import url="/inc/adm_header.jsp?m=1&s=2"></c:import>
			<div class="contents_wrap lnb_open">
				<!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">공고관리</span>
					<ul class="location">
						<li><a href="">Home</a></li>
						<li><a href="">공고관리</a></li>
						<li class="currentpage"><a href="/admin/recruit/rec0001">채용공고</a></li>
					</ul>
				</div>
				<div class="contetns">
					<form name="search_form" id="search_form" method="post" action="/admin/recruit/rec0001">
						<input type="hidden" name="pageNo"     id="pageNo" value="${vo.pageNo }">
						<input type="hidden" name="gubunType1" value="${vo.gubunType1 }">
						<input type="hidden" name="searchType" value="${vo.searchType }">
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>">
					</form>
					<form method="post" name="recruitForm" id="recruitForm">
						<input type="hidden" name="idx" value="<c:out value="${rs.IDX }"/>"> 
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>"> 
						<input type="hidden" name="fileinfo"> 
						<input type="hidden" name="delfileinfo">	
						<table class="contents_table admin list_table">
							<caption>채용공고 목록. No, 구분, 제목, 채용일정, 채용상태, 작성자, 작성일, 조회수,게시여부, 삭제로 구성.</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width:;" />
								<col style="width: 120px;" />
								<col style="width:;" />
							</colgroup>
							<tbody>
								<tr>
									<th>제목</th>
									<td colspan="3">
										<input type="text" class="width_70 marginright_10" name="rTitle" value="${rs.R_TITLE     }" />
										<input type="checkbox" id="rTopYn" name="rTopYn" value="Y" <c:if test="${rs.R_TOP_YN eq 'Y'}">checked="checked"</c:if>>
										<label for="rTopYn" class="checklabel">최상위 노출</label>
										<input type="checkbox" id="rShowYn" name="rShowYn" value="Y" <c:if test="${rs.R_SHOW_YN eq 'Y'}">checked="checked"</c:if>>
										<label for="rShowYn" class="checklabel">게시여부</label>
									</td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>
										${sessionScope.user.USER_NAME}
										<!-- <input type="text" readonly="readonly"/> -->
									</td>
									<th>작성일</th>
									<td id="regDt">
										<c:choose>
											<c:when test="${procType eq 'new' }">
												<jsp:useBean id="toDay" class="java.util.Date" />
												<fmt:formatDate value="${toDay}" pattern="yyyy.MM.dd" />
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${rs.REG_DT}" pattern="yyyy.MM.dd" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>채용구분</th>
									<td>
										<select name="rGubun">
											<option value="" >전체</option>
											<c:forEach items="${code.code40 }" var="cd" varStatus="">
												<option value="${cd.code }" <c:if test="${rs.R_GUBUN eq cd.code }">selected="selected"</c:if>>${cd.name }</option>	
											</c:forEach>
										</select>
									</td>
									<th>조회수</th>
									<td>0</td>
								</tr>
								<tr>
									<th>채용일정</th>
									<td colspan="3">
										<input type="text" name="rSdate" id="rSdate" class="dateinput" value="${rs.R_SDATE     }"  /><a class="dateinput_btn" href="javascript:void(0);" onclick="javascript:showDatepicker(this);" title="날짜검색">날짜검색</a>
										<select name="rSdateTime">
											<c:forEach var="i" begin="0" end="23">
												<c:set var="hourOption" value="${i}" />
												<option value="<fmt:formatNumber value="${hourOption}" pattern="00" />"  
														<c:if test="${rs.R_SDATE_TIME  eq hourOption}">selected</c:if>>
														<fmt:formatNumber value="${hourOption}" pattern="00" />
												</option>
											</c:forEach>
										</select> 시 
									  ~ <input type="text" name="rEdate" id="rEdate" class="dateinput" value="${rs.R_EDATE     }" /><a class="dateinput_btn"  href="javascript:void(0);" onclick="javascript:showDatepicker(this);" title="날짜검색">날짜검색</a>
									   <select name="rEdateTime">
										    <c:forEach var="i" begin="0" end="23">
												<c:set var="hourOption" value="${i}" />
												<option value="<fmt:formatNumber value="${hourOption}" pattern="00" />"  
														<c:if test="${rs.R_EDATE_TIEM eq hourOption}">selected</c:if>>
														<fmt:formatNumber value="${hourOption}" pattern="00" />
												</option>
											</c:forEach>
										</select> 시
									</td>
								</tr>
								<tr>
									<th>채용방법</th>
									<td>
										
										<input type="radio" id="rOnlineY" name="rOnlineYn" value="Y" <c:if test="${rs.R_ONLINE_YN eq 'Y' or empty rs.R_ONLINE_YN }">checked="checked"</c:if>><label for="rOnlineY" class="radiolabel">온라인</label>
										<input type="radio" id="rOnlineN" name="rOnlineYn" value="N" <c:if test="${rs.R_ONLINE_YN eq 'N'}">checked="checked"</c:if>><label for="rOnlineN" class="radiolabel">오프라인</label>
									</td>
									<th>수험번호</th>
									<td><input type="text" name="rSnum" value="${rs.R_SNUM      }"/></td>
								</tr>
								<tr>
								
								
									<th>모집부문 <a href="javascript:void(0);" onclick="javascript:addCareerTemplate();" class="btn_add" style="margin-left: 2px;" title="추가">추가</a></th>
									<td colspan="3" class="intable">
										<table class="list_table admin intable" id="tableCareer">
											<caption>모집구분 목록. 직군, 직무, 지역, 삭제로 구성.</caption>
											<colgroup>
												<col style="width: 170px;" />
												<col style="width: 170px;" />
												<col style="width:;" />
												<col style="width: 50px;" />
											</colgroup>
											<thead>
												<tr>
													<th>직군</th>
													<th>직무</th>
													<th>지역</th>
													<th>삭제</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${procType eq 'new' }">
														<tr>
															<td>
																<select class="width_100" name="careerList.rCode1">
																	<c:forEach items="${code.code03 }" var="cd" varStatus="idx">
																		<option value="${cd.code }" ${cl.R_CODE1 eq cd.code ? 'selected="selected"':'' } >${cd.name }</option>	
																	</c:forEach>
																</select>
															</td>
															<td>
																<select class="width_100" name="careerList.rCode2">
																	<c:forEach items="${code.code04 }" var="cd" varStatus="idx">
																		<option value="${cd.code }" ${cl.R_CODE2 eq cd.code ? 'selected="selected"':'' }>${cd.name }</option>	
																	</c:forEach>
																</select>
															</td>
															<td>
																<c:forEach items="${code.code05 }" var="cd" varStatus="idx">
																	<input type="checkbox" id="" name="careerList.rCode3" ${checked }  value="${cd.code }" ><label for="" class="checklabel marginright_10">${cd.name }</label>
																</c:forEach>
															</td>
															<td class="text_center"></td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${rs.careerList}" var="cl" varStatus="i">
															<tr>
																<td>
																	<select class="width_100" name="careerList.rCode1">
																		<c:forEach items="${code.code03 }" var="cd" varStatus="idx">
																			<option value="${cd.code }" ${cl.R_CODE1 eq cd.code ? 'selected="selected"':'' } >${cd.name }</option>	
																		</c:forEach>
																	</select>
																</td>
																<td>
																	<select class="width_100" name="careerList.rCode2">
																		<c:forEach items="${code.code04 }" var="cd" varStatus="idx">
																			<option value="${cd.code }" ${cl.R_CODE2 eq cd.code ? 'selected="selected"':'' }>${cd.name }</option>	
																		</c:forEach>
																	</select>
																</td>
																<td>
																	<c:set var="rCode3" value="${fn:split(cl.R_CODE3,'|')}" />
																	<c:set var="cFlag" value="0" />
																	<c:forEach items="${code.code05 }" var="cd" varStatus="idx">
																		<c:forEach var="r" items="${rCode3 }">
																			<c:if test="${r eq cd.code }">
																				<c:set var="cFlag" value="1" />	
																			</c:if>
																		</c:forEach>
																		<input type="checkbox" id="" name="careerList.rCode3" ${cFlag eq '1' ?'checked="checked"' : '' }  value="${cd.code }" ><label for="" class="checklabel marginright_10">${cd.name }</label>
																		<c:set var="cFlag" value="0" />	
																	</c:forEach>
																</td>
																<td class="text_center"></td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="3">
										<textarea id="textarea_contents" name="rContent" style="width: 680px; height: 300px;"><c:out value="${rs.R_CONTENT   }" /></textarea>
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td colspan="3">
										${fileUpload }
										<%--
										<input type="hidden" name="gradeList[2].sThesis1File" id="gradeList2sThesis1File" value="${rsGrade2.S_THESIS1_FILE}" />
										<input type="text" name="gradeList[2].sThesis1FileTxt" id="gradeList2sThesis1FileTxt" value="${sThesis1File[1]}" class="width_60" />
										<a class="btn_b color_b marginright_0" id="btn-file1-upload" title="첨부파일" href="javascript:void(0);"><span>첨부파일</span></a>
										<a class="btn_b color_b" title="첨부파일" href=""><span>파일삭제</span></a>
										<span class="disc vert_middle">* 첨부파일 최대용량 30MB</span>
										 --%>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					
					<div class="btn_wrap center">
						<a class="btn_a color_a" title="저장하기" href="javascript:void(0);" onclick="javascript:preSave();"><span>저장하기</span></a>
						<a class="btn_a color_b" title="취소" href="javascript:goList();"><span>취소</span></a>
					</div>

				</div>
			</div>
			<!-- 컨텐츠 영역 끝 -->
		<c:import url="/inc/adm_footer.jsp"></c:import>
	</div>
	
	<script id="tblCareerTemplate" type="text/x-jquery-tmpl">
		<tr>
			<td>
		<select class="width_100" name="careerList.rCode1">
			<c:forEach items="${code.code03 }" var="cd" varStatus="idx">
				<option value="${cd.code }" >${cd.name }</option>	
			</c:forEach>
		</select>
	</td>
	<td>
		<select class="width_100" name="careerList.rCode2">
			<c:forEach items="${code.code04 }" var="cd" varStatus="idx">
				<option value="${cd.code }" >${cd.name }</option>	
			</c:forEach>
		</select>
	</td>
	<td>
		<c:forEach items="${code.code05 }" var="cd" varStatus="idx">
			<input type="checkbox" id="rCode_${idx.index }_${cd.code }" name="careerList.rCode3" value="${cd.code }"><label for="rCode3_${idx.index }_${cd.code }" class="checklabel marginright_10">${cd.name }</label>
		</c:forEach>
	</td>										
			<td class="text_center">
				<a href="javascript:void(0)" onClick="javascript:deleteCareer(this)" class="btn_del" title="삭제">삭제</a>
			</td>
		</tr>   
	</script>	
</body>
</html>