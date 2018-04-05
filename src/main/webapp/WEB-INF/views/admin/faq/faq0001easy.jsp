<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%
response.setHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
		
%>
<c:set var="time"><%=System.currentTimeMillis()%></c:set>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">

<link rel="stylesheet" type="text/css" href="/resources/css/layout_admin.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/object.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/datepicker/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker/jquery-ui.css">

<script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/validation.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moorim_datePicker.js"></script>
<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.edatagrid.js"></script>
<script type="text/javascript" src="/SmartEditor/js/initEditor.js"></script>

	
<script type="text/javascript">
	$(document).ready(function() {
		$( ".calendar_input" ).datepicker({dateFormat: 'yy.mm.dd'});
		fn_smartEditorInit( "textarea_contents", true, false, true );
		
	});
	
	function newEdit(){
		
	    $('#dlg').dialog('open').dialog('center').dialog('setTitle','FAQ등록');
	    $('#frm').form('clear');
	    fn_smartEditorResetContentsField();
	    document.frm.procType.value = "new";
	}
	
	function updateEdit(){
		
	    var row = $('#dg').datagrid('getSelected');
	    if (row){
	    	$('#dlg').dialog('open').dialog('center').dialog('setTitle','FAQ등록');
	        $('#frm').form('load',row);
	        oEditors.getById[oEditorsTextareaId].exec("SET_IR", [row.contentQ]); //내용초기화
	        row.delYn == true ? $("#del0").prop("checked",true) : $("#del1").prop("checked",true); 
	        document.frm.procType.value = "mod";	
	        
	    }
	}
	
	function deleteEdit(){
		 var row = $('#dg').datagrid('getSelected');
		 document.frm.procType.value = "del";
		 goDelete(row.idx);
	}
	
	
	function go_savePage() {
		fn_smartEditorUpdateContentsField();
		with (document.frm)
		{
			
			var msg="등록하겠습니까?";

			if (!valid_exist(title)) {
				alert('제목을 입력하세요');
				title.focus();
				return;
			}
			if (!valid_exist(regName)) {
				alert('작성자명을 입력하세요');
				regName.focus();
				return;
			}
			
			if (!valid_exist(regDt)) { 
				alert ('작성일을 입력하세요');
				return;
			}

			if (!valid_existEditor(contentQ)) {
				alert('내용을 입력하세요');
				return;
			}
			
			
			if(!confirm(msg)) {
				return;
			}
			
			fn_save();
			
			/*
			if( fileExistCheck() ) {
				alert(1);
				fn_fileUpload( "document.frm", "fileinfo", "fn_save()", "N");
			} else {
				fn_save();
			}
			*/
		}
	}

	function fn_save() {
		with( document.frm ) {
			target = "_self";
			method = "post";
			encoding = "application/x-www-form-urlencoded";
			action = "/admin/faq/faqProcess";
			//submit();
		}
		var params = $("#frm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/faq/faqProcess",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				if(data.json.result == "SUCCESS"){
					document.search_form.submit();
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	
	function goDelete(idx){
		if(!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		var frm = document.frm;
		frm.method = "post";
		frm.procType.value = 'del';
		frm.idx.value = idx;
		
		var params = $("#frm").serialize();
		$.ajax({
			type: 'POST',
			url: "/admin/faq/faqProcess",
			data: params,
			async: false,
	        cache: false,
			success: function(data) {
				alert(data.json.msg);
				if(data.json.result == "SUCCESS"){
					document.search_form.submit();	
				}
			},
			error : function() {
				alert("알수 없는 에러가 발생했습니다.");
			},
			dataType: "json"
		}); 
	}
	
	function pagination(){
		
		var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
		pager.pagination({
		    showPageList:false,
		    buttons:[{
		        iconCls:'icon-search',
		        handler:function(){
		            alert('search');
		        }
		    },{
		        iconCls:'icon-add',
		        handler:function(){
		            alert('add');
		        }
		    },{
		        iconCls:'icon-edit',
		        handler:function(){
		            alert('edit');
		        }
		    }],
		    onBeforeRefresh:function(){
		        alert('before refresh');
		        return true;
		    }
		});
		
	}
	
</script>


<title>무림HR</title>

</head>
<body>
<div id="wrap">
<c:import url="/inc/adm_header.jsp"></c:import>
		<div class="container">
			<!-- 왼쪽 메뉴 시작 -->
			<div class="lnb_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="lnb_wrap lnb_close" (컨텐츠 영역도 lnb_close로 클래스 변경)-->
				<a href="" class="lnb_closebtn">서브 메뉴 닫기</a>
				<!--<a href="" class="lnb_openbtn">서브 메뉴 열기</a>-->
				<ul class="lnb_list">
					<li class="title">
						채용 문의 관리
					</li>
					<li>
						<a href="" >채용 문의 관리</a>
					</li>
					<li>
						<a href="" class="selected">FAQ관리</a>
					</li>
				</ul>
			</div>
			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">채용 문의 관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">채용 문의 관리</a>
						</li>
						<li class="currentpage">
							<a href="#">FAQ목록</a>
						</li>
					</ul>
				</div>
				
				
				
				<div class="contetns">	
					 <table id="dg" title="My Users" class="easyui-datagrid" style="width:900px;height:600px"
				            url="/admin/faq/faq0001Select"
				            toolbar="#toolbar"  pagination="true"
				            rownumbers="true" fitColumns="true" singleSelect="true">
				        <thead>
				            <tr>
				                <th data-options="field:'idx',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">순번</th>
				                <th data-options="field:'title',width:50,align:'center',sortable:'true'" >제목</th>
				                <th data-options="field:'contentQ',width:50,align:'center',sortable:'true'" >내용</th>
				                <th data-options="field:'regName',width:50,align:'center',sortable:'true'" >작성자</th>
				            </tr>
				        </thead>
				    </table>
				    <div id="toolbar">
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEdit()">New</a>
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateEdit()">Edit</a>
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteEdit()">Remove</a>
				    </div>
				    
				    <div id="dlg" class="easyui-dialog" style="width:600px;"
				            closed="true" buttons="#dlg-buttons">
				        <form method="post" name="frm" id="frm">
						<input type="hidden" name="idx" value="<c:out value="${rs.IDX }"/>"> 
						<input type="hidden" name="procType" value="<c:out value="${procType }"/>"> 
						<input type="hidden" name="fileinfo"> 
						<input type="hidden" name="delfileinfo">
	                    <div class="top_box">
	                        <p class="tit_blue">FAQ 
		                        <c:if test="${procType eq 'mod'}" >수정</c:if>
		                        <c:if test="${procType eq 'new'}" >등록</c:if>
	                        </p>
	                    </div>
	        			<div class="list2">
			                <table>
								<colgroup>
									<col style="width: 16%">
									<col style="width: 84%">
								</colgroup>
								<tbody>
									<tr>
										<th class="bg">제목</th>
										<td style="text-align: left">
											<input type="text" style="width: 680px;" question="질문 제목을 입력해 주세요" name="title" maxlength="100"  /></td>
									</tr>
									<tr>
										<th class="bg">이름</th>
										<td style="text-align: left">
											<input type="text" style="width: 240px;" name="regName" maxlength="20" value="<c:out value="${rs.REG_NAME }" />" /></td>
									</tr>
									<tr>
										<th class="bg">작성일</th>
										<td style="text-align: left">
											
											<input type="text" class="calendar_input" style="width: 240px;" name="regDt" maxlength="50" value="<fmt:formatDate value="${rs.REG_DT }" pattern="yyyy.MM.dd" />" /></td>
									</tr>
									<tr>
										<th class="bg">게시여부</th>
										<td style="text-align: left">
											<input type="radio" value="1" name="delYn" id="del0" ${empty rs.DE_YN ? 'checked="checked"' : (rs.DE_YN eq true ? 'checked="checked"' : '')  }><label for="del0">사용</label>
											<input type="radio" value="0" name="delYn" id="del1"<c:if test="${rs.DEL_YN eq false }">checked="checked"</c:if>><label for="del1">미사용</label>
										</td>
									</tr>
	
									<tr>
										<th class="bg">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</th>
										<td>
											<textarea id="textarea_contents" name="contentQ" style="width: 680px; height: 300px;">${rs.CONTENT_Q }</textarea>
										</td>
									</tr>
									<!-- 
									<tr>
										<th class="bg" style="height: 30px;">첨부파일</th>
										<td style="padding: 0px 0 10px 10px; vertical-align: middle;">
											${fileUpload }</td>
									</tr>
									 -->
								</tbody>
							</table>
	                    </div>
					</form> 
				    </div>
				    <div id="dlg-buttons">
				        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="javascript:go_savePage();" style="width:90px">Save</a>
				        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
				    </div>
				    
				    <form method="post" name="search_form" id="search_form" action="/admin/faq/faq0001easy">
						<input type="hidden" name="searchType" value="<c:out value="${vo.searchType }"/>"> 
					</form>
				</div>
			</div><!-- 컨텐츠 영역 끝 -->
		</div>		
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
</body>
</html>