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

		$('.jobapp_tab > li').click(function(e) {
			if($(this).data("action")) {
				with (document.recruitForm) {
					action = $(this).data("action");
					target="_self";
					submit();
				}
			} else {
				e.preventDefault();
			}
		});

		$('.jobapp_table').on('keyup', 'textarea', function (e){
			var byteTxt = "";
			var maxlength = $(this).attr("max-length");
			var byte = function(str) {
				var byteNum = 0;
				for(i = 0; i < str.length; i++){
					byteNum += (str.charCodeAt(i) > 127) ? 2 : 1;
					if(byteNum < (maxlength * 2)){
						byteTxt += str.charAt(i);
					};
				};

				return Math.round(byteNum / 2);
			};

			if(byte($(this).val()) > maxlength){
				alert(maxlength + "자 이상 입력할수 없습니다.");
				$(this).val("");
				$(this).val(byteTxt);
			} else {
				//console.log(byte($(this).val()) + '/' + maxlength);
			}

			$(this).css('height', 'auto');
			$(this).height(this.scrollHeight + 30);
		});

		$('.jobapp_table').find('textarea').keyup();

	});

	/************************************************
	* [자기소개서 저장]
	************************************************/
	function recSave() {
		$("#recruitForm").ajaxForm({
			beforeSubmit : function(arr, $form, options) {
				var rApcode = $('#rApCode').val();
				var rIdx = $('#rIdx').val();

				// 자기소개서 default value set
				$('textarea').each(function(index) {
					arr.push(
						{name : 'introList['+index+'].rApCode', value : rApcode}
						, {name : 'introList['+index+'].rIdx', value : rIdx}
					);
				});
			},
			url: "/client/job/saveApplyIntro",
            error : function(){
                alert("서버 에러가 발생하였습니다.");
                return;
            },
            success : function(data){
            	if(data.json.result == 'success') {
            		alert(data.json.msg);
            	} else {
            		if(data.json.errors != null) {
	            		var errors = data.json.errors;
	            		//console.log(errors);

	            		var errorMessage = '';
	            		$.each(errors, function(i, item) {
	            			if(i > 0) errorMessage += "\n";
	            			errorMessage += errors[i].rejectedValue + " : " + errors[i].defaultMessage;
	            		});

	            		alert(errorMessage);
            		} else {
     	       			alert(data.json.msg);
            		}

            		return;
            	}
            }
        });

		$("#recruitForm").submit();
	}

	/************************************************
	* [지원서 제출]
	************************************************/
	function recComplete() {
		with (document.recruitForm) {
			action = "myRecStep05";
			target="_self";
			submit();
		}
	}

	/************************************************
	* [이전]
	************************************************/
	function goPrev() {
		with (document.recruitForm) {
			action = "myRecStep03";
			target="_self";
			submit();
		}
	}

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
				<form method="post" name="recruitForm" id="recruitForm">
				<input type="hidden" name="rApCode" id="rApCode" value="${recruit.rApCode}" />
				<input type="hidden" name="rIdx" id="rIdx" value="${recruit.rIdx}" />
				<input type="hidden" name="editMode" id="editMode" value="${recruit.editMode}" />
				<ul class="jobapp_tab">
					<li data-action="myRecStep01"><span>개인신상</span></li>
					<li data-action="myRecStep02"><span>학력사항</span></li>
					<li data-action="myRecStep03"><span>경력/어학/자격</span></li>
					<li class="current"><span>자기소개서</span></li>
				</ul>

				<h2>자기소개서</h2>
				<table class="jobapp_table list">
					<caption>자기소개서 목록. 지원 직군, 존중, 책임감, 끈기, 직무이해, 직무준비로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				  </colgroup>
					<thead>
						<tr>
							<th colspan="2" class="title"><span class="label">지원직군 : </span>${applyKindNm}</th>
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
										<th>${intro.ITEM_TITLE}</td>
										<td>
											<span class="sd_title">${intro.ITEM_DESC}</span>
											<input type="hidden" name="introList[${status.index}].iSeq" value="${status.index}" />
											<input type="hidden" name="introList[${status.index}].iCode" value="${intro.IDX}" />
											<textarea name="introList[${status.index}].iDesc" class="width_100" rows="4" min-length="10" max-length="${intro.LENGTH_MAX}" placeholder="${intro.LENGTH_MAX}자 이내">${rsApplyIntroList[status.index].I_DESC}</textarea>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				</form>

				<div class="btn_wrap center">
					<a class="btn_a color_b" title="이전" href="" onclick="goPrev();"><span>이전</span></a>
					<a class="btn_a color_d" title="다음 단계로" href="" onclick="recSave();"><span>자기소개서 저장</span></a>
					<a class="btn_a color_a" title="다음 단계로" href="" onclick="recComplete();"><span>지원서 제출</span></a>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 영역 끝 -->

	<c:import url="/inc/footer.jsp"></c:import>
</div>

</body>
</html>