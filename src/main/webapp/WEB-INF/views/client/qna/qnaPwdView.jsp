<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
function goCheck() {
	var params = jQuery("#frm").serialize();
	$.ajax({
		type: 'POST',
		url: "/client/qnaPwdCheck",
		data: params,
		async: false,
	    cache: false,
		success: function(data) {
			if(data.json.result == "SUCCESS"){
				$("#search_form").attr("action", "/client/qnaDetail");
				$("#search_form").submit();
			}
		},
		error : function() {
			alert("알수 없는 에러가 발생했습니다.");
		},
		dataType: "json"
	}); 
}

function goList() {
	
}
</script>
<title>무림 채용</title>
</head>
<body>
<div id="wrap">
<c:import url="/inc/header.jsp?m=4&s=2"></c:import>
			<!-- 컨텐츠 영역 시작 -->
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 컨텐츠 타이틀 -->
				<div class="page_title">
					<span class="title">채용문의</span>
					<span class="description">무림 그룹의 채용에 관한 궁금증을 해결해 드립니다.</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용안내</a>
						</li>
						<li class="currentpage">
							<a href="">인재상</a>
						</li>
					</ul>
				</div>

    <!-- header -->
                <div class="contetns">
                <form name="search_form" id="search_form" method="post">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${vo.pageNo }"/>">
					<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>">
					<input type="hidden" name="idx" value="<c:out value="${vo.idx }"/>">
					<input type="hidden" name="procType" id="procType">
                
                </form>
                
				<div class="jobapp_login margintop_100">
				<form method="post" name="frm" id="frm">
					<input type="hidden" name="IDX" value="<c:out value="${vo.idx }"/>">
					<input type="hidden" name="lockYn">

					
					<h1><b>비밀번호</b> 확인</h1>
					<ul class="login_list">
						<li>
							<span class="label">비밀번호</span>
							<input type="password" name="REG_PW" value="" />
							<span class="disc">6~12자리 숫자 또는 문자</span>
						</li>
					</ul>
					<ul class="login_disc">
						<li>본인 확인을 위해 비밀번호를 정확히 입력해주세요.</li>
					</ul>
					
				</form>
				</div>
			
				<div class="btn_wrap center">
					<a class="btn_a color_a" title="확인" href="javascript:void(0);" onclick="javascript:goCheck();"><span>확인</span></a>
					<a class="btn_a color_b" title="취소" href="javascript:void(0);" onclick="javascript:goList();"><span>취소</span></a>
				</div>
				
				
</div>
</div>
<c:import url="/inc/footer.jsp"></c:import>
</div>
</body>
</html>