<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
var currentYear = new Date().getFullYear();
var validator;

	$(document).ready(function() {
		picker();
		selectjob();
	});
	
	/************************************************
	* 달력
	************************************************/
	function picker(){
		$('.dateinput').each(function() { $(this).moorimDatePicker({dateFormat : 'yy.mm.dd',yearRange : '1960:'+currentYear}); });
	}
	/************************************************
	* 달력버튼 event
	************************************************/
	function showDatepicker(obj) {
		$(obj).prev().prev().datepicker("show");
	}
	
	function selectjob(){
		/************************************************
		* 응시직무 동적 selectbox 제어
		************************************************/
		$.fn.makeCombo = function(depth, value) {
			if(isNullStr($('#SKEY_1').val())){
				return false;
			}
			var _this = $(this);

			var params = new Object();
			params.rIdx = $('#SKEY_1').val();
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
					   // $('#loadingCombo').css("top", _this.offset().top + _this.height()/2);
					   // $('#loadingCombo').css("left", _this.offset().left + 5);
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
	    var comboInitData1 = ['${pCommon.SKEY_2}', '${pCommon.SKEY_3}'];

	    // selectbox 초기화
	    $('#rJobKindCode1').makeCombo(1, comboInitData1);
	    $('#rJobPartCode1').makeCombo(2, comboInitData1);
	    
	 // 직무,직군 변경이벤트 binding
		$('#rJobKindCode1').comboChageEvent(1);
	    $('#rJobPartCode1').comboChageEvent(2);
	}
	
	
	function goPop(rApCode,rIdx){
		var frm = document.iForm;
		
		var width=1000, height=700;
		var left = (screen.availWidth - width)/2;
		var top = (screen.availHeight - height)/2;
		var options = "width=" + width;
		options += ",height=" + height;
		options += ",left=" + left;
		options += ",top=" + top;
	
		window.open("", "popupView", options);
		
		frm.action = "/admin/recruit/rec0101";
		frm.rApCode.value = rApCode;
		frm.rIdx.value = rIdx;
		frm.target = "popupView";
		frm.submit();
		
	}
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
	}
	
	function setNotice(){
		document.search_form.submit();
	}
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
<c:import url="/inc/adm_header.jsp?m=2&s=1"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">지원확인</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용관리</a>
						</li>
						<li class="currentpage">
							<a href="#">지원확인</a>
						</li>
					</ul>
				</div>
				
				
				
				<div class="contetns">	
			
					<div class="table_search">
						<div class="input_area">
							<form name="search_form" id="search_form" method="post" action="/admin/recruit/rec0100">
								<input type="hidden" name="idx"> 
								<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
								
								<table>
									<caption>검색 조건 테이블</caption>
									<tbody>
										<tr>
											<th>
												채용공고
											</th>
											<td>
											    <select name="SKEY_1" id="SKEY_1" class="width_100" onchange="setNotice();">
											    	<option value="">공고</option>
													<c:forEach var="rs" items="${notice}" varStatus="status">
														<option value="${rs.IDX}" ${pCommon.SKEY_1 eq rs.IDX ? 'selected="selected"':'' }>${rs.R_TITLE}</option>
													</c:forEach>
											  	</select>
											</td>
											<th>
												총지원자
											</th>
											<td>
												<c:out value="${total }"/>
											</td>
										</tr>
										<tr>
											<th>
												응시직종
											</th>
											<td>
												<select name="SKEY_2" id="rJobKindCode1">
											    	<option value="">직군</option>
											    	<c:forEach items="${code.code03 }" var="cd" varStatus="idx">
														<option value="${cd.code }" ${pCommon.SKEY_2 eq cd.code ? 'selected="selected"':'' } >${cd.name }</option>	
													</c:forEach>
											    </select>
												<select name="SKEY_3" id="rJobPartCode1">
											    	<option value="">직무</option>
											    	<c:forEach items="${code.code04 }" var="cd" varStatus="idx">
														<option value="${cd.code }" ${pCommon.SKEY_3 eq cd.code ? 'selected="selected"':'' } >${cd.name }</option>	
													</c:forEach>
											  </select>
											</td>
											<th>
												지원일자
											</th>
											<td>
												<input type="text" name="SKEY_4" class="dateinput" value="<c:out value="${pCommon.SKEY_4 }" />" /><a class="dateinput_btn" onclick="showDatepicker(this);" href="javascript:void(0);" title="날짜검색">날짜검색</a>
												~
												<input type="text" name="SKEY_5" class="dateinput" value="<c:out value="${pCommon.SKEY_5 }" />" /><a class="dateinput_btn" onclick="showDatepicker(this);" href="javascript:void(0);" title="날짜검색">날짜검색</a>
											</td>
										</tr>
										<tr>
											<th>
												수험번호
											</th>
											<td>
												<input type="text" name="SKEY_6" value="<c:out value="${pCommon.SKEY_6 }"/>">
											</td>
											<th>
												응시구분
											</th>
											<td>
												<select name="SKEY_7">
													<option value="" >전체</option>
													<c:forEach items="${code.code40 }" var="cd" varStatus="">
														<option value="${cd.code }" <c:if test="${pCommon.SKEY_7 eq cd.code }">selected="selected"</c:if>>${cd.name }</option>	
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>
												이름
											</th>
											<td>
												<input type="text" name="SKEY_8" value="<c:out value="${pCommon.SKEY_8 }"/>">
											</td>
											<th>
												성별
											</th>
											<td>
												<select name="SKEY_9">
													<option value>성별</option>
											    	<option value="1" <c:if test="${pCommon.SKEY_9 eq '1'}">selected</c:if>>남</option>
											    	<option value="2" <c:if test="${pCommon.SKEY_9 eq '2'}">selected</c:if>>여</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							
							</form>
						</div>
						<div class="btn_area">
							<a class="search_btn" href="#" onclick="javascript:document.search_form.submit();" title="검색"><span>검색</span></a>
						</div>
					</div>
				
					<div class="table_header admin">
						<div class="total">
							총 <c:out value="${paginationInfo.totalRecordCount }" />건
						</div>
						<!-- 
						<div class="btn_area">
							<a href="javascript:void(0);" onclick="javascript:goView();" class="btn_c color_a additem"><span>등록하기</span></a>
						</div>
						 -->
					</div>
					<form name="iForm" id="iForm" method="post">
						<input type="hidden" name="rApCode"> 
						<input type="hidden" name="rIdx"> 
						<table class="list_table admin">
							<caption>지원자 목록. 수험번호, 구분, 이름, 연령, 성별, 직군직무, 최종학교, 전공, 연락처, 등록일, 지원자 비번, 미리보기로 구성.</caption>
							<colgroup>
							    <col style="width:80px;" />
							    <col style="width:50px;" />
							    <col style="width:70px;" />
							    <col style="width:40px;" />
							    <col style="width:40px;" />
							    <col style="width:;" />
							    <col style="width:90px;" />
							    <col style="width:90px;" />
							    <col style="width:110px;" />
							    <col style="width:80px;" />
							    <col style="width:75px;" />
							    <col style="width:40px;" />
						    </colgroup>
							  <thead>
							    <tr>
							      <th>수험번호</th>
							      <th>구분</th>
							      <th>이름</th>
							      <th>연령</th>
							      <th>성별</th>
							      <th>직군·직무</th>
							      <th>최종학교</th>
							      <th>전공</th>
							      <th>연락처</th>
							      <th>등록일</th>
							      <th>지원자 비번</th>
							      <th>미리보기</th>
							    </tr>
							  </thead>
						  <tbody>
						  	  <c:choose>
									<c:when test="${rsList.size() < 1 or empty rsList }">
										<tr>
											<td colspan="13">등록된 지원자가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${rsList }" varStatus="status">
											<tr>
										      <td><c:out value="${list.R_AP_CODE }" /></td>
										      <td><c:out value="${list.R_GUBUN_NM }" /></td>
										      <td><c:out value="${list.R_NAME }" /></td>
										      <td><c:out value="${list.R_AGE }" /></td>
										      <td><c:out value="${list.R_SEX_CODE }" /></td>
										      <td><c:out value="${list.R_JOB_KIND_CODE1_NM }" /> - <c:out value="${list.R_JOB_PART_CODE1_NM }" /></td>
										      <td><c:out value="${list.S_NAME }" /></td>
										      <td><c:out value="${list.S_MAJOR }" /></td>
										      <td><c:out value="${list.R_HP }" /></td>
										      <td><fmt:formatDate value="${list.REG_DT }" pattern="yyyy.MM.dd" /></td>
										      <td>123456</td>
										      <td><a href="javascipt:void(0);" onclick="goPop('${list.R_AP_CODE }','${list.R_IDX }');" class="btn_page" title="미리보기">미리보기</a></td>
										    </tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
						  </tbody>
						</table>
					</form>
					
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />			
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>