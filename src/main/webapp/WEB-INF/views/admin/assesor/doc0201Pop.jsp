<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp"%>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />

<style type="text/css">
  .tooltipUI{
    background-color:#FAF4C0;
  }
  .ui-tooltip {
    padding: 8px;
    position: absolute;
    z-index: 9999;
    max-width: 600px;
    -webkit-box-shadow: 0 0 5px #aaa;
    box-shadow: 0 0 5px #aaa;
  }
  body .ui-tooltip {
    border-width: 2px;
  }
</style>
 
<script type="text/javascript">
  $(function() {
    $(document).tooltip({
      tooltipClass:'tooltipUI',
      content: function(callback) {
        callback($(this).prop('title'));
      }
    });
  });
</script>



<script type="text/javascript">
var validator;

	$(document).ready(function() {
		formValidation()
		
		$("input[name*=evIScore]").on("click", function(){
			setScore();
		})
		
	});
	
	/************************************************
	* form validation
	************************************************/
	function formValidation(){
		
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
		
		jQuery.extend(jQuery.validator.messages, {
			required:"{0}을(를) 입력해주세요.",
			number:"{0}는 숫자만 입력할 수 있습니다."
		});
		
		<c:if test="${rs.R_GUBUN eq '40001' }">
			<c:if test="${intro.IDX eq '6' }">
				
			</c:if>
		</c:if>
		<c:if test="${rs.R_GUBUN eq '40002' }">
			<c:if test="${intro.IDX eq '4' or intro.IDX eq '5'}">
				<c:set var="flag" value="1"/>
			</c:if>
		</c:if>
		
		validator = $("#iForm").validate({
			ignore : "",
			rules :{
				 <c:if test="${rs.R_GUBUN eq '40001' }">
				      evIScore111     : {required : ['1-1-1번문항']}
				    , evIScore112     : {required : ['1-1-2번문항']}
				    , evIScore113     : {required : ['1-1-3번문항']}
				    , evIScore121     : {required : ['1-2-1번문항']}
				    , evIScore122     : {required : ['1-2-2번문항']}
				    , evIScore123     : {required : ['1-2-3번문항']}
				    , evIScore131     : {required : ['1-3-1번문항']}
				    , evIScore132     : {required : ['1-3-2번문항']}
				    , evIScore133     : {required : ['1-3-3번문항']}
				    , evIScore211     : {required : ['1-4-1번문항']}
				    , evIScore212     : {required : ['1-4-2번문항']}
				    , evIScore213     : {required : ['1-4-3번문항']}
				    , evIScore221     : {required : ['1-5-1번문항']}
				    , evIScore222     : {required : ['1-5-2번문항']}
				    , evIScore223     : {required : ['1-5-3번문항']}
				</c:if>
				 <c:if test="${rs.R_GUBUN eq '40002' }">
				      evIScore111     : {required : ['1-1-1번문항']}
				    , evIScore112     : {required : ['1-1-2번문항']}
				    , evIScore113     : {required : ['1-1-3번문항']}
				    , evIScore121     : {required : ['1-2-1번문항']}
				    , evIScore122     : {required : ['1-2-2번문항']}
				    , evIScore123     : {required : ['1-2-3번문항']}
				    , evIScore131     : {required : ['1-3-1번문항']}
				    , evIScore132     : {required : ['1-3-2번문항']}
				    , evIScore133     : {required : ['1-3-3번문항']}
				    , evIScore231     : {required : ['1-4-1번문항']}
				    , evIScore232     : {required : ['1-4-2번문항']}
				    , evIScore233     : {required : ['1-4-3번문항']}
				</c:if>
			}
		});
	}
	
	
	function goSave(){

		if(!$("#iForm").valid()) {
			validator.focusInvalid();
			return false;
		}
		
		$.ajax({
			type: 'POST',
			url: "/admin/common/evalItmProcess",
			data: $("#iForm").serialize(),
			async: false,
	        cache: false,
	        beforeSend:function(){

	        },
			success: function(data) {
				if(data.json.result == "success"){
					alert(data.json.msg);
					opener.parent.location.reload();
            		window.close();
				}else{
					$("#iForm").afterSubmitRenameForView();
					alert(data.json.msg);
				}
				
			},
			error : function() {
				$("#iForm").afterSubmitRenameForView();
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	
	function setScore(){
		var score = 0;
		$("input[name*=evIScore]:checked").each(function(){
			var s = $.trim($(this).val());
			var n = parseInt(s);
			score = score + n;
			
		})
		
		$("#score").text(score);
	}
</script>
<title>무림HR</title>
</head>
<body>
	<!-- popup : 자격증 명 검색 팝업 (팝업 사이즈 : 1000*700)-->
	<div class="popup_wrap">
		<div class="popup_head">
			<div class="title">자기소개서 평가</div>
			<div class="button_area">
				<a href="" title="닫기" class="close_btn">닫기</a>
			</div>
		</div>
		<div class="popup_contents">

			<div class="table_header admin">
				<div class="btn_area">
					<c:if test="${procType eq 'new' }">
						<a href="javascript:void(0);" onclick="addMenuTemplate();" class="btn_c color_a additem"><span>추가</span></a>
					</c:if>
					
				</div>
			</div>
			
			<form id="iForm" name="iForm" method="post">
				<input type="hidden" name="evIUserId">
				<input type="hidden" name="evINoticeIdx" value="${vo.rIdx }">
				<input type="hidden" name="evApCode" value="${vo.rApCode }">
			
			
			
			
				<table class="jobapp_table list">
					<caption>자기소개서 목록. 지원 직군, 존중, 책임감, 끈기, 직무이해, 직무준비로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				  </colgroup>
					<tbody>
						<tr>
							<th>지원자</th>
							<td>${rs.R_NAME }</td>
							<th>생년월일</th>
							<td>
								<fmt:parseDate var="R_BIRTH" value="${rs.R_BIRTH }" pattern="yyyyMMdd"/>
								<fmt:formatDate value="${R_BIRTH }" pattern="yyyy.MM.dd"/>
							</td>
							<th>구분</th>
							<td>${rs.R_GUBUN_NM }</td>
							<th>지원직무</th>
							<td>${rs.R_JOB_KIND_CODE1_NM} - ${rs.R_JOB_PART_CODE1_NM }</td>
						</tr>
					</tbody>
				</table>
				
				<table class="jobapp_table list">
					<caption>자기소개서 목록. 지원 직군, 존중, 책임감, 끈기, 직무이해, 직무준비로 구성.</caption>
				  <colgroup>
				    <col style="width:130px;" />
				    <col style="width:;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				    <col style="width:130px;" />
				  </colgroup>
					<thead>
						<tr>
							<th>항목</th>
							<th>자기소개서 내용</th>
							<th>평가</th>
							<th>1</th>
							<th>3</th>
							<th>5</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="cnt" value="1"/>
						<c:set var="dp" value="style='display: none;'" />
						<c:set var="flag" value="0"/>
						<c:forEach var="intro" items="${introList }" varStatus="idx">
							<c:if test="${rs.R_GUBUN eq '40001' }">
								<c:if test="${intro.IDX eq '6' }">
									<c:set var="flag" value="1"/>
								</c:if>
							</c:if>
							<c:if test="${rs.R_GUBUN eq '40002' }">
								<c:if test="${intro.IDX eq '4' or intro.IDX eq '5'}">
									<c:set var="flag" value="1"/>
								</c:if>
							</c:if>
							
							<tr <c:if test="${flag eq 1 }">${dp }</c:if>>
								<th rowspan="3">${intro.ITEM_TITLE}</td>
								<td rowspan="3">
									<c:out value="${intro.I_DESC }"></c:out>
								</td>
								<td><a href="#" title="${itemList[idx.index][0].E_CONTENT}">${itemList[idx.index][0].E_ITEM}</a></td>
								<td>
									<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }1" value="1" >
									
								</td>
								<td>
									<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }1" value="3" >
								</td>
								<td>
									<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }1" value="5" >
								</td>
							</tr>
							<c:forEach var="item" items="${itemList[idx.index]}" varStatus="idx2">
								<c:if test="${idx2.index gt 0 }">
									<tr <c:if test="${flag eq 1 }">${dp }</c:if>>
										<td><a href="#" title="${item.E_CONTENT}">${item.E_ITEM}</a></td>
										<td>
											<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }${idx2.count }" value="1" >
										</td>                                     
										<td>                                      
											<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }${idx2.count }" value="3" >
										</td>                                     
										<td>                                      
											<input type="radio" name="evIScore${intro.IDX le 3 ? '1' : '2' }${cnt }${idx2.count }" value="5" >
										</td>
									</tr>
								</c:if>
							</c:forEach>
							
							<c:set var="cnt" value="${cnt+1 }"/>
							<c:if test="${cnt gt 3  }">
								<c:set var="cnt" value="1"/>
							</c:if>
							<c:set var="flag" value="0"/>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<th colspan="3">평가합계</th>
							<td colspan="3" id="score">0</td>
						</tr>
					</tfoot>
				</table>
			</form>
			<div class="btn_wrap center">
				<a href="javascript:void(0);" onclick="goSave();" class="btn_c color_a additem"><span>저장</span></a>
				<a class="btn_a color_b" title="닫기" href='javascript:window.close();'><span>닫기</span></a>
			</div>
		</div>
	</div>
</body>
</html>