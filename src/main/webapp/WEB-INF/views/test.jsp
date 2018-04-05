<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>무림 채용</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/object.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/MonthPicker.css" />
    <link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="/resources/js/lib/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="/resources/js/lib/jquery-ui.js"></script>
    <script type="text/javascript" src="/resources/js/lib/MonthPicker.js"></script>
<script language="javascript">
$(document).ready(function() { 
	$('#NoIconDemo').MonthPicker({ Button: false });
	$("#PlainButton").MonthPicker({
        Button: '<button>...</button>'
    });
});
</script>     
</head>
<body>
<div id="wrap"> 
	<ul style="padding:20px; ">
	<li style="padding:20px; "><input id="NoIconDemo" type="text" /></li>
	<li style="padding:20px; "><input id="PlainButton" type="text" /></li>
	</ul>	
</div>
</body>
</html>
