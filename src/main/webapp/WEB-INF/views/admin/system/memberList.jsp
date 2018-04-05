<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />

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
	    	var idx = $("#user_auth option").index($("#user_auth option:selected"));
	    	if(idx==0) {
	    		alert("사용자 그룹을 선택해 주세요");
	    		return;
	    	}
	    	
	    	$("#procType").val("new");
			var params = $("#frm").serialize();
			$.ajax({
				type: 'POST',
				url: "/admin/processMember",
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
			url: "/admin/processMember",
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
		var tt = 0;
		$("#l_user_auth").each(function() {
			if(tt == idx) {
				if($("option:selected", this).attr('value') == "") {
					alert("사용자 그룹을 선택해 주세요");
		    		return;
				}
			}
			tt++;
			
		});
		$("#listIndex").val(idx);
		$("#procTypeL").val("mod");
		
		var params = $("#listForm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/processMember",
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
<c:import url="/inc/adm_header.jsp?m=5&s=1"/>
			<!-- 왼쪽 메뉴 시작 -->
<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 페이지 타이틀 영역-->
			<div class="page_title">
				<span class="title">시스템 관리</span>
				<ul class="location">
					<li>
						<a href="">Home</a>
					</li>
					<li>
						<a href="">시스템관리</a>
					</li>
					<li class="currentpage">
						<a href="#">사용자 관리</a>
					</li>
				</ul>
			</div>
			<form name="search_form" id="search_form" method="get" action="/admin/memberList">
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
			    <col style="width:;" />
			    <col style="width:120px;" />
			    <col style="width:120px;" />
			    <col style="width:120px;" />
			    <col style="width:60px;" />
			    <col style="width:120px;" />
			  </colgroup>
			  <thead>
			    <tr>
			      <th>아이디</th>
			      <th>이름</th>
			      <th>직급</th>
			      <th>사업장</th>
			      <th>부서명</th>
			      <th>사용자그룹</th>
			      <th>사용여부</th>
			      <th>수정</th>
			    </tr>
			  </thead>
			  <tbody>
			  <form name="frm" id="frm" method="post">
			  		<input type="hidden" name="user_id" id="user_id" value="">
					<input type="hidden" name="user_auth" id="user_auth" value="">
					<input type="hidden" name="user_name" id="user_name" value="">
					<input type="hidden" name="job_title" id="job_title" value="">
					<input type="hidden" name="work_place" id="work_place" value="">
					<input type="hidden" name="group_name" id="group_name" value="">
			  
			  </form>
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
									${list.USER_ID }</td>
									<td class="left">
									${list.USER_NAME }</td>
									<td class="left">
									${list.JOB_TITLE }</td>
									<td class="left">
									${list.WORK_PLACE }</td>
									<td class="left">
									${list.GROUP_NAME }</td>
									<td class="left">
									<input type="hidden" name="memberVOList[${sIdx}].user_id" id="l_user_id" value="${list.USER_ID }">
									<select name="memberVOList[${sIdx}].user_auth" id="l_user_auth">
										<option value>사용자그룹</option>
										<c:if test="${not empty authCode}">
								    		<c:forEach var="code" items="${authCode}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${list.USER_AUTH eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
									</select>
									<td class="center">
									<select name="memberVOList[${sIdx}].use_yn" id="memberVOList[${sIdx}].use_yn">
										<option value="Y" <c:if test="${list.USE_YN eq 'Y'}">selected</c:if>>Y</option>
										<option value="N" <c:if test="${list.USE_YN eq 'N'}">selected</c:if>>N</option>
									</select></td>
									<td class="center">
									<a href="#" id="modifyBtn${sIdx}" class="btn_c color_a" onClick="javascript:goModify('${sIdx}')">수정</a> 
									<a href="#" id="deleteBtn${sIdx}" class="btn_c color_a" onClick="javascript:goDel('${sIdx}')">삭제</a></td>
									
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</form>
				</tbody>
			</table>
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />	
		
	</div><!-- 컨텐츠 영역 끝 -->
</div><!-- contents_wrap 끝 -->	
	
	
	
<c:import url="/inc/adm_footer.jsp"></c:import>

</div>

</body>
</html>
