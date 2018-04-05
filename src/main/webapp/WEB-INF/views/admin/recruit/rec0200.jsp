<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" /><!DOCTYPE html>

<script type="text/javascript">
	$(document).ready(function() {
		$(".calendar_input").datepicker({
			dateFormat : 'yy.mm.dd'
		});
		/************************************************
		* Member search autocomplete
		************************************************/
		var mItem;
		$.fn.autoMemberSearch = function() {
			this.autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "/admin/searchMember",
						global: false,
						dataType : "json",
						data : {
							searchMemberName : request.term
						},
						success : function(data) {
							//alert(data.result);
							response( 
	                            $.map(data.result, function(item) {
                               		return {
	                                    label: item.USER_NAME + "[" + item.JOB_TITLE_NAME +"] " + item.WORK_PLACE_NAME + " " + item.GROUP_NAME,
	                                    value: item.USER_NAME + "[" + item.JOB_TITLE_NAME +"] " + item.WORK_PLACE_NAME + " " + item.GROUP_NAME,
	                                    desc: item.USER_ID + "." + item.EMP_NO + "." + item.USER_NAME + "." + item.JOB_TITLE_NAME + "." + item.WORK_PLACE_NAME + "." + item.GROUP_NAME
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
				change: function (event, ui) {
	                if(!ui.item){
	                    $(this).val("");
	                }

	            },
				select: function(event, ui) {
					var uInfo = ui.item.desc.split(".");
					if(uInfo.length == 6) {
						$("#user_id").val(uInfo[0]);
						$("#emp_no").val(uInfo[1]);
						$("#user_name").val(uInfo[2]);
						$("#job_title").val(uInfo[3]);
						$("#work_place").val(uInfo[4]);
						$("#group_name").val(uInfo[5]);
					} 
				}
			});
	    };

	    $("#SKEY_1").autoMemberSearch();
	    
	    $("#regBtn").click(function(){
	    	$("#procType").val("new");
			var params = $("#frm").serialize();
			$.ajax({
				type: 'POST',
				url: "/admin/processEvMember",
				data: params,
				async: false,
		        cache: false,
				success: function(data) {
					alert(data.result.msg);
					if(data.result.result == "SUCCESS"){
						document.search_form.submit();	
					}
				},
				error : function() {
					alert("알수 없는 에러가 발생했습니다.");
				},
				dataType: "json"
			}); 
	    });
		
	});
	function goDel(idx) {
		$("#listIndex").val(idx);
		$("#procTypeL").val("del");
		
		var params = $("#listForm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/processEvMember",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.result.msg);
				if(data.result.result == "SUCCESS"){
					document.search_form.submit();	
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
		
	}
	function goModify(idx) {
		$("#listIndex").val(idx);
		$("#procTypeL").val("mod");
		
		var params = $("#listForm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/processEvMember",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.result.msg);
				if(data.result.result == "SUCCESS"){
					document.search_form.submit();	
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
		
	}
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
	}
	
	
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
<c:import url="/inc/adm_header.jsp?m=2&s=2"/>
			<!-- 왼쪽 메뉴 시작 -->
<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 페이지 타이틀 영역-->
			<div class="page_title">
				<span class="title">채용 관리</span>
				<ul class="location">
					<li>
						<a href="">Home</a>
					</li>
					<li>
						<a href="">채용관리</a>
					</li>
					<li class="currentpage">
						<a href="#">평가위원 등록</a>
					</li>
				</ul>
			</div>
			<form name="search_form" id="search_form" method="get" action="/admin/recruit/rec0200">
					<input type="hidden" name="idx"> 
					<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo }">
			</form>
			
			
	<div class="contetns">
			<form name="frm" id="frm" method="post">
			<div class="table_header admin">
				<div class="total">
					총 <c:out value="${paginationInfo.totalRecordCount }" />건
				</div>
				
				<div class="btn_area">
					사용자 등록 : <input type="text" name="SKEY_1" id="SKEY_1" value="" style="width:320px" placeholder="이름으로 검색후 선택하세요">
					<select name="user_auth" id="user_auth">
						<option value>사용자그룹</option>
						<c:if test="${not empty authCode}">
				    		<c:forEach var="code" items="${authCode}" varStatus="status">
			    				<option value="${code.code}" <c:if test="${list.USER_AUTH eq code.code}">selected</c:if>>${code.name}</option>
				    		</c:forEach>
				    	</c:if>
					</select>
					<input type="hidden" name="user_id" id="user_id" value="">
					<input type="hidden" name="emp_no" id="emp_no" value="">
					<input type="hidden" name="user_name" id="user_name" value="">
					<input type="hidden" name="job_title" id="job_title" value="">
					<input type="hidden" name="work_place" id="work_place" value="">
					<input type="hidden" name="group_name" id="group_name" value="">
					
					<input type="hidden" name="procType" id="procType" value="">
	
					<a class="btn_c color_a additem" id="regBtn" href="#" title="등록"><span>등록</span></a>
				</div>
			</div>
			</form>
			
			
			
			<table class="list_table admin">
				<caption>사용자 목록. 아이디, 이름, 직급, 사업장, 사용자그룹, 사용여부, 수정.</caption>
			  <colgroup>
			    <col style="width:90px;" />
			    <col style="width:80px;" />
			    <col style="width:60px;" />
			    <col style="width:110px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:;" />
			  </colgroup>
			  <thead>
			    <tr>
			      <th>부서</th>
			      <th>성명</th>
			      <th>직급</th>
			      <th>사업장</th>
			      <th>자기소개서<br>(인성)</th>
			      <th>자기소개서<br>(직무)</th>
			      <th>인성면접</th>
			      <th>직무면접</th>
			      <th>최종면접</th>
			      <th>수정/삭제</th>
			    </tr>
			  </thead>
			  <tbody>
			  <form name="listForm"  id="listForm" method="post" action="/admin/processMember">
			  
				  <input type="hidden" name="listIndex" id="listIndex" >
				  <input type="hidden" name="procType" id="procTypeL" >
					<c:choose>
						<c:when test="${rsList.size() < 1 }">
							<tr>
								<td colspan="5">검색된 사용자가 없습니다.</td>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="list" items="${rsList }" varStatus="status">
							<c:set var="sIdx" value="${status.index}" />
								<tr>
									<td class="left">
									${list.GROUP_NAME }</td>
									<td class="left">
									${list.USER_NAME }</td>
									<td class="left">
									${list.JOB_TITLE }</td>
									<td class="left">
									${list.WORK_PLACE }</td>
									<td class="center">
									<input type="checkbox" name="memberVOList[${sIdx}].ev_role_1" <c:if test="${list.EV_ROLE_1 eq 'Y'}" >checked</c:if> value="Y"></td>
									<td class="center">
									<input type="checkbox" name="memberVOList[${sIdx}].ev_role_2" <c:if test="${list.EV_ROLE_2 eq 'Y'}" >checked</c:if> value="Y"></td>
									<td class="center">
									<input type="checkbox" name="memberVOList[${sIdx}].ev_role_3" <c:if test="${list.EV_ROLE_3 eq 'Y'}" >checked</c:if> value="Y"></td>
									<td class="center">
									<input type="checkbox" name="memberVOList[${sIdx}].ev_role_4" <c:if test="${list.EV_ROLE_4 eq 'Y'}" >checked</c:if> value="Y"></td>
									<td class="center">
									<input type="checkbox" name="memberVOList[${sIdx}].ev_role_5" <c:if test="${list.EV_ROLE_5 eq 'Y'}" >checked</c:if> value="Y"></td>
									<td class="center">
									<a href="#" id="modifyBtn${sIdx}" class="btn_c color_a" onClick="javascript:goModify('${sIdx}')">수정</a> 
									<a href="#" id="deleteBtn${sIdx}" class="btn_c color_a" onClick="javascript:goDel('${sIdx}')">삭제</a></td>
									<input type="hidden" name="memberVOList[${sIdx}].user_auth" value="${list.USER_AUTH }">
									<input type="hidden" name="memberVOList[${sIdx}].use_yn" value="${list.USE_YN }">
									<input type="hidden" name="memberVOList[${sIdx}].user_id" value="${list.USER_ID }">
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</form>
				</tbody>
			</table>
			
	</div><!-- 컨텐츠 영역 끝 -->
</div><!-- contents_wrap 끝 -->	
	
	
	
<c:import url="/inc/adm_footer.jsp"></c:import>

</div>

</body>
</html>
