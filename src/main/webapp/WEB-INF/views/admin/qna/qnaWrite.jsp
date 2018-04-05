<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<c:set var="time"><%=System.currentTimeMillis()%></c:set>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="/resources/css/datepicker/jquery-ui.css">
<script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
<script type="text/javascript" src="/SmartEditor/js/initEditor.js"></script>
<script type="text/javascript" src="/resources/js/file.js"></script>
<script type="text/javascript" src="/resources/js/validation.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//editor load
	fn_smartEditorInit( "textarea_contents", true, false, true );
	//calendar
	$(document).ready(function(){
		$( ".calendar_input" ).datepicker({dateFormat: 'yy.mm.dd'});
	});
});

function go_savePage() {
	fn_smartEditorUpdateContentsField();
	with (document.frm)
	{
<c:if test="${procType eq 'mod'}">
		var msg="수정하겠습니까?";
</c:if>
<c:if test="${procType eq 'new'}">
		var msg="등록하겠습니까?";
</c:if>

		if (!valid_exist(question)) {
			alert('제목을 입력하세요');
			question.focus();
			return;
		}

		if (!valid_existEditor(content)) {
			alert('내용을 입력하세요');
			return;
		}

		if(!confirm(msg)) {
			return;
		}

		if( fileExistCheck() ) {
			fn_fileUpload( "document.frm", "fileinfo", "fn_save()", "N");
		} else {
			fn_save();
		}
	}
}
function fn_save() {
	alert(1);
	with( document.frm ) {
		target = "_self";
		method = "post";
		encoding = "application/x-www-form-urlencoded";
		action = "/client/qnaProcess";
		//submit();
	}
	var params = jQuery("#frm").serialize();
	$.ajax({
		type: 'POST',
		url: "/client/qnaProcess",
		data: params,
		async: false,
        cache: false,
		success: function(data) {
			alert(data.msg)
			if(data.result == "SUCCESS"){
				document.search_form.submit();	
			}
		},
		error : function() {
			alert("알수 없는 에러가 발생했습니다.");
		},
		dataType: "json"
	}); 
}
function go_listPage() {
	with (document.search_form) {
		target="_self";
		encoding = "application/x-www-form-urlencoded";
		submit();
	}
}
</script>
<title>무림러닝센터</title>
</head>
<body>
<div id="wrap">
    <!-- header -->
    <div id="container_sub">
        <div class="container_sub_wrap">
          <div class="container_sub_boxIn">
             <div class="content">
                <div class="content_boxIn">
				<form method="get" name="search_form" id="search_form" action="qnaList">
					<input type="hidden" name="pageNo" id="pageNo" value="<c:out value="${vo.pageNo }"/>">
					<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>">
					<input type="hidden" name="procType" value="<c:out value="${procType }"/>">
				</form>
				<form method="post" name="frm" id="frm">
				<input type="hidden" name="idx" value="<c:out value="${rs.idx }"/>">
				<input type="hidden" name="procType" value="<c:out value="${procType }"/>">
				<input type="hidden" name="fileinfo">
				<input type="hidden" name="delfileinfo">
                   	<div class="content_color">
	                   	<p><img src="/resources/images/admin/category_home.png"> &nbsp;>&nbsp; Qna</p>
	                   	<h6>Qna</h6>
                   	</div>                    
                    <div class="top_box">
                        <p class="tit_blue">Qna 
	                        <c:if test="${procType eq 'mod'}" >수정</c:if>
	                        <c:if test="${procType eq 'new'}" >등록</c:if>
                        </p>
                    </div>
        			<div class="list2">
		                <table>
			                <colgroup>
			                    <col style="width:10%">
                                <col style="width:90%">
                            </colgroup>
			                <tbody>
			                    <tr>
				                    <th class="bg">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</th>
				                    <td>
										<input type="text" style="width:870px;" question="제목" name="question" maxlength="100" value="<c:out value="${rs.question }" />"/>

									</td>
				                </tr>
								<tr>
				                    <th class="bg">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</th>
				                    <td>
										<textarea id="textarea_contents" name="content" style="width:870px; height:300px;">${rs.content }</textarea>
									</td>
				                </tr>
								<tr>
				                    <th class="bg" style="height:30px;">첨부파일</th>
				                    <td style="padding:0px 0 10px 10px; vertical-align:middle;">
										${fileUpload }
									</td>
				                </tr>
			                </tbody>
                        </table>
                    </div>
				</form>        
        			<div class="dataBox_footer">
           				<a href="javascript:void(0);" onclick="javascript:go_savePage();" class="bt004"><span>저장</span></a>
						<a href="javascript:void(0);" onclick="javascript:go_listPage();" class="bt005"><span>취소</span></a>
         			</div>
  				</div><!--검색박스 끝-->
            </div><!--컨텐츠 박스인 끝-->
        </div><!--컨텐츠 끝-->      
      </div><!--컨테이너서브 박스인 끝-->
    </div><!--컨테이너서브 감싸기 끝-->
	<!-- footer -->    
</div><!-- 전체감싸기 끝-->

</body>
</html>