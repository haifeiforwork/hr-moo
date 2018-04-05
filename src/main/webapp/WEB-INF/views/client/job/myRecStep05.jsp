<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {
		
		$('.btn_a').on('click', function(e) {
			e.preventDefault();
		});
		
	});
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
				<div class="jobapp_login">
					<h1>지원서 작성 <b>완료</b></h1>
					<ul class="comp_msg">
						<li class="title">
							입사지원이 완료 되었습니다.
						</li>
						<li>
							<span class="info"><b>${rs.R_NAME}</b>님의 수험번호는 <b>${rs.R_SNUM}${rs.R_AP_CODE}</b> 입니다.</span>
						</li>
					</ul>
				</div>
			
				<div class="btn_wrap center">
					<a class="btn_a color_a" title="확인" href="" onclick="location.href='/';"><span>확인</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>