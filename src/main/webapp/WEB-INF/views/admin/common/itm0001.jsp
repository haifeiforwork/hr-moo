<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {
		$(".calendar_input").datepicker({
			dateFormat : 'yy.mm.dd'
		});
	});
	
	function goView(type, idx){
		var frm = document.frm;	
		frm.action = "/admin/common/itm0001Pop";
		frm.target = "popupView";
		
		frm.procType.value = type;
		if(type =='mod'){
			frm.idx.value = idx;
		}
		
		var width=800, height=480;
		var left = (screen.availWidth - width)/2;
		var top = (screen.availHeight - height)/2;
		var options = "width=" + width;
		options += ",height=" + height;
		options += ",left=" + left;
		options += ",top=" + top;
	
		window.open("", "popupView", options);
		frm.submit();
		
	}
	
	function goDelete(idx){
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		var frm = document.frm;
		frm.idx.value = idx;
		
		var params = $("#frm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/common/deleteItm0001Pop",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.json.msg);
				if(data.json.result == "SUCCESS"){
					document.frm.action = "/admin/common/itm0001";
					document.frm.submit();
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/adm_header.jsp?m=5&s=4"></c:import>
			
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">자기소개서 항목 관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">시스템관리</a>
						</li>
						<li class="currentpage">
							<a href="#">자기소개서 항목 관리</a>
						</li>
					</ul>
				</div>
				
				<div class="step_wrap">
					<ul class="step3">
						<li class="current"><a href="/admin/common/itm0001"><span>자기소개서 항목</span></a></li>
						<li><a href="/admin/common/itm0002"><span>인성 항목</span></a></li>
						<li><a href="/admin/common/itm0003"><span>직무 항목</span></a></li>
					</ul>
				</div>
				
				<div class="contetns">	
			
					<form name="frm" id="frm" method="post" >
						<input type="hidden" name="idx">
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>"> 
					</form>
				
					<div class="table_header admin">
						<div class="btn_area">
							<a href="javascript:void(0);" onclick="javascript:goView('new');" class="btn_c color_a additem"><span>등록하기</span></a>
							<a href="javascript:void(0);" onclick="window.location.reload()" class="btn_c color_a additem"><span>새로고침</span></a>
						</div>
					</div>
					<table class="list_table admin">
						<caption>대분류, 문항요소, 문항, 순서(신입), 순서(경력), 최소길이, 최대길이, 관리로 구성.</caption>
						<colgroup>
							<col style="width:80px;" />
							<col style="width:80px;" />
							<col style="*" />
							<col style="width:40px;" />
							<col style="width:40px;" />
							<col style="width:40px;" />
							<col style="width:40px;" />
							<col style="width:150px;" />
						</colgroup>
						<thead>
							<tr>
								<th>대분류</th>
								<th>문항요소</th>
								<th>문항</th>
								<th>순서(신입)</th>
								<th>순서(경력)</th>
								<th>최소길이</th>
								<th>최대길이</th>
								<th>관리</th>
							</tr>
						</thead>
					  <tbody>
					  	  <c:choose>
								<c:when test="${rsList.size() < 1 }">
									<tr>
										<td colspan="8">등록된 항목이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
										
									<c:forEach var="list" items="${rsList }" varStatus="status">
										<%--${list.IDX } --%>
										<tr>
									      <td><c:out value="${list.ITEM_CAT }" /></td>
									      <td><c:out value="${list.ITEM_TITLE }" /></td>
									      <td><c:out value="${list.ITEM_DESC }" /></td>
									      <td><c:out value="${list.PRIOR_NEW }" /></td>
									      <td><c:out value="${list.PRIOR_CAREER }" /></td>
									      <td><c:out value="${list.LENGTH_MIN }" /></td>
									      <td><c:out value="${list.LENGTH_MAX }" /></td>
									      <td>
									      	<a href="javascript:void(0);" onclick="javascript:goView('mod','${list.IDX }');" class="btn_c color_a"><span>수정</span></a>
									      	<a href="javascript:void(0);" onclick="javascript:goDelete('${list.IDX }');" class="btn_c color_a"><span>삭제</span></a>
									      </td>
									    </tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
					  </tbody>
					</table>
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>