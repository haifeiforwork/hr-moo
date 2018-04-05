<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/cli_doctype.jsp" %>
<head>
<jsp:include page="/inc/cli_typelink.jsp" flush="true" />
<jsp:include page="/inc/cli_typelinkjs.jsp" flush="true" />

<script type="text/javascript">
	var currentYear = new Date().getFullYear();
	var validator;
	$(document).ready(function() {

		$('.btn_a').on('click', function(e) {
			e.preventDefault();
		});

		/************************************************
		* 달력
		************************************************/
		$(".dateinput").moorimDatePicker({dateFormat : 'yy.mm.dd', yearRange : '1960:'+currentYear});
		$('.dateinput').on('keyup', function(event) {
			event.preventDefault();
			$(this).val('');
		});
		$(".dateinput_btn").click(function() {
			$(".dateinput").datepicker("show");
		});

		/************************************************
		* form validation
		************************************************/
		$.validator.setDefaults({
		    onkeyup:false,
		    onclick:false,
		    onfocusout:false,
		    showErrors:function(errorMap, errorList){
		        if(this.numberOfInvalids()) {
		            alert(errorList[0].message);
		        }
		    }
		});

		validator = $("#search_form").validate({
			ignore: "",
			rules: {
				rName: {
					required : true,
					minlength : 2
				},
				rBirth: {
					required : true
				},
				rPwd: {
					required : true,
					minlength : 6,
					maxlength : 12
				},
				chk: {
					required : true
				}
			},
			messages: {
				rName: {
					required : '이름을 입력해주세요.'
					, minlength : $.validator.format('이름은 {0}자 이상이어야 합니다.')
				},
				rBirth: {
					required : '생년월일을 입력해주세요.'
				},
				rPwd: {
					required : '비밀번호를 입력해주세요.'
					, minlength : '비밀번호는 {0}자 이상이어야 합니다.'
					, maxlength : '비밀번호는 {0}자 이하여야 합니다.'
				},
				chk: {
					required : '개인정보처리방침에 동의해주세요.'
				}
			}
		});

	});

	function cancle() {
		with (document.search_form) {
			action = "jobDetail";
			target="_self";
			submit();
		}
	}

	function existCheck() {
		if(!$("#search_form").valid()) {
			validator.focusInvalid();
			return;
		}

		$("#search_form").ajaxForm({
			url: "/client/job/appyExistCheck",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.regCount > 0) {
            		alert("이미 작성중인 지원서가 있습니다.\n지원서수정 메뉴에서 확인하시기 바랍니다.");
            		return;
            	} else {
            		recNext();
            	}
            }
        });

		$("#search_form").submit();
	}

	function recNext() {
		with (document.search_form) {
			action = "myRecStep01";
			target="_self";
			submit();
		}
	}

</script>
<title>무림 채용</title>

</head>
<body>
<div id="wrap">
	<c:import url="/inc/header.jsp?m=2&s=2" />

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
				<form method="post" name="search_form" id="search_form" action="jobNotice">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${pCommon.pageNo}"/>">
					<input type="hidden" name="searchType" value="<c:out value="${pCommon.searchType}"/>">
					<input type="hidden" name="idx" value="<c:out value="${pCommon.idx}"/>">
					<input type="hidden" name="SKEY_1" id="SKEY_1" value="<c:out value="${pCommon.SKEY_1}"/>">
					<input type="hidden" name="rIdx" value="<c:out value="${pCommon.idx}"/>">
					<input type="hidden" name="editMode" value="init">
					<div class="jobapp_login">
						<h1>지원서 작성</h1>
						<ul class="login_list">
							<li class="rec_title">
								<span class="label">공고명</span>
								<span class="title">${rs.R_TITLE}</span>
							</li>
							<li>
								<span class="label">성명</span>
								<input type="text" name="rName" id="rName" />
							</li>
							<li>
								<span class="label">생년월일</span>
								<input type="text" class="dateinput" name="rBirth" id="rBirth" /><a class="dateinput_btn" href="javascript:void(0);" title="날짜검색">날짜검색</a>
							</li>
							<li>
								<span class="label">지원구분</span>
								<select name="rGubun" id="rGubun">
									<c:if test="${rs.R_GUBUN ne '40002'}">
										<option value="40001">신입</option>
									</c:if>
									<c:if test="${rs.R_GUBUN ne '40001'}">
										<option value="40002">경력</option>
									</c:if>
							  	</select>
							</li>
							<li>
								<span class="label">비밀번호</span>
								<input type="password" name="rPwd" id="rPwd" />
								<span class="disc">6~12자리 숫자 또는 문자</span>
							</li>
						</ul>
						<ul class="login_disc">
							<li>입사 지원서 작성시 기재한 비밀번호는 <br /><b>입사 지원서 조회, 수정 및 합격자 발표 확인</b> 시 필요하므로 분실에 유의하시기 바랍니다.</li>
							<li>기타 문의 사항은 <b>채용문의</b>를 이용해 주시기 바랍니다.</li>
						</ul>
					</div>

					<div class="login_privacy">
						<h1>개인정보처리방침</h1>
						<div class="text">
							<div>채용 개인정보 처리방침</div><div><br></div><div>입사지원 시 개인정보 처리방침입니다.</div><div>무림페이퍼, 무림SP, 무림P&amp;P(이하 “회사”라 함)는 개인정보보호법 제30조에 따라 정보주체의 개인정보 및 권익을 보호하고 이와 관련된 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립?공개합니다.</div><div><br></div><div>1. 개인정보 처리목적 및 처리하는 개인정보 항목</div><div>회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행하겠습니다.</div><div><br></div><div>[일반정보]</div><div>-입사지원자 필수항목 처리목적</div><div>지원자의 신원 및 학력,경력의 확인, 과거 지원이력의 관리, 채용 여부의 결정 및 통지, 추가 채용시 지원의사의 확인 등</div><div>-온라인문의자 필수항목 처리 목적</div><div>온라인 문의 접수 및 처리결과 통보</div><div><br></div><div>[고유식별정보]</div><div>-입사지원자 필수항목 처리목적</div><div>본인의 식별 및 확인</div><div><br></div><div>[민감정보]</div><div>-입사지원자 필수항목 처리목적</div><div>건강검진정보</div><div><br></div><div>[시스템 이용정보]</div><div>인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</div><div>-웹사이트 접속에 관한 로그, IP주소, 쿠키, MAC주소</div><div><br></div><div>2. 개인정보 처리 및 보유기간</div><div>(1) 회사는 법령에 따른 개인정보 보유?이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유?이용기간 내에서 개인정보를 처리/보유합니다.</div><div>(2) 개인정보 처리 및 보유 기간은 다음과 같습니다.</div><div><br></div><div>[입사지원자]</div><div>-입사지원 완료 후 3년</div><div>-입사지원자의 개인정보는 회사의 인재DB에 3년간 저장되어, 인재풀 관리, 입사지원자의 면접이력 관리에 이용되며 추가적인 채용이 필요한 경우, 상시 채용을 위하여 이용됩니다.</div><div>-다만, 입사지원자가 개인정보의 삭제를 원하는 경우 지체없이 해당 정보를 삭제합니다.</div><div><br></div><div>[온라인문의자]</div><div>-이용목적 달성 후 지체 없이 파기 처리됩니다.</div><div><br></div><div>3. 개인정보의 제3자 제공</div><div>회사는 정보주체의 개인정보를 제1조(개인정보 처리목적)에서 명시한 범위 내에서만 처리하며, 타인 또는 타기업?기관에 제공하지 않습니다. 단, 정보주체의 동의, 법률의 특별한 규정 등 개인정보보호법 제17조 및 제18조에 해당하는 경우에는 개인정보를 제3자에게 제공합니다.</div><div><br></div><div>4. 개인정보처리의 위탁</div><div>(1)회사는 원활한 개인정보 업무처리를 위해 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</div><div>(2)위탁업체 및 내용</div><div>-이노피플 : 무림 홈페이지 관리(입사지원서 데이터 공유)</div><div>-LG CNS : 채용 시스템 관리 / 유지보수</div><div>-삼성화재 : (입사 후)교육기간 중 사고를 대비한 단체보험 가입</div><div>-한신메디피아,대한산업보건협회(서울산업보건센터,대구산업보건센터),울산중앙병원, 진주고려병원 : (입사 전)입사지원자 채용검진</div><div>(3)회사는 위탁계약 체결시 개인정보보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적?관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</div><div>(4)위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통해 공개하도록 하겠습니다.</div><div><br></div><div>5. 정보주체의 권리?의무 및 행사방법</div><div>(1)정보주체는 개인정보보호법 등 관계 법령이 정하는 바에 따라 회사에 대해 아래와 같은 개인정보보호 관련 권리를 행사할 수 있습니다</div><div>①개인정보열람 요구</div><div>②오류 등이 있을 경우 정정 요구</div><div>③삭제 요구</div><div>④처리정지 요구</div><div>(2)제1항에 따른 권리 행사는 회사에 서면, 전화, 전자우편, FAX 등을 통해 하실 수 있으며, 회사는 본인확인 절차를 거친 후 이에 대해 지체없이 조치하겠습니다.</div><div>(3)정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 해당 개인정보를 이용하거나 제공하지 않습니다.</div><div>(4)제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통해서도 하실 수 있습니다. 이 경우 개인정보보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하여야 합니다.</div><div>(5)정보주체는 개인정보보호법 등 관계 법령을 위반하여 회사가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해해서는 아니됩니다.</div><div>(6)회사는 원칙적으로 만 14세 미만의 정보주체에 대한 개인정보를 수집하지 않습니다. 부득이한 필요로 인해 만 14세 미만자의 개인정보를 수집할 때에는 사전에 그 법정대리인의 동의를 구하겠습니다. 이 경우 법정대리인의 동의를 받기 위해 필요한 최소한의 정보(이름, 연락처)는 법정대리인의 동의없이 해당 만 14세 미만자로부터 직접 수집할 수 있습니다.</div><div><br></div><div>6. 개인정보의 파기</div><div>(1)회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.</div><div>(2)정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성됐음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스로 옮기거나 보관장소를 달리해 보존합니다.</div><div>(3)개인정보 파기절차 및 방법은 다음과 같습니다.</div><div>①파기절차</div><div>회사는 파기사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.</div><div>②파기방법</div><div>회사는 전자적 파일 형태로 기록, 저장된 개인정보는 그 기록을 재생할 수 없는 기술적 방법을 사용해 파기하며, 종이 문서에 기록, 저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</div><div><br></div><div>7. 개인정보의 안전성 확보 조치</div><div>회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.</div><div>(1)관리적 조치: 내부관리계획 수립?시행, 정기적 직원교육 등</div><div>(2)기술적 조치: 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치</div><div>(3)물리적 조치: 전산실, 자료보관실 등의 접근통제</div><div><br></div><div>8. 개인정보 보호책임자</div><div>회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</div><div><br></div><div>담당부서: 인사교육팀</div><div>책임자: 김홍철 팀장</div><div>연락처: 02-3485-1580</div><div>이메일: siruki@moorim.co.kr</div><div><br></div><div>정보주체는 회사의 서비스(또는 사업)을 이용하면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의할 수 있습니다. 회사는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다.</div><div><br></div><div>9. 권익침해 구제방법</div><div>정보주체는 아래의 기관에 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.</div><div>&gt;아래의 기관은 회사와는 별개의 기관으로서, 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우 아래 기관에 문의하시기 바랍니다&lt;</div><div><br></div><div>[개인정보 침해신고센터]</div><div>- 개인정보 침해사실 신고, 상담 신청</div><div>- privacy.kisa.or.kr / (국번없이) 118</div><div>- (우138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</div><div><br></div><div>[개인정보 분쟁조정위원회]</div><div>- 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)</div><div>- privacy.kisa.or.kr / (국번없이) 118</div><div>- (우 138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</div><div><br></div><div>[대검찰청 사이버범죄수사단]</div><div>- www.spo.go.kr / 02-3480-3573</div><div><br></div><div>[경찰청 사이버테러대응센터]</div><div>- www.netan.go.kr / 1566-0112</div><div><br></div><div>10. 그 밖의 개인정보 처리 및 관리에 대한 사항</div><div>회사는 본 방침에 명시하지 않은 사항에 대해서는 개인정보보호법 및 동법 시행령에서 규정한 사항을 따릅니다.</div><div><br></div><div>11. 개인정보 처리방침의 변경 및 공지</div><div>회사의 개인정보 처리방침은 2013년 7월 1일 제정되었으며 관련 법령, 지침 및 회사 내부규정에 따라 변경되는 경우 관련 법령이 정하는 방법에 따라 공개하도록 하겠습니다.</div><div><br></div><div>- 공고일자: 2013년 7월 1일 / 시행일자 : 2013년 9월 3일</div>
						</div>
						<div class="agreement">
							<input type="checkbox" name="chk" id="chk" />
							<label for="chk" class="checklabel">개인정보처리방침에 동의합니다.</label>
						</div>
					</div>
				</form>

				<div class="btn_wrap center">
					<a class="btn_a color_a" title="지원서 작성" href="" onclick="existCheck();"><span>지원서 작성</span></a>
					<a class="btn_a color_c" title="취소" href="" onclick="cancle();"><span>취소</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>