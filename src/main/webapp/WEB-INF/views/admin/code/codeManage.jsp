<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/adm_doctype.jsp" %>
<head>
	<jsp:include page="/inc/adm_typelink.jsp" flush="true" />
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">

	<jsp:include page="/inc/adm_typelinkjs.jsp" flush="true" />	 
	<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.edatagrid.js"></script>
	
	<script type="text/javascript">
		$(function(){
			$('#dg').edatagrid({
				method: 'post',
				idField: 'G_CODE',
				url: '/admin/getCodeGroup',
				saveUrl: '/admin/procCodeGroup?procType=new',
				updateUrl: '/admin/procCodeGroup?procType=mod',
				//destroyUrl: 'http://localhost:8091/admin/procCodeGroup?procType=del',
				remoteSort:false,
				onSelect : function(index,row){
					$('#dg2').edatagrid({
						method: 'post',
						idField: 'CODE',
						url: '/admin/selectCodeByGruop?g_code='+row.G_CODE,
						saveUrl: '/admin/procCodeByGroup?procType=new',
						updateUrl: '/admin/procCodeByGroup?procType=mod',
						remoteSort:false
					});
				}
			});
			
			$('#dg2').edatagrid({});
		});
		
		function deleteRow() {
			
			$('#procType').val('del');
			$('#G_CODE').val($('#dg').datagrid('getSelected').G_CODE);
			var params = jQuery("#delForm").serialize();
			$.ajax({
				type: 'POST',
				url: "/admin/procCodeGroup",
				data: params,
				async: false,
		        cache: false,
				success: function(data) {
					$.messager.show({
						title:'삭제',
						msg:'삭제 되었습니다.',
						timeout:1000,
						showType:'slide'
					});
					$('#dg').datagrid('reload');
				},
				error : function() {
					alert("알수 없는 에러가 발생했습니다.");
				},
				dataType: "json"
			}); 
		}
		
		function dg2AddRow(){
			var row = $('#dg').edatagrid('getSelected');
			if(isNullStr(row)){
				alert("코드그룹의 코드를 선택하시기 바랍니다.");
				return false;
			}
			
			$('#dg2').edatagrid('addRow');
		}
		
		function dg2deleteRow(){
			$('#procType').val('del');
			$('#CODE').val($('#dg2').datagrid('getSelected').CODE);
			var params = jQuery("#delForm").serialize();
			$.ajax({
				type: 'POST',
				url: "/admin/procCodeByGroup",
				data: params,
				async: false,
		        cache: false,
				success: function(data) {
					$.messager.show({
						title:'삭제',
						msg:'삭제 되었습니다.',
						timeout:1000,
						showType:'slide'
					});
					$('#dg2').datagrid('reload');
				},
				error : function() {
					alert("알수 없는 에러가 발생했습니다.");
				},
				dataType: "json"
			}); 
		}
		
		//null체크
		function isNull(obj){
			return (( typeof(obj) == "undefined") || ( obj == null ) ); 
		}

		function isNullStr(value){
			return ( (isNull(value)) || value.length == 0);
		}
		
	</script>
	<style type="text/css">
	.panel{
		float: left;
		margin-left: 10px;
	}
	</style>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/adm_header.jsp?m=5&s=3"></c:import>


			<div class="contents_wrap lnb_open"><!-- 왼쪽 메뉴 접기 : class="contents_wrap lnb_close" -->
				<!-- 페이지 타이틀 영역-->
				<div class="page_title">
					<span class="title">시스템관리</span>
					<ul class="location">
						<li>
							<a href="">Home</a>
						</li>
						<li>
							<a href="">공통코드 관리</a>
						</li>
						<li class="currentpage">
							<a href="#">공통코드 관리</a>
						</li>
					</ul>
				</div>

			<div class="contetns">
			
				<h2>코드 그룹 관리</h2>
				<div class="demo-info" style="margin-bottom:10px">
					<div class="demo-tip icon-tip">&nbsp;</div>
					<div>변경하려면 Double click 하세요.</div>
				</div>
				<form name="frm" id="delForm" action="/admin/procCodeGroup">
					<input type="hidden" name="G_CODE" id="G_CODE" value="">
					<input type="hidden" name="CODE" id="CODE" value="">
					<input type="hidden" name="procType" id="procType" value="">
				</form> 
				
				<table id="dg" title="코드 그룹 관리" style="width:400px;height:520px"
						toolbar="#toolbar"  
						rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
            
							<th data-options="field:'G_CODE',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">그룹 코드</th>
							<th data-options="field:'G_NAME',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">그룹 코드명</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar">
					<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#dg').edatagrid('addRow')">New</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:deleteRow();">Destroy</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#dg').edatagrid('saveRow')">Save</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#dg').edatagrid('cancelRow')">Cancel</a>
				</div>
				
				<table id="dg2" title="코드 관리" style="width:500px;height:520px;float: left;"
						toolbar="#toolbar2"  
						rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'CODE',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">코드</th>
							<th data-options="field:'NAME',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">코드명</th>
							<th data-options="field:'EXPR',width:50,align:'center',sortable:'true'" editor="{type:'validatebox',options:{required:true}}">코드 설명</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar2">
					<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:dg2AddRow();">New</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:dg2deleteRow();">Destroy</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#dg2').edatagrid('saveRow')">Save</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#dg2').edatagrid('cancelRow')">Cancel</a>
				</div>
			</div><!-- contents 끝 -->
		</div>
	<c:import url="/inc/adm_footer.jsp"></c:import>
</div>
	
</body>
</html>