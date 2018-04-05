<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<c:set var="time"><%=System.currentTimeMillis()%></c:set>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="/resources/css/layout_admin.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/object.css" />
<script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#skey_1").focus();
		$("#skey_1").keyup(function(event){
	        if(event.which == 13) {
	            $(".search_btn").click();
	        }
		});
		
		
	});
	
	function linkPage(pageNo) {
		$("#pageNo").val(pageNo);
		$('#search_form').submit();
	}
	
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
	<div class="table_search">
		<div class="input_area">
		<form name="search_form" id="search_form" method="get" action="qnaList">
			<table>
				<caption>검색 조건 테이블</caption>
				<tbody>
					<tr>
						<th>
							EP 직원 검색
						</th>
						<td>
						<select name="searchType">
								<option value="">전체</option>
								<option value="1" <c:if test="${pCommon.searchType eq '1'}"> selected</c:if>>이름</option>
								<option value="2" <c:if test="${pCommon.searchType eq '2'}"> selected</c:if>>사번</option>
								<option value="3" <c:if test="${pCommon.searchType eq '3'}"> selected</c:if>>직급</option>
								<option value="4" <c:if test="${pCommon.searchType eq '4'}"> selected</c:if>>사업장</option>
								<option value="5" <c:if test="${pCommon.searchType eq '5'}"> selected</c:if>>부서</option>
							</select> 
							<input type="text" name="SKEY_1" id="skey_1" value="<c:out value="${pCommon.SKEY_1}"/>"> 
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		</div>
		<div class="btn_area">
			<a class="search_btn" href="#" onclick="javascript:document.search_form.submit();" title="검색"><span>검색</span></a>
		</div>
	</div>
			<table class="list_table admin">
				<caption>사용자 목록. 사번, 성명, 직급, 사업장, 부서</caption>
			  <colgroup>
			    <col style="width:90px;" />
			    <col style="width:80px;" />
			    <col style="width:80px;" />
			    <col style="width:120px;" />
			    <col style="width:120px;" />
			    <col style="width:" />
			  </colgroup>
			  <thead>
			    <tr>
			      <th>사번</th>
			      <th>성명</th>
			      <th>직급</th>
			      <th>사업장</th>
			      <th>부서</th>
			      <th>등록</th>
			    </tr>
			  </thead>
			  <tbody>
					<c:choose>
						<c:when test="${rsList.size() < 1 }">
							<tr>
								<td colspan="5">검색된 사용자가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${rsList }" varStatus="status">
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
									${list.WORK_GROUP }</td>
									<td class="left">
									<select name="user_auth" id="user_auth">
										<option value>사용자그룹</option>
										<c:if test="${not empty authCode}">
								    		<c:forEach var="code" items="${authCode}" varStatus="status">
							    				<option value="${code.code}" <c:if test="${list.USER_AUTH eq code.code}">selected</c:if>>${code.name}</option>
								    		</c:forEach>
								    	</c:if>
									</select>
									<td class="center">
									${list.USE_YN }</td>
									<td class="center">
									수정 삭제</td>
									
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
</div>
</body>
</html>