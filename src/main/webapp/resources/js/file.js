function fn_insertFile() {
	//compare file max count with open count
	var file_total = eval(document.getElementById("hidden_file_total").value); //file count
	var file_count = eval(document.getElementById("hidden_file_count").value);
	if(file_count == 3){
		alert("더이상 추가할 수 없습니다.");
		return;
	}
	if( file_total - file_count > 0 ) { //add file
		document.getElementById("div_file_pack" + (file_count + 1) ).style.display = "block";
		document.getElementById("hidden_file_count").value = (file_count + 1) + "";
	}
}
function fn_deleteFile() {
	//compare file max count with open count, but not delete exist file
	var file_total = eval(document.getElementById("hidden_file_total").value); //file count
	var file_count = eval(document.getElementById("hidden_file_count").value);
	if( file_total - file_count < ( file_total - 1 ) ) { //possible delete file
		if( document.getElementById("hidden_fileUplaodChk" + file_count).value != "U" ) {
			document.getElementById("div_file_display"+file_count+"2").innerHTML = "<input type=\"file\" id=\"file_input_file"+file_count+"\" name=\"input_file"+file_count+"\" class=\"search\" style=\"border:1px solid #e5e5e5;background-color:#ffffff;font-size:12px;;color:#666666;width:100%;height:22px;\">";
			document.getElementById("div_file_pack" + file_count ).style.display = "none";
			document.getElementById("hidden_file_count").value = (file_count - 1) + "";
		}
	}
}
function fn_deleteFileExist( fileNoVal ) {
	//delete exist file
	document.getElementById("hidden_fileUplaodChk"+fileNoVal).value = "D";
	document.getElementById("div_file_display"+fileNoVal+"1").style.display = "none";
	document.getElementById("div_file_display"+fileNoVal+"1").innerHTML = "Attach File";
	document.getElementById("div_file_display"+fileNoVal+"2").innerHTML = "<input type=\"file\" id=\"file_input_file"+fileNoVal+"\" name=\"input_file"+fileNoVal+"\" class=\"search\" style=\"border:1px solid #e5e5e5;background-color:#ffffff;font-size:12px;color:#666666;width:100%;height:22px;\">";
	document.getElementById("div_file_display"+fileNoVal+"2").style.display = "block";
}
function fileExistCheck() {
	//check exist file
	var fileCheck = false;
	var fileTotalVal = eval(document.getElementById("hidden_file_total").value); //file count
	for( var i=1; i<=fileTotalVal; i++ ) {
		//file check
		var f_name = document.getElementById("file_input_file" + String(i)).value;
		if( f_name.length != 0 ) {
			fileCheck = true;
		}
		//check input file, I 입력, D 삭제, U 대기
		var f_fileCheck = document.getElementById("hidden_fileUplaodChk" + i).value;
		if( !f_fileCheck == "" ) {
			fileCheck = true;
		}
	}
	return fileCheck;
}
function fileNewCheck() {
	//check new file
	var fileCheck = false;
	var fileTotalVal = eval(document.getElementById("hidden_file_total").value); //file count
	for( var i=1; i<=fileTotalVal; i++ ) {
		//check file exist
		var f_name = document.getElementById("file_input_file" + i).value;
		if( f_name.length != 0 ) {
			fileCheck = true;
		}
	}
	return fileCheck;
}
function fileErrorCheck( imgCheck ) {
	//file check
	var fileTotalVal = eval(document.getElementById("hidden_file_total").value); //file count
	for( var i=1; i<=fileTotalVal; i++ ) {
		var f_name = document.getElementById("file_input_file" + i).value;
		if( f_name.length != 0 ) {
			//check file name or extension
			if( f_name.indexOf("'") > 0 ) {
				return "N1";
			}
			if( f_name.indexOf(".") < 0 ) {
				return "N2";
			}
			if( f_name.toLowerCase().match(/\.(jsp|js|php|asp|css)$/i) ) {
				return "N3";
			}
			if( imgCheck == "Y" ) {//img check
				if( !f_name.toLowerCase().match(/\.(gif|jpg|png)$/i) ) {
					return "N4";
				}
			}
			document.getElementById("hidden_fileUplaodChk" + i).value = "I";
		}
	}
	return "Y";
}
var fileUploadProcess = "N";
var fileReturnFn = "";
var fileFormObj = "";
var fileInfoObj = "";
function fn_fileUpload( formObj, fileObj, returnFn, imgCheck ) {
	alert(2);
	//check new file exist
	fileFormObj = formObj;
	fileInfoObj = fileObj;
	fileReturnFn = returnFn;
	if( !fileNewCheck() ) { //update or delete --> confirm last file
		fn_fileUploadSuccess();
	} else {
		//new file upload
		var fileErrorMsg = fileErrorCheck( imgCheck );
		if( fileErrorMsg != "Y" ) { //file error
			if( fileErrorMsg == "N1" ) {
				alert("첨부파일 이름에 ' 를 사용할 수 없습니다.");
			} else if( fileErrorMsg == "N2" ) {
				alert("첨부파일이름은 반드시 확장자가 있어야 합니다");
			} else if( fileErrorMsg == "N3" ) {
				alert("등록할 수 없는 확장자를 가진 첨부파일입니다.");
			} else if( fileErrorMsg == "N4" ) {
				alert("확장자는 gif, jpg, png이어야 합니다.");
			}
			return;
		}
		with( eval(fileFormObj) ) {
			if( fileUploadProcess == "Y" ) {
				alert("파일을 업로드하는 중입니다.\n잠시 기다려주세요.");
				return;
			}
			
			fileUploadProcess = "Y";
			
			//위치를 현재 스크린의 가운데로 오게하기
			var fileUpLeft = fn_getXY_cal( document.getElementById('div_file_pack1') ).left + 200;
			var fileUpTop = fn_getXY_cal( document.getElementById('div_file_pack1') ).top - 50;
			document.getElementById("img_ATTMSG").style.left = fileUpLeft + "px";
			document.getElementById("img_ATTMSG").style.top = fileUpTop + "px";
			document.getElementById("img_ATTMSG").style.visibility = "visible";
			
			encoding = "multipart/form-data";
			action = "/uploadMultipleFileReg";
			target = "fileInputFrame";
			submit();
		}
	}
}
function fn_getXY_cal(Obj) {
	for (var sumTop=0,sumLeft=0;Obj!=document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
	return {left:sumLeft,top:sumTop}
}
function fn_fileUploadClear() {
	fileUploadProcess = "N";
	document.getElementById("img_ATTMSG").style.visibility = "hidden";
}
function fn_setUploadFile( fileNoVal, fileInfoVal ) {
	document.getElementById("hidden_file_info" + fileNoVal).value = fileInfoVal;
}
function fn_fileUploadSuccess() {
	//confirm last file
	var fileTotalVal = eval(document.getElementById("hidden_file_total").value); //file count
	var last_file_info = "";
	for( var i=1; i<=fileTotalVal; i++ ) {
		var fileUplaodChk = document.getElementById("hidden_fileUplaodChk" + i).value;
		if( fileUplaodChk == "I" ) { //insert
			last_file_info += document.getElementById("hidden_file_info" + i).value + "|";
		} else if( fileUplaodChk == "U" ) { //keep exist value
			last_file_info += document.getElementById("hidden_file_info" + i).value + "|";
		}
	}
	/*if( last_file_info != "" ) {
		last_file_info = last_file_info.substring(0, last_file_info.length - 1);
	}*/
	with( eval(fileFormObj) ) {
		eval(fileInfoObj).value = last_file_info;
	}
	eval( fileReturnFn );
}