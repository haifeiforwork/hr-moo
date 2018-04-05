<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="_incLeftMenu" value="${param.m}" />
<c:set var="_incLeftSub" value="${param.s}" />

<script type="text/javascript">

$(function(){
	/*나중에 지워야됨. 미개발 목록 개발중 알림창, a태그에 url 입력 시 안뜸.*/	
	$(".depth2 a, .lnb_list a").on("click", function(){
		var h= $(this).attr("href");
		if(h =="" || h =="#"){
			alert("개발중입니다.");
			return false;
		}
	})
	
	/*나중에 지워야됨. 오른쪽 상단 메뉴 트리, 페이지마다 수정 후 삭제? lnb기준으로 변화함.*/
	$(".contents_wrap .location li").eq(0).find('a').attr("href","/");
	$(".contents_wrap .location li").eq(1).find('a').text($(".lnb_list li").eq(0).text());
	$(".contents_wrap .location li").eq(2).find('a').text($(".lnb_list li a.selected").text());
	
})
</script>
<!-- 헤더 시작 -->
<header>
	<div class="header_wrap">
		<!-- 상단 로고 링크 영역 -->
		<h1>
			<a href="" class="logo" title="Moorim 채용 관리자 메인 바로가기"><img
				src="/resources/images/header_logo.png" alt="Moorim 로고"><span>채용
					관리자</span></a>
		</h1>
		<!-- 상단 서브 링크 영역 -->
		<div class="util">
			<ul>
				<li><span class="name">${sessionScope.user.USER_NAME}(${sessionScope.user.AUTH_NAME})</span>
				</li>
				<li><a href="/admin/logout">Log out</a></li>
				<li><a href="" class="go_link" target="_blank"
					title="Moorim 채용 홈페이지 바로가기 (새창열림)">채용홈페이지 바로가기</a></li>
			</ul>
		</div>
		<!-- 상단 메뉴 영역 -->
		<nav>
			<div class="gnb">
				<ul>
					<li><a id="menu" href="#">공고관리</a> <!-- 메뉴 마우스 오버시 class="depth2" 4개와 하단 id="gnb_sub" display를 block 으로 변경하여 서브 메뉴를 펼쳐줌 -->
						<ul class="depth2" style="display: none;">
							<li><a href="/admin/recruit/rec0001">공고 조회</a></li>
							<li><a href="/admin/recruit/rec0002">공고 등록</a></li>
						</ul></li>
					<li><a id="menu" href="#">채용 관리</a>

						<ul class="depth2" style="display: none;">
							<li><a href="/admin/recruit/rec0100">지원자 관리</a></li>
							<li><a href="/admin/recruit/rec0200">평가위원 등록</a></li>
							<li><a href="/admin/recruit/rec0300">서류전형</a></li>
							<li><a href="/admin/recruit/rec0400">1차면접</a></li>
							<li><a href="">직무면접</a></li>
							<li><a href="">최종면접</a></li>
						</ul></li>
					<li><a id="menu" href="#">채용문의 관리</a>
						<ul class="depth2" style="display: none;">
							<li><a href="/admin/qnaList">채용문의</a></li>
							<li><a href="/admin/faq/faq0001">채용FAQ</a></li>
						</ul></li>
					<li><a id="menu" href="#">공통 관리</a>
						<ul class="depth2" style="display: none;">
							<li><a href="">학교 등록</a></li>
							<li><a href="/admin/common/com0101">학과 등록</a></li>
						</ul></li>
					<li><a id="menu" href="#">시스템 관리</a>
						<ul class="depth2" style="display: none;">
							<li><a href="/admin/memberList">사용자 관리</a></li>
							<li><a href="/admin/common/menu">메뉴 관리</a></li>
							<li><a href="/admin/codeManage">공통코드 관리</a></li>
							<li><a href="/admin/common/itm0001">자기소개서 항목 관리</a></li>
							<li><a href="">서류평가 가중치 관리</a></li>
							<li><a href="/admin/common/itm0101">평가항목 관리</a></li>
							<li><a href="">일괄 다운로드</a></li>
							<li><a href="/admin/common/popupManage">팝업관리</a></li>
						</ul></li>
					<li><a id="menu" href="#">서류평가</a>
						<ul class="depth2" style="display: none;">
							<li><a href="">이력서평가</a></li>
							<li><a href="/admin/assesor/doc0201">자기소개서평가</a></li>
						</ul></li>
				</ul>
			</div>
		</nav>
	</div>
</header>
<div id="gnb_sub" style="display:none;"></div>

<div class="container"><!-- container 시작, adm_footer.jsp에 끝 태그 있음 -->		

			<div id="lnb_wrap" class="lnb_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="lnb_wrap lnb_close" (컨텐츠 영역도 lnb_close로 클래스 변경)-->
				<a href="#" id="lnb_closebtn" class="lnb_closebtn">서브 메뉴 닫기</a>
				<!--<a href="" class="lnb_openbtn">서브 메뉴 열기</a>-->

<c:choose>
<c:when test="${_incLeftMenu eq '1'}">
				<ul class="lnb_list">
					<li class="title">
						공고 관리
					</li>
					<li>
						<a href="/admin/recruit/rec0001" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>공고 조회</a>
					</li>
					<li>
						<a href="/admin/recruit/rec0002" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>공고 등록</a>
					</li>
				</ul>
</c:when>
<c:when test="${_incLeftMenu eq '2'}">
				<ul class="lnb_list">
					<li class="title">
						채용 관리
					</li>
					<li>
						<a href="/admin/recruit/rec0100" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>지원자 관리</a>
					</li>
					<li>
						<a href="/admin/recruit/rec0200" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>평가위원 등록</a>
					</li>
					<li>
						<a href="/admin/recruit/rec0300" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>서류전형</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '4'}">class="selected"</c:if>>인성면접</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '5'}">class="selected"</c:if>>직무면접</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '6'}">class="selected"</c:if>>최종면접</a>
					</li>
				</ul>

</c:when>
<c:when test="${_incLeftMenu eq '3'}">
				<ul class="lnb_list">
					<li class="title">
						채용문의 관리
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>채용문의</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>채용FAQ</a>
					</li>
				</ul>

</c:when>
<c:when test="${_incLeftMenu eq '4'}">
				<ul class="lnb_list">
					<li class="title">
						공통 관리
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>학교등록</a>
					</li>
					<li>
						<a href="/admin/common/com0101" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>학과등록</a>
					</li>
					
					
				</ul>

</c:when>
<c:when test="${_incLeftMenu eq '5'}">
				<ul class="lnb_list">
					<li class="title">
						시스템 관리
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>사용자 관리</a>
					</li>
					<li>
						<a href="/admin/common/menu" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>메뉴 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>공통코드 관리</a>
					</li>
					<li>
						<a href="/admin/common/itm0001" <c:if test="${_incLeftSub eq '4'}">class="selected"</c:if>>문항 관리</a>
					</li>
					<li>
						<a href="/admin/common/itm0101" <c:if test="${_incLeftSub eq '5'}">class="selected"</c:if>>평가 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '6'}">class="selected"</c:if>>서류평가 가중치 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '7'}">class="selected"</c:if>>일괄 다운로드</a>
					</li>
					<li>
						<a href="/admin/common/popupManage" <c:if test="${_incLeftSub eq '8'}">class="selected"</c:if>>팝업관리</a>
					</li>						
				</ul>

</c:when>
<c:when test="${_incLeftMenu eq '6'}">
				<ul class="lnb_list">
					<li class="title">
						서류평가
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>이력서 평가</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>자기소개서 평가</a>
					</li>
				</ul>

</c:when>
</c:choose>
			</div>
  	
  	
