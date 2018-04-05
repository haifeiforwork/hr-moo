<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="_incLeftMenu" value="${param.m}" />
<c:set var="_incLeftSub" value="${param.s}" />
<c:set var="mainYn" value="${param.mYn}" />



<script type="text/javascript">

$(function(){
	/*나중에 지워야됨. 미개발 목록 개발중 알림창, a태그에 url 입력 시 안뜸.*/	
	$(".depth2 a, .lnb_list a").on("click", function(){
		var h= $(this).attr("href");
		if(h ==""){
			alert("개발중입니다.");
			return false;
		}
	})
	
	/*나중에 지워야됨. 오른쪽 상단 메뉴 트리, 페이지마다 수정 후 삭제*/
	$(".contents_wrap .location li").eq(0).find('a').attr("href","/");
	$(".contents_wrap .location li").eq(1).find('a').text($(".lnb_list li").eq(0).text());
	$(".contents_wrap .location li").eq(2).find('a').text($(".lnb_list li a.selected").text());
	
})
	/*
	function menuClick() {
		if($("#gnb_sub").css("display") == "none"){
			$('.depth2').css("display", "block");
			$('#gnb_sub').css("display", "block");
		} else {
			$('.depth2').css("display", "none");
			$('#gnb_sub').css("display", "none");
		}
		
	}
	*/
	
	function menuClick() {
			$('.depth2').css("display", "block");
			$('#gnb_sub').css("display", "block");
	}
	function gnbMobuseLeave(){
		$('.depth2').css("display", "none");
		$('#gnb_sub').css("display", "none");
	}
	
</script>
<header>
			<div class="header_wrap">
				<!-- 상단 로고 링크 영역 -->
	      <h1>
					<a href="/" class="logo" title="Moorim 채용 홈페이지 메인 바로가기"><img src="/resources/images/header_logo.png" alt="Moorim 로고"></a>
				</h1>
				<!-- 상단 서브 링크 영역 -->
				<div class="util">
					<!-- 
					<ul>
						<li>
							<a href="">Log in</a>
						</li>
						<li>
							<a href="">My Page</a>
						</li>
						<li>
							<a href="" class="go_link" target="_blank" title="Moorim 기업 홈페이지 바로가기 (새창열림)">moorim.co.kr</a>
						</li>
					</ul>
					 -->
				</div>
				<!-- 상단 메뉴 영역 -->
	      <nav>
					<div class="gnb">
						<ul>
							<li>
								<a href="#" onmouseover="menuClick();" >채용안내</a> <!-- 메뉴 마우스 오버시 class="depth2"와 하단 id="gnb_sub" display를 block 으로 변경하여 서브 메뉴를 펼쳐줌 -->
								<ul class="depth2" style="display:none;">
									<li><a href="">안내/절차</a></li>
									<li><a href="">인재상</a></li>
									<li><a href="">인사제도</a></li>
									<li><a href="">복리후생</a></li>
									<li><a href="">직무소개</a></li>
									<li><a href="">개인정보 처리방침</a></li>
								</ul>
							</li>
							<li>
								<a href="#" onmouseover="menuClick();">채용공고</a>
								<ul class="depth2" style="display:none;">
									<li><a href="/client/job/jobNotice">채용공고</a></li>
									<li><a href="/client/job/jobNotice">지원서 작성</a></li>
								</ul>
							</li>
							<li>
								<a href="#" onmouseover="menuClick();">채용지원</a>
								<ul class="depth2" style="display:none;">
									<li><a href="/client/job/recViewLogin">지원확인 및 수정</a></li>
									<li><a href="/client/acceptedCheck">합격자 발표</a></li>
									<li><a href="/client/job/searchPwd">비밀번호 찾기</a></li>
								</ul>
							</li>
							<li>
								<a href="#" onmouseover="menuClick();">채용문의</a>
								<ul class="depth2" style="display:none;">
									<li><a href="/client/faq">FAQ</a></li>
									<li><a href="/client/qnaList">1:1 문의</a></li>
									<li><a href="">채용담당자 안내</a></li>
								</ul>
							</li>
							
						</ul>
					</div>
	      </nav>
			</div>
  	</header>
  	<div id="gnb_sub" style="display:none;" onmouseleave="gnbMobuseLeave();"></div>
  	
  	<c:if test="${mainYn ne 'Y' }">
  	
  	
  	<div class="container"> <!-- container 시작, footer.jsp에 끝 태그 있음 -->		
  		
  		 <!-- 왼쪽 메뉴 시작 -->
  		<div class="lnb_wrap lnb_open">
			<!-- 왼쪽 메뉴 접기 : class="lnb_wrap lnb_close" (컨텐츠 영역에도 lnb_close로 클래스 변경)-->
			<a href="#" class="lnb_closebtn">서브 메뉴 닫기</a>
			<!--<a href="" class="lnb_openbtn">서브 메뉴 열기</a>-->
			
			
			
<c:choose>
	<c:when test="${_incLeftMenu eq '1'}">			
			<ul class="lnb_list">
				<li class="title">채용안내</li>
				<li><a href="" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>안내/절차</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>인재상</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>인사제도</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '4'}">class="selected"</c:if>>복리후생</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '5'}">class="selected"</c:if>>직무소개</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '6'}">class="selected"</c:if>>개인정보 처리방침</a></li>
			</ul>
	</c:when>
	<c:when test="${_incLeftMenu eq '2'}">			
			<ul class="lnb_list">
				<li class="title">채용공고</li>
				<li><a href="/client/job/jobNotice" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>채용공고</a></li>
				<li><a href="/client/job/jobNotice" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>지원서 작성</a></li>
			</ul>
	</c:when>
	<c:when test="${_incLeftMenu eq '3'}">			
			<ul class="lnb_list">
				<li class="title">채용지원</li>
				<li><a href="/client/job/recViewLogin" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>지원확인 및 수정</a></li>
				<li><a href="/client/acceptedCheck" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>합격자 발표</a></li>
				<li><a href="/client/job/searchPwd" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>비밀번호 찾기</a></li>
			</ul>
	</c:when>
	<c:when test="${_incLeftMenu eq '4'}">			
			<ul class="lnb_list">
				<li class="title">채용문의</li>
				<li><a href="/client/faq" <c:if test="${_incLeftSub eq '1'}">class="selected"</c:if>>FAQ</a></li>
				<li><a href="/client/qnaList" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>1:1 문의</a></li>
				<li><a href="" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>채용담당자 안내</a></li>
			</ul>
	</c:when>
</c:choose>
		
		</div> <!-- END lnb_wrap -->
  	    <!-- 왼쪽 메뉴 끝 -->
</c:if>  	
  	
  	
  	
  	
  	
  	
  	