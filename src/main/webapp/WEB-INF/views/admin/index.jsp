<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:out value="${login.result}" />
<c:if test="${login.result eq 'success'}">
    <c:redirect url="/admin/codeManage"/>  
</c:if>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<link rel="stylesheet" type="text/css" href="/resources/css/layout_admin.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/object.css" />

<link rel="stylesheet" type="text/css" href="/resources/css/datepicker/jquery-ui.css">
<script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lib/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lib/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>

<script type="text/javascript">


	var currentYear = new Date().getFullYear();
	var validator;
	$(document).ready(function() {
		<c:if test="${login.result eq 'fail'}">
		alert("<c:out value="${login.msg}" />")
		</c:if>

		// 아이디 저장
		var c_user_id= $.cookie('user_id');
		if(c_user_id != undefined) {
	        $("#user_id").val(c_user_id);
	        $("#rememberid").prop("checked",true);

	    }
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
		
		validator = $("#frm").validate({
			rules: {
				user_id: {
					required : true,
					minlength : 6
				},
				user_password: {
					required : true,
					minlength : 8
				},
			},
			messages: {
				user_id: {
					required : '아이디를 입력해주세요.'
					, minlength : $.validator.format('아이디는 {0}자 이상이어야 합니다.')
				},
				user_password: {
					required : '비밀번호를 입력해주세요.'
					, minlength : '비밀번호는 {0}자 이상이어야 합니다.'
				},
			}
		});
		
		$("#user_password").keyup(function(event){
			if(event.which == 13) {
	            $("#btn_login").click();
	        }
		});
		
	});
	
	function goLogin() {
		if(!$("#frm").valid()) {
			validator.focusInvalid();
			return;
		}
		if($("#rememberid").prop("checked")) {
            $.cookie('user_id', $("#user_id").val());
        } else {
            $.removeCookie("user_id");
        }
		$("#frm").ajaxForm({
			url: "/admin/loginRequest",
			error: function() {
				alert("서버 에러가 발생하였습니다");
				return;
			},
			success: function(data) {
				if(data.login.result == "success") {
					window.location.assign(data.targetUrl);
				} else {
					alert(data.login.msg);
					return;
				}
			}
			
		});
		$("#frm").submit();
	}
</script>
		
</head>
<body>

	<div class="jobapp_login admin">
		<h1>채용센터 관리자 <b>로그인</b></h1>
		<form name="frm" id="frm" method="post" >
		<ul class="login_list">
			<li>
				<span class="label">아이디</span>
				<input type="text" style="width:140px" name="user_id" id="user_id" value="kjw0823"> <input type="checkbox" id="rememberid" /> (아이디 저장)
				<br>
			</li>
			<li>
				<span class="label">비밀번호</span>
				<input type="password" style="width:140px" name="user_password" id="user_password" value="b1234567">
			</li>
			<li class="login_btn">
				<a class="btn_login" id="btn_login" title="Login" href="#" onClick="javascript:goLogin()" ><span>Login</span></a>
			</li>
		</ul>
		<ul class="login_disc">
			<li>현재 세션이 종료되어 <b>로그인</b>이 필요합니다.</li>
			<li>관리자 페이지는 <b>EP에 로그인</b>하시거나,<br / />
				<b>EP 로그인 정보</b>를 본 화면에서 입력하시면 이용 가능합니다.</li>
		</ul>
		</form>
	</div>

</body>