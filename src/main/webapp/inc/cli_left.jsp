<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="_incLeftMenu" value="${param.m}" />
<c:set var="_incLeftSub" value="${param.s}" />
			
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
						<a href="/admin/recruit/rec0001" >공고 조회</a>
					</li>
					<li>
						<a href="/admin/recruit/rec0002" >공고 등록</a>
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
						<a href="#" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>평가위원 등록</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>서류전형</a>
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
						<a href="#" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>학과등록</a>
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
						<a href="#" <c:if test="${_incLeftSub eq '2'}">class="selected"</c:if>>메뉴 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '3'}">class="selected"</c:if>>공통코드 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '4'}">class="selected"</c:if>>자기소개서 항목 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '5'}">class="selected"</c:if>>서류평가 가중치 관리</a>
					</li>
					<li>
						<a href="#" <c:if test="${_incLeftSub eq '6'}">class="selected"</c:if>>일괄 다운로드</a>
					</li>
					
					
				</ul>

</c:when>
</c:choose>
			</div>
