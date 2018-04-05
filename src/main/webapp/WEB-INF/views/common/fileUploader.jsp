<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var f = document.frm;
	parent.fn_fileUploadClear();
	if( f.result.value == "success" ) {
		for( var i=0; i<f.file_total.value; i++ ) {
			parent.fn_setUploadFile( eval("f.file_no"+(i+1)).value, eval("f.file_info"+(i+1)).value);
		}
		parent.fn_fileUploadSuccess();
	} else if( f.result.value == "extension_error" ) {
		alert("허용하지 않는 확장자를 가진 첨부파일입니다.\n자세한 사항은 관리자에게 문의하세요.");
	} else {
		alert("첨부파일을 업로드하는 중 에러가 발생했습니다.\n첨부파일 용량은 " + f.upload_size_max.value + "MBytes 이하로 제한됩니다.\n자세한 사항은 관리자에게 문의하세요.");	
	}
});
</script>
<title>File Uploader</title>
</head>
<body >
<form name="frm" method="post">
<input type="hidden" name="result" value="${returnMap.result }"/>
<input type="hidden" name="upload_size_max" value="${returnMap.upload_size }"/>
<input type="hidden" name="file_total" value="${returnMap.real_total }"/>
<c:forEach var="list" items="${returnMap.list }" varStatus="status">
<input type="hidden" name="file_no${ status.index + 1 }" value="${ list.file_no }" />
<input type="hidden" name="file_info${ status.index + 1 }" value="<c:out value="${list.file_info }" />" />
</c:forEach>
</form>
</body>
</html>