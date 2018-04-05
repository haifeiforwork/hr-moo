<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" /><!DOCTYPE html>

<script type="text/javascript">
	var validator;
	var currentYear = new Date().getFullYear();
	$(document).ready(function() {
		
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
			number:"{0}는 숫자만 입력할 수 있습니다.",
			digits:"{0}은 숫자만 입력할 수 있습니다."
		});
		jQuery.validator.addMethod('selectcheck', function (value, element, params) {
	        return (value != '');
	    }, jQuery.validator.format("{0}을(를) 선택해주세요."));
		
		validator = $("#listForm").validate();
		
		$("input[class=dateinput]").each(function(idx) {
			$(this).moorimDatePicker({dateFormat : 'yy.mm.dd', yearRange : '2016:'+currentYear});
			$(this).on('keyup', function(event) {
				event.preventDefault();
				$(this).val('');
			});
			
		});
		// 면접관 select box 처리
		var fselect = $( "select[name$='IG_GUBUN']" );
		$.each(fselect, function(index) {
			var gubun = $(this).prop('selectedIndex');
			if(gubun == '1') {
				var nm1 = 'ivGroupVOList['+index+'].IG_USER_ID';
				var fuser = $( "select[name^='"+nm1+"']" );
				$.each($(fuser), function(k) {
					$.each($(this).children('option'), function(j) {
						if(j>=1) {
							var tt = $(this).attr("id");
							if(tt.split(",")[0] != "Y") {
								$(this).remove();
							}
						}
					});
				});
			} else {
				var nm1 = 'ivGroupVOList['+index+'].IG_USER_ID';
				var fuser = $( "select[name^='"+nm1+"']" );
				$.each($(fuser), function(k) {
					$.each($(this).children('option'), function(j) {
						if(j>=1) {
							var tt = $(this).attr("id");
							if(tt.split(",")[1] != "Y") {
								$(this).remove();
							}
						}
					});
				});
			}
		});
		// 중복 체크
		$.fn.checkSelectedUser = function() {
			var _this = $(this);
			var sVal = $(_this).val();
			$('select[id="USER_ID"]').each(function() {
				var _each = $(this);
				if($(_each).attr("name") != $(_this).attr("name")) {
					var ss = $(_each).val();
					if(sVal == ss) {
						alert("이미 선택한 면접관입니다.\n다른 면접관을 선택해주세요");
						$(_this).val("");
						$(_this).focus();
						return false;
						
					}
				}
			});
			return true;
		}
		
		$('select[id="USER_ID"]').each(function() {
			$(this).change(function() {
				$(this).checkSelectedUser();
			});
		});
	});
	
$.beforeSubmitAddRule = function() {
	$('[name*=".IG_TITLE"]').each(function() {
		$(this).rules("add", {required : ['편성조 이름']})
	});
	$('[name*=".IG_GUBUN"]').each(function() {
		$(this).rules("add", {selectcheck : ['구분']})
	});
	
}

function goDel(idx) {
	$("#listIndex").val(idx);
	$("#procTypeL").val("del");
	
}
function goModify(idx) {
	$("#listIndex").val(idx);
	$.beforeSubmitAddRule();
	
	$('[name*=".IG_TITLE"]').each(function() {
		alert($(this).val());
	});
	
	if(!$("#listForm").valid()) {
		validator.focusInvalid();
		return false;
	}
	//$.beforeSubmitAddRule();
	
	
	
	/*
	$("#listForm").ajaxForm({
		beforeSubmit : function(arr, $form, options) {
			$('[name*=".IG_TITLE"]').each(function() {
				$(this).rules("add", {required : ['편성조 이름']})
			});
			if(!$("#listForm").valid()) {
				validator.focusInvalid();
				return false;
			}
			// monthpicker 값 변환 (yyyy.mm -> yyyymm)
			$.each(arr, function(i) {
				if(arr[i].name.indexOf("IG_DATE") > -1 || arr[i].name.indexOf("IG_DATE") > -1) {
					arr[i].value = arr[i].value.replace(/\./g,'');
				}
			});
			alert(1);
		},
		url: "/admin/recruit/processRec0400",
        error : function(){
        	//$("#listForm").afterSubmitRenameForView();
            alert("서버 에러가 발생하였습니다.");
            return;
        },
        success : function(data){
        	//$("#recruitForm").afterSubmitRenameForView();

        	if(data.json.result == 'success') {
        		goNext();
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
 	       			alert("에러가 발생하였습니다.");
        		}

        		return;
        	}
        }
    });
	$("#listForm").submit();
	*/
}

function linkPage(pageNo) {
	$("#pageNo").val(pageNo);
	$('#search_form').submit();
}
	
</script>
<title>무림HR</title>

</head>
<body>
<div id="wrap">
<c:import url="/inc/adm_header.jsp?m=2&s=2"/>
			<!-- 왼쪽 메뉴 시작 -->
<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
			<!-- 페이지 타이틀 영역-->
			<div class="page_title">
				<span class="title">채용 관리</span>
				<ul class="location">
					<li>
						<a href="">Home</a>
					</li>
					<li>
						<a href="">채용관리</a>
					</li>
					<li class="currentpage">
						<a href="#">평가위원 등록</a>
					</li>
				</ul>
			</div>
	<div class="contetns">
					<div class="table_search">
						<div class="input_area">
							<form name="search_form" id="search_form" method="post" action="/admin/recruit/rec0400">
								<table>
									<caption>공고 선택 테이블</caption>
									<colgroup>
										<col width="80">
										<col width="">
									</colgroup>
									<tbody>
										<tr>
											<th>
												공고선택
											</th>
											<td colspan="3">
												<select name="N_IDX" class="width_70">
											    	<option value="">면접조 편성을 위한 공고를 선택하세요</option>
											    	<c:if test="${not empty rs}">
														<c:forEach var="item" items="${rs}" varStatus="status">
															<option value="${item.IDX}" <c:if test="${N_IDX eq item.IDX}">selected</c:if> >${item.R_TITLE}</option>
														</c:forEach>
													</c:if>
											  	</select>
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

			<div class="table_header admin">
				<div class="total">
					총 <c:out value="${total }" />건
				</div>
				
				<div class="btn_area">
					
					<a class="btn_c color_a additem" id="regBtn" href="#" title="등록"><span>등록</span></a>
				</div>
			</div>
			
			<table class="list_table admin">
				<caption>그룹 목록. chk,그룸명,구분,인원수,면접일,위원1~5</caption>
			  <colgroup>
			    <col style="width:20px;" />
			    <col style="width:80px;" />
			    <col style="width:80px;" />
			    <col style="width:60px;" />
			    <col style="width:100px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:90px;" />
			    <col style="width:;" />
			  </colgroup>
			  <thead>
			    <tr>
			      <th></th>
			      <th>편성조</th>
			      <th>구분</th>
			      <th>대상<br>인원수</th>
			      <th>면접일</th>
			      <th>위원1</th>
			      <th>위원2</th>
			      <th>위원3</th>
			      <th>위원4</th>
			      <th>위원5</th>
			      <th>수정/삭제</th>
			    </tr>
			  </thead>
			  <tbody>
			  <form name="listForm" id="listForm" method="post" >
				<input type="hidden" name="listIndex" id="listIndex" >
				<input type="hidden" name="procType" id="procTypeL" >
					<c:choose>
						<c:when test="${empty gList }">
							<tr>
								<td colspan="11">검색된 편성조가 없습니다.</td>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="list" items="${gList }" varStatus="status">
							<c:set var="sIdx" value="${status.index}" />
							<tr>
								<td class="center"></td>
								<td class="left">
								<input type="hidden" name="N_IDX" value="${N_IDX }">
								<input type="text" class="width_90" name="ivGroupVOList[${sIdx}].IG_TITLE" value="${list.IG_TITLE }"></td>
								<td class="left">
								<select name="ivGroupVOList[${sIdx}].IG_GUBUN" id="IG_GUBUN" class="width_100">
							    	<option value="" >구분</option>
									<option value="1" <c:if test="${list.IG_GUBUN eq '1'}">selected</c:if>>인성</option>
									<option value="2" <c:if test="${list.IG_GUBUN eq '2'}">selected</c:if>>직무</option>
							  	</select></td>
								<td class="left">
								<input class="width_100" type="text" name="ivGroupVOList[${sIdx}].IG_AMOUNT" value="${list.IG_AMOUNT }"></td>
								<td class="left">
								<input type="text" class="dateinput" name="ivGroupVOList[${sIdx}].IG_DATE" value="${list.IG_DATE }" />
								</td>
								<td class="center">
								<select class="width_100" name="ivGroupVOList[${sIdx}].IG_USER_ID1" id="USER_ID">
									<option value="">면접관</option>
									<c:forEach var="ivUser" items="${ivUser}" varStatus="status">
									<option value="${ivUser.USER_ID}" id="${ivUser.EV_ROLE_3},${ivUser.EV_ROLE_4}" <c:if test="${list.IV_USER_ID1 eq ivUser.USER_ID}">selected</c:if>>${ivUser.USER_NAME}(${ivUser.GROUP_NAME})</option>
									</c:forEach>
								</select>
								</td>
								<td class="center">
								<select class="width_100" name="ivGroupVOList[${sIdx}].IG_USER_ID2"  id="USER_ID">
									<option value="">면접관</option>
									<c:forEach var="ivUser" items="${ivUser}" varStatus="status">
									<option value="${ivUser.USER_ID}" id="${ivUser.EV_ROLE_3},${ivUser.EV_ROLE_4}" <c:if test="${list.IV_USER_ID2 eq ivUser.USER_ID}">selected</c:if>>${ivUser.USER_NAME}(${ivUser.GROUP_NAME})</option>
									</c:forEach>
								</select>
								</td>
								<td class="center">
								<select class="width_100" name="ivGroupVOList[${sIdx}].IG_USER_ID3" id="USER_ID">
									<option value="">면접관</option>
									<c:forEach var="ivUser" items="${ivUser}" varStatus="status">
									<option value="${ivUser.USER_ID}" id="${ivUser.EV_ROLE_3},${ivUser.EV_ROLE_4}" <c:if test="${list.IV_USER_ID3 eq ivUser.USER_ID}">selected</c:if>>${ivUser.USER_NAME}(${ivUser.GROUP_NAME})</option>
									</c:forEach>
								</select>
								</td>
								<td class="center">
								<select class="width_100" name="ivGroupVOList[${sIdx}].IG_USER_ID4" id="USER_ID">
									<option value="">면접관</option>
									<c:forEach var="ivUser" items="${ivUser}" varStatus="status">
									<option value="${ivUser.USER_ID}" id="${ivUser.EV_ROLE_3},${ivUser.EV_ROLE_4}" <c:if test="${list.IV_USER_ID4 eq ivUser.USER_ID}">selected</c:if>>${ivUser.USER_NAME}(${ivUser.GROUP_NAME})</option>
									</c:forEach>
								</select>
								</td>
								<td class="center">
								<select class="width_100" name="ivGroupVOList[${sIdx}].IG_USER_ID5" id="USER_ID">
									<option value="">면접관</option>
									<c:forEach var="ivUser" items="${ivUser}" varStatus="status">
									<option value="${ivUser.USER_ID}" id="${ivUser.EV_ROLE_3},${ivUser.EV_ROLE_4}" <c:if test="${list.IV_USER_ID5 eq ivUser.USER_ID}">selected</c:if>>${ivUser.USER_NAME}(${ivUser.GROUP_NAME})</option>
									</c:forEach>
								</select>
								</td>
								<td>
								<a href="javascript:void(0);" id="modifyBtn${sIdx}" class="btn_c color_a" onClick="javascript:goModify('${sIdx}')">수정</a> 
								<a href="javascript:void(0);" id="deleteBtn${sIdx}" class="btn_c color_a" onClick="javascript:goDel('${sIdx}')">삭제</a></td>
								<input type="hidden" name="ivGroupVOList[${sIdx}].IG_IDX" value="${list.IG_IDX }">
								<input type="hidden" name="ivGroupVOList[${sIdx}].N_IDX" value="${list.N_IDX }">
								</td>
							</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</form>
				</tbody>
			</table>
			
	</div><!-- 컨텐츠 영역 끝 -->
</div><!-- contents_wrap 끝 -->	
	
	
	
<c:import url="/inc/adm_footer.jsp"></c:import>

</div>

</body>
</html>
