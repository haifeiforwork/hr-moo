<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	var currentYear = new Date().getFullYear();
	var validator;
	$(document).ready(function() {
		
	});

</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=3&s=2" />

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
				<input type="hidden" name="rApCode" id="rApCode" />
				<div class="jobapp_login">
					<h1>합격자 <b>발표</b></h1>
					[TODO] 퍼블이 없는듯, 데이터만 뿌려둠<br><br><br><br>
					${rs }
				</div>
				</form>
			
				<div class="btn_wrap center">
					<a class="btn_a color_a" title="확인" href="/client/acceptedCheck"><span>확인</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>