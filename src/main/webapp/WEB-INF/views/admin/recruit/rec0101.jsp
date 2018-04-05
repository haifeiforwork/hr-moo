<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	
	
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">지원서 상세 보기</div>
			<div class="button_area"><a href="" title="닫기" class="close_btn">닫기</a></div>
		</div>
		<div class="popup_contents">

			<table class="contents_table admin marginbottom_20">
				<caption>지원서 지원정보 목록. 채용공고, 수험번호, 지원상태로 구성.</caption>
			  <colgroup>
					<col style="width:120px;" />
			    <col style="width:;" />
					<col style="width:120px;" />
			    <col style="width:;" />
			  </colgroup>
			  <tbody>
			    <tr>
						<th class="text_center">채용공고</th>
			      <td>
							공고명
						</td>
						<th class="text_center">수험번호</th>
			      <td class="text_center">
							${rsDetail.R_AP_CODE }
						</td>
			    </tr>
			    <tr>
						<th class="text_center">지원상태</th>
			      <td colspan="3">
			      			${rsDetail.R_STATUS_CODE_NM }
						</td>
			    </tr>
			  </tbody>
			</table>

			<h2>기본정보</h2>
			<table class="jobapp_table">
				<caption>기본정보 목록. 성명, 생년월일, 성별, 나이, 응시직무로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			    <col style="width:170px;" />
			  </colgroup>
				<tbody>
					<tr>
						<th><span class="req">성명</span></th>
						<td>
							<span class="labelset">
								<span class="label">한글</span>
								${rsDetail.R_NAME}
							</span>
							<span class="labelset">
								<span class="label">한자</span>
								${rsDetail.R_HNAME}
							</span>
							<br  />
							<span class="labelset margintop_10">
								<span class="label">영문</span>
								${rsDetail.R_ENAME}
							</span>
						</td>
						<td rowspan="4" class="photo">
							<c:choose>
								<c:when test="${not empty rsDetail.R_PHOTO}">
									<c:set var="photoFile" value="${fn:split(rsDetail.R_PHOTO,'*')}" />
									<img src="${pageContext.request.contextPath}/client/job/getPic?pic_no=${photoFile[0]}" id="photoPreview" />
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/resources/images/no_photo.jpg" id="photoPreview" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><span class="req">생년월일</span></th>
						<td>
							${fn:substring(rsDetail.R_BIRTH, 0, 4)}년 ${fn:substring(rsDetail.R_BIRTH, 4, 6)}월 ${fn:substring(rsDetail.R_BIRTH, 6, 8)}일 
							<c:if test="${rsDetail.R_BIRTH_CODE eq '1'}">(양력)</c:if>
						    <c:if test="${rsDetail.R_BIRTH_CODE eq '2'}">(음력)</c:if>
						</td>
					</tr>
					<tr>
						<th><span class="req">성별</span></th>
						<td>
							<c:if test="${rsDetail.R_SEX_CODE eq '1'}">남자</c:if>
						    <c:if test="${rsDetail.R_SEX_CODE eq '2'}">여자</c:if>
						</td>
					</tr>
					<tr>
						<th><span>나이</span></th>
						<td>
							만 ${rsDetail.R_AGE}세
						</td>
					</tr>
					<tr>
						<th rowspan="2" class="endrow"><span class="req">응시직무</span></th>
						<td colspan="3">
							1지망 : ${rsDetail.R_JOB_KIND_CODE1_NM} - ${rsDetail.R_JOB_PART_CODE1_NM} - ${rsDetail.R_JOB_AREA_CODE1_NM}
						</td>
					</tr>
					<tr>
						<td colspan="3">
							2지망 : ${rsDetail.R_JOB_KIND_CODE2_NM} - ${rsDetail.R_JOB_PART_CODE2_NM} - ${rsDetail.R_JOB_AREA_CODE2_NM}
						</td>
					</tr>
				</tbody>
			</table>

			<h2>연락처</h2>
			<table class="jobapp_table">
				<caption>연락처 목록. 주소, 연락처, 이메일주소로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			  </colgroup>
				<tbody>
					<tr>
						<th rowspan="2"><span class="req">주소</span></th>
						<td>
							(${rsDetail.R_POST}) ${rsDetail.R_ADDR1}
						</td>
					</tr>
					<tr>
						<td>
							${rsDetail.R_ADDR2}
						</td>
					</tr>
					<tr>
						<th rowspan="2"><span class="req">연락처</span></th>
						<td>
							<span class="label">유선번호</span>
							${rsDetail.R_TEL}
						</td>
					</tr>
					<tr>
						<td>
							<span class="label">무선번호</span>
							${rsDetail.R_HP}
						</td>
					</tr>
					<tr>
						<th><span class="req">이메일주소</span></th>
						<td>
							${rsDetail.R_EMAIL}
						</td>
					</tr>
				</tbody>
			</table>

			<h2>보훈/병력사항</h2>
			<table class="jobapp_table">
				<caption>보훈/병력사항 목록. 보훈, 병력사항으로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			  </colgroup>
				<tbody>
					<tr>
						<th rowspan="2"><span>보훈</span></th>
						<td>
							<span class="labelset">
								<span class="label">보훈종류</span>
								${rsDetail.R_BOHUN_KIND_NM }
							</span>
							<span class="labelset">
								<span class="label">보훈번호</span>
								${rsDetail.R_BOHUN_NUM }
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="label">보훈자관계</span>
								<c:choose>
									<c:when test="${rsDetail.R_BOHUN_RELATION eq '부'}">부</c:when> 
									<c:when test="${rsDetail.R_BOHUN_RELATION eq '모'}">모</c:when> 
									<c:when test="${rsDetail.R_BOHUN_RELATION eq '조부'}">조부</c:when>
									<c:when test="${rsDetail.R_BOHUN_RELATION eq '조모'}">조모</c:when>
									<c:when test="${rsDetail.R_BOHUN_RELATION eq '본인'}">본인</c:when>
								</c:choose>
						</td>
					</tr>
					<tr>
						<th rowspan="4"><span>병력사항</span></th>
						<td>
							<span class="labelset">
								<span class="label">역종</span>
								${rsDetail.R_ARMY_KIND_NM}
							</span>
							<span class="labelset">
								<span class="label">군별</span>
								${rsDetail.R_ARMY_TYPE_NM}
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="labelset">
								<span class="label">병과</span>
								${rsDetail.R_ARMY_BRANCH_NM}
							</span>
							<span class="labelset">
								<span class="label">계급</span>
								${rsDetail.R_ARMY_CLASS_NM}
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="labelset">
								<span class="label">복무기간</span>
								<c:set var="armySdateYear" value="${fn:substring(rsDetail.R_ARMY_SDATE, 0, 4)}" />
								<c:set var="armySdateMonth" value="${fn:substring(rsDetail.R_ARMY_SDATE, 5, 6)}" />
								<c:set var="armyEdateYear" value="${fn:substring(rsDetail.R_ARMY_EDATE, 0, 4)}" />
								<c:set var="armyEdateMonth" value="${fn:substring(rsDetail.R_ARMY_EDATE, 5, 6)}" />
								${armySdateYear }년 ${armySdateMonth }월 ~ ${armyEdateYear }년 ${armyEdateMonth }년
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="labelset">
								<span class="label">면제사유</span>
								${rsDetail.R_ARMY_EXCEPT_REASON}
						</td>
					</tr>
				</tbody>
			</table>

			<h2>학력사항</h2>
			<table class="jobapp_table">
				<caption>학력사항 목록. 고등학교, (전문)대학, 대학교, 대학교(편입 시), 석사, 박사로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			  </colgroup>
				<tbody>
					<tr>
						<th rowspan="2">고등학교</th>
						<td>
							${rsSchool0.S_NAME}
							/계열: ${rsSchool0.S_MAJOR_GROUP_NM}
							/과: ${rsSchool0.S_MAJOR}
							/${rsSchool0.S_DN_CODE_NM}
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool0.S_ENT_MONTH}" var="ent0Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent0Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool0.S_GRA_MONTH}" var="gra0Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra0Month}" pattern="yyyy년 MM월"/> (${rsSchool0.S_GRA_TYPE_NM })
						</td>
					</tr>
					<tr>
						<th rowspan="2">(전문)대학</th>
						<td>
							${rsSchool1.S_NAME}
							/계열: ${rsSchool1.S_MAJOR_GROUP_NM}
							/과: ${rsSchool1.S_MAJOR}
							/${rsSchool1.S_DN_CODE_NM}
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool1.S_ENT_MONTH}" var="ent1Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent1Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool1.S_GRA_MONTH}" var="gra1Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra1Month}" pattern="yyyy년 MM월"/> (${rsSchool1.S_GRA_TYPE_NM })
						</td>
					</tr>
					<tr>
						<th rowspan="2">대학교</th>
						<td>
							${rsSchool2.S_NAME}
							/계열: ${rsSchool2.S_MAJOR_GROUP_NM}
							/과: ${rsSchool2.S_MAJOR}
							/${rsSchool2.S_DN_CODE_NM}
							/${rsSchool2.S_BP_CODE_NM} 
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool2.S_ENT_MONTH}" var="ent2Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent2Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool2.S_GRA_MONTH}" var="gra2Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra2Month}" pattern="yyyy년 MM월"/> (${rsSchool2.S_GRA_TYPE_NM })
						</td>
					</tr>
					<tr>
						<th rowspan="2">대학교(편입 시)</th>
						<td>
							${rsSchool3.S_NAME}
							/계열: ${rsSchool3.S_MAJOR_GROUP_NM}
							/과: ${rsSchool3.S_MAJOR}
							/${rsSchool3.S_DN_CODE_NM}
							/${rsSchool3.S_BP_CODE_NM} 
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool3.S_ENT_MONTH}" var="ent3Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent3Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool3.S_GRA_MONTH}" var="gra3Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra3Month}" pattern="yyyy년 MM월"/> (${rsSchool3.S_GRA_TYPE_NM })
						</td>
					</tr>
					<tr>
						<th rowspan="2">석사</th>
						<td>
							${rsSchool4.S_NAME}
							/계열: ${rsSchool4.S_MAJOR_GROUP_NM}
							/과: ${rsSchool4.S_MAJOR}
							/${rsSchool4.S_DN_CODE_NM}
							/${rsSchool4.S_BP_CODE_NM} 
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool4.S_ENT_MONTH}" var="ent4Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent4Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool4.S_GRA_MONTH}" var="gra4Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra4Month}" pattern="yyyy년 MM월"/> (${rsSchool4.S_GRA_TYPE_NM })
						</td>
					</tr>
					<tr>
						<th rowspan="2">박사</th>
						<td>
							${rsSchool5.S_NAME}
							/계열: ${rsSchool5.S_MAJOR_GROUP_NM}
							/과: ${rsSchool5.S_MAJOR}
							/${rsSchool5.S_DN_CODE_NM}
							/${rsSchool5.S_BP_CODE_NM} 
						</td>
					</tr>
					<tr>
						<td>
							<fmt:parseDate value="${rsSchool5.S_ENT_MONTH}" var="ent5Month" pattern="yyyyMM" />
							<fmt:formatDate value="${ent5Month}" pattern="yyyy년 MM월"/>(입학)
							~
							<fmt:parseDate value="${rsSchool5.S_GRA_MONTH}" var="gra5Month" pattern="yyyyMM" />
							<fmt:formatDate value="${gra5Month}" pattern="yyyy년 MM월"/> (${rsSchool5.S_GRA_TYPE_NM }) 
							
						</td>
					</tr>
				</tbody>
			</table>

			<h2>성적</h2>
			<table class="jobapp_table list">
				<caption>성적 목록. 고등학교, (전문)대학, 대학교, 대학교(편입 시), 석사, 박사로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			    <col style="width:15%;" />
			    <col style="width:15%;" />
			    <col style="width:15%;" />
			    <col style="width:15%;" />
			    <col style="width:15%;" />
			  </colgroup>
				<tbody>
					<tr>
						<th rowspan="3">고등학교</th>
						<th class="text_center"></th>
						<th class="text_center">1학년</th>
						<th class="text_center">2학년</th>
						<th class="text_center">3학년</th>
						<th rowspan="3" class="text_center"></th>
						<th class="text_center">평점</th>
					</tr>
					<tr>
						<td><span class="label">1학기</span></td>
						<td><c:out value="${rsGrade0.S_SCORE_11}" /> </td>
						<td><c:out value="${rsGrade0.S_SCORE_21}" /></td>
						<td><c:out value="${rsGrade0.S_SCORE_31}" /></td>
						<td rowspan="2">${rsGrade0.S_SCORE_AVG}/${rsGrade0.S_SCORE_FULL}</td>
					</tr>
					<tr>
						<td><span class="label">2학기</span></td>
						<td><c:out value="${rsGrade0.S_SCORE_12}"/></td>
						<td><c:out value="${rsGrade0.S_SCORE_22}"/></td>
						<td><c:out value="${rsGrade0.S_SCORE_32}"/></td>
					</tr>
					<tr>
						<th rowspan="3">대학/대학교</th>
						<th class="text_center"></th>
						<th class="text_center">1학년</th>
						<th class="text_center">2학년</th>
						<th class="text_center">3학년</th>
						<th class="text_center">4학년</th>
						<th class="text_center">평점</th>
					</tr>
					<tr>
						<td><span class="label">1학기</span></td>
						<td><c:out value="${rsGrade1.S_SCORE_11}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_21}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_31}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_41}"/></td>
						<td rowspan="2">${rsGrade1.S_SCORE_AVG}/${rsGrade1.S_SCORE_FULL}</td>
					</tr>
					<tr>
						<td><span class="label">2학기</span></td>
						<td><c:out value="${rsGrade1.S_SCORE_12}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_22}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_32}"/></td>
						<td><c:out value="${rsGrade1.S_SCORE_42}"/></td>
					</tr>
					<tr>
						<th rowspan="3">석사</th>
						<th class="text_center"></th>
						<th class="text_center">1학년</th>
						<th class="text_center">2학년</th>
						<th rowspan="3" class="text_center"></th>
						<th rowspan="3" class="text_center"></th>
						<th class="text_center">평점</th>
					</tr>
					<tr>
						<td><span class="label">1학기</span></td>
						<td><c:out value="${rsGrade2.S_SCORE_11}"/></td>
						<td><c:out value="${rsGrade2.S_SCORE_21}"/></td>
						<td rowspan="2">${rsGrade2.S_SCORE_AVG}/${rsGrade2.S_SCORE_FULL}</td>
					</tr>
					<tr>
						<td><span class="label">2학기</span></td>
						<td><c:out value="${rsGrade2.S_SCORE_12}"/></td>
						<td><c:out value="${rsGrade2.S_SCORE_12}"/></td>
					</tr>
					<tr>
						<th rowspan="2">석사논문</th>
						<td><span class="label">논문제목</span></td>
						<td colspan="5" class="text_left">
							<c:out value="${rsGrade2.S_THESIS1}" />
						</td>
					</tr>
					<tr>
						<td><span class="label">파일명</span></td>
						<td colspan="5" class="text_left">
							<c:set var="sThesis1File" value="${fn:split(rsGrade2.S_THESIS1_FILE,'*')}" />
							<a class="file" id="btn-file1-upload" href="javascript:void(0);">${sThesis1File[1]}</a>
						</td>
					</tr>
					<tr>
						<th rowspan="2">박사</th>
						<td><span class="label">논문제목</span></td>
						<td colspan="5" class="text_left">
							<c:out value="${rsGrade2.S_THESIS2}" />
						</td>
					</tr>
					<tr>
						<td><span class="label">파일명</span></td>
						<td colspan="5" class="text_left">
							<c:set var="sThesis2File" value="${fn:split(rsGrade2.S_THESIS2_FILE,'*')}" />
							<a class="file" id="btn-file1-upload" href="javascript:void(0);">${sThesis2File[1]}</a>
						</td>
					</tr>
				</tbody>
			</table>

			<h2>경력사항</h2>
			<table class="jobapp_table list">
				<caption>경력사항 목록. 근무지 명, 부서명, 연봉, 직급, 담당업무, 근무기간, 수행업무, 근무지 유형, 사직사유 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:130px;" />
			    <col style="width:260px;" />
			    <col style="width:;" />
			    <col style="width:;" />
			    <col style="width:;" />
			  </colgroup>
				<thead>
					<tr>
						<th colspan="2">회사/부서</th>
						<th>기간</th>
						<th>연봉</th>
						<th>직급</th>
						<th>담당업무</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty rsCareer }">
						<tr>
							<td colspan="6">
								등록된 경력사항이 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${rsCareer.size() > 0}">
						<c:forEach items="${rsCareer }" var="list" varStatus="idx">
							<tr>
								<td colspan="2">
									<c:out value="${list.C_NAME }" />/<c:out value="${list.C_PART }" />
								</td>
								<td>
									<fmt:parseDate value="${list.C_SMONTH}" var="C_SMONTH" pattern="yyyyMM" />
									<fmt:formatDate value="${C_SMONTH}" pattern="yyyy년 MM월"/>
									~
									<fmt:parseDate value="${list.C_EMONTH}" var="C_EMONTH" pattern="yyyyMM" />
									<fmt:formatDate value="${C_EMONTH}" pattern="yyyy년 MM월"/>
								</td>
								<td>
									<c:out value="${list.C_INCOME}" />
								</td>
								<td>
									<c:out value="${list.C_POSITION}" />
								</td>
								<td>
									<c:out value="${list.C_WORK}" />
								</td>
							</tr>
							<tr>
								<td><span class="label">수행업무</span></td>
								<td colspan="5" class="text_left">
									<c:out value="${list.C_PERFORM}" />
								</td>
							</tr>
							<tr class="endrow">
								<td><span class="label">사직사유</span></td>
								<td colspan="5" class="text_left">
									<c:out value="${list.C_REASON}" />
								</td>
							</tr>
						</c:forEach>
					</c:if>	
				</tbody>
				
			</table>

			<h2>교환학생 및 어학연수</h2>
			<table class="jobapp_table list">
				<caption>교환학생 및 어학연수 목록. 구분, 국가, 기관, 기간, 총 이수학기, 삭제로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			    <col style="width:;" />
			    <col style="width:260px;" />
			    <col style="width:;" />
			  </colgroup>
				<thead>
					<tr>
						<th>구분</th>
						<th>국가</th>
						<th>기관</th>
						<th>기간</th>
						<th>총 이수학기</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty rsTraining }">
						<tr>
							<td colspan="5">
								등록된 자료가 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${rsTraining.size() > 0}">
						<c:forEach items="${rsTraining }" var="list" varStatus="idx">
							<tr>
								<td>
									<c:out value="${list.T_GUBUN_CODE }"/>
								</td>
								<td>
									<c:out value="${list.T_NAT_CODE_NM }"/>
								</td>
								<td>
									<c:out value="${list.T_INSTITUTION }"/>
								</td>
								<td>
									<fmt:parseDate value="${list.T_SDATE}" var="T_SDATE" pattern="yyyyMMdd" />
									<fmt:formatDate value="${T_SDATE}" pattern="yyyy.MM.dd"/>
									~
									<fmt:parseDate value="${list.T_EDATE}" var="T_EDATE" pattern="yyyyMMdd" />
									<fmt:formatDate value="${T_EDATE}" pattern="yyyy.MM.dd"/>
								</td>
								<td>
									<c:out value="${list.T_TERM }"/>
								</td>
							</tr>
						</c:forEach>
					</c:if>	
				</tbody>
			</table>

			<h2>어학능력</h2>
			<table class="jobapp_table list">
				<caption>어학능력 목록. 외국어명, 시험명, 점수(급), 평가일, 주관처, 삭제로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:270px;" />
			    <col style="width:;" />
			    <col style="width:140px;" />
			    <col style="width:;" />
			  </colgroup>
				<thead>
					<tr>
						<th>외국어명</th>
						<th>시험명</th>
						<th>점수(급)</th>
						<th>평가일</th>
						<th>주관처</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty rsLanguage }">
						<tr>
							<td colspan="5">
								등록된 자료가 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${rsLanguage.size() > 0}">
						<c:forEach items="${rsLanguage }" var="list" varStatus="idx">
							<tr>
								<td>
									<c:out value="${list.L_LANGUAGE_NM }" />
								</td>
								<td>
									<c:out value="${list.L_EXAM_NM }" />
								</td>
								<td>
									<c:out value="${list.L_SCORE }" />
								</td>
								<td>
									<fmt:parseDate value="${list.L_EDATE}" var="L_EDATE" pattern="yyyyMMdd" />
									<fmt:formatDate value="${L_EDATE}" pattern="yyyy.MM.dd"/>
								</td>
								<td>
									<c:out value="${list.L_INSTIT }" />
								</td>
							</tr>
						</c:forEach>
					</c:if>	
				</tbody>
			</table>

			<h2>자격사항</h2>
			<table class="jobapp_table list">
				<caption>자격사항 목록. 자격증 명, 등급, 평가일, 발행처, 삭제로 구성.</caption>
			  <colgroup>
			    <col style="width:400px;" />
			    <col style="width:;" />
			    <col style="width:140px;" />
			    <col style="width:;" />
			  </colgroup>
				<thead>
					<tr>
						<th>자격증 명</th>
						<th>등급</th>
						<th>취득일</th>
						<th>발행처</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty rsCert }">
						<tr>
							<td colspan="5">
								등록된 자료가 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${rsCert.size() > 0}">
						<c:forEach items="${rsCert }" var="list" varStatus="idx">
							<tr>
								<td>
									<c:out value="${list.C_NAME }" />
								</td>
								<td>
									<c:out value="${list.C_GRADE_NM }" />
								</td>
								<td>
									<fmt:parseDate value="${list.C_EDATE}" var="C_EDATE" pattern="yyyyMMdd" />
									<fmt:formatDate value="${C_EDATE}" pattern="yyyy.MM.dd"/>
								</td>
								<td>
									<c:out value="${list.C_INSTIT }" />
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>

			<h2>자기소개서</h2>
			<table class="jobapp_table list">
				<caption>자기소개서 목록. 지원 직군, 존중, 책임감, 끈기, 직무이해, 직무준비로 구성.</caption>
			  <colgroup>
			    <col style="width:130px;" />
			    <col style="width:;" />
			  </colgroup>
				<thead>
					<tr>
						<th>선택</th>
						<th>직군 : ${rsDetail.R_JOB_KIND_CODE1_NM} / 구분 : ${rsDetail.R_GUBUN_NM}</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${rsIntroList.size() < 1}">
                                <tr>
				                    <td colspan="2">항목이 없습니다.</td>
                                 </tr>							
						</c:when>
						<c:otherwise>
							<c:forEach var="intro" items="${rsIntroList}" varStatus="status">
								<tr>
									<th rowspan="2">${intro.ITEM_TITLE}</th>
									<td class="text_left">
										${intro.ITEM_DESC}
									</td>
								</tr>
								<tr>
									<td class="text_left">
										${rsIntro[status.index].I_DESC}
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<div class="btn_wrap center">
				<a class="btn_a color_b" title="닫기" href='javascript:window.open("about:blank", "_self").close();'><span>닫기</span></a>
			</div>

		</div>
	</div>
</body>
</html>