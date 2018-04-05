<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>무림 채용</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/object.css" />
    
    <script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
    <script type="text/javascript">
    
    /*********************
     **채용공고 구분에 따른 검색
     **********************/
    function fn_setRecNotice(rGubun){
    	var frm = document.nForm;
    	frm.rGubun.value = rGubun;
    	frm.submit();
    }
    
    /*********************
     **채용공고 상세페이지 이동
     **********************/
    function goNoticeView(idx) {
		var frm = document.nForm;
		frm.idx.value = idx;
		frm.action = "/client/job/jobDetail";
		frm.submit();
	}
    </script>
</head>
<body>
<div id="wrap">
<c:import url="/inc/header.jsp?mYn=Y"></c:import>
		<div class="main_container">
			<div class="main_wrap">
				<!-- 이미지 배너 영역 -->
				<div class="banner img01"><!-- 접속시 class의 img01 ~ img03 중 랜덤으로 보여짐 (배경 이미지와 안의 텍스트 모두 랜덤 출력) -->
					<!-- 접속시 class의 txt01 과 txt02 의 display 값을 랜덤으로 block과 none 처리 (둘 중 하나만 보이도록 - 보이는 순서는 랜덤) -->
					<span class="msg txt01" style="display:block;">무림은 건강한 욕심으로 <br />품격과 집념을 지켜 나갑니다.</span>
					<span class="msg txt02" style="display:none;">무림은 건강한 욕심으로 <br />품격과 집념을 지켜 나갑니다.</span>
				</div>
				<!-- 채용공고 영역 -->
				<div class="noti_wrap">
					<div class="header">
						<form id="nForm" name="nForm" method="post" action="/">
							<input type="hidden" name="rGubun" value="">
							<input type="hidden" name="idx">
						</form>
						<h1>채용공고</h1>
						<ul class="category">
							<li><a href="/" <c:if test="${empty param.rGubun}">class="selected"</c:if>>전체 ${recruitCnt.ALL_CNT }</a></li>
							<li><a href="javascript:void(0);" <c:if test="${param.rGubun eq '40001'}">class="selected"</c:if> onclick="fn_setRecNotice('40001');">신입 ${recruitCnt.S1 }</a></li>
							<li><a href="javascript:void(0);" <c:if test="${param.rGubun eq '40002'}">class="selected"</c:if> onclick="fn_setRecNotice('40002');">경력 ${recruitCnt.S2 }</a></li>
							<li><a href="javascript:void(0);" <c:if test="${param.rGubun eq '40003'}">class="selected"</c:if> onclick="fn_setRecNotice('40003');">신입/경력 ${recruitCnt.S3 }</a></li>
							<li class="btn"><a href="/client/job/jobNotice">전체 채용공고 더보기</a></li>
						</ul>
					</div>
					<ul class="list">
						<c:if test="${empty recruitList }">
						
						</c:if>
						<c:if test="${!empty recruitList }">
							<c:forEach var="rl" items="${recruitList }">
								<fmt:parseDate value="${rl.R_SDATE}" var="startFmt" pattern="yyyyMMdd" />
								<fmt:parseDate value="${rl.R_EDATE}" var="endFmt" pattern="yyyyMMdd" />
								<c:set var="typeClass" value="" />
								<c:if test="${rl.R_GUBUN eq '40001' }">
									<c:set var="typeClass" value="type1" />
								</c:if>
								<c:if test="${rl.R_GUBUN eq '40002' }">
									<c:set var="typeClass" value="type2" />
								</c:if>
								<c:if test="${rl.R_GUBUN eq '40003' }">
									<c:set var="typeClass" value="type3" />
								</c:if>
								
								<li class="${typeClass }">
									<a href="javascript:void(0);" onclick="goNoticeView('${rl.IDX}');">
										<div class="header">
											<span class="division">${rl.R_GUBUN_NM }</span>
											<span class="dday">
												D 
												<c:choose>
													<c:when test="${rl.D_DAY gt 0 }">- ${rl.D_DAY}</c:when>
													<c:when test="${rl.D_DAY lt 0 }">+ ${rl.D_DAY* (-1)}</c:when>
													<c:otherwise>- 0</c:otherwise>
												</c:choose> 
											</span>
										</div>
										<span class="title">${rl.R_TITLE }</span>
										<span class="date">
											<fmt:formatDate value="${startFmt}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${endFmt}" pattern="yyyy.MM.dd"/>
										</span>
									</a>
								</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
				<!-- 바로가기 링크 영역 -->
				<div class="qmenu_wrap">
					<ul class="qmenu">
						<li>
							<a href="" class="menu1">
								<h1>인재상</h1>
								<span>무림은 <br />새로운 인재를 찾습니다.</span>
							</a>
						</li>
						<li>
							<a href="/client/job/jobNotice" class="menu2">
								<h1>지원서 작성</h1>
								<span>무림과 함께 하십시오.</span>
							</a>
						</li>
						<li>
							<a href="/client/job/recViewLogin" class="menu3">
								<h1>지원서 확인/수정</h1>
								<span>작성한 입사 지원서의<br />확인 수정이 가능합니다.</span>
							</a>
						</li>
						<li>
							<a href="/client/faq" class="menu4">
								<h1>FAQ</h1>
								<span>궁금증을 빠르게<br />해결 할 수 있습니다.</span>
							</a>
						</li>
					</ul>
				</div>

			</div>
		</div>
<c:import url="/inc/footer.jsp"></c:import>		
</div>
</body>
</html>
