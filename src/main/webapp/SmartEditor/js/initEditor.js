//writer 페이지에서 처음에 호출하는 부분
var oEditors = [];
var oEditorsTextareaId;

//기본 SmartEditor에디터 호출하기
document.write("<script type=\"text/javascript\" src=\"/SmartEditor/js/HuskyEZCreator.js\"></script>");

function getInternetExplorerVersion() {    
    var rv = -1; // Return value assumes failure.    
    if (navigator.appName == 'Microsoft Internet Explorer') {        
         var ua = navigator.userAgent;        
         var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");        
         if (re.exec(ua) != null)            
             rv = parseFloat(RegExp.$1);    
        }    
    return rv; 
}

String.prototype.replaceAll = function(str1,str2){
	var str = this;
	return str.split(str1).join(str2);
}

/*
 *IE11체크 방식
if (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) {
	  // 처리 로직 작성
}
*/

function fn_smartEditorInit( oEditorsTextareaIdVal, bUseToolbarVal, bUseVerticalResizerVal, bUseModeChangerVal  ) {

	//에디터 최소크기 : 610px;
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	oEditorsTextareaId = oEditorsTextareaIdVal;
	
	//alert( $("#"+oEditorsTextareaIdVal).val('555555555') );		
	//var strORI_Contents = $("#"+oEditorsTextareaIdVal).val();
	//var chn_Contents = strORI_Contents.replace("/<p>&nbsp;</p>/gi","<p>&nbsp;&nbsp;</p>");	
	//$("#"+oEditorsTextareaIdVal).val(chn_Contents);
		
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: oEditorsTextareaId,
		sSkinURI: "/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : bUseToolbarVal,					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : bUseVerticalResizerVal,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : bUseModeChangerVal,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
}
function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>"; //이미지도 같은 방식으로 삽입합니다.
	oEditors.getById[oEditorsTextareaId].exec("PASTE_HTML", [sHTML]);
}
function fn_smartEditorUpdateContentsField() {
	oEditors.getById[oEditorsTextareaId].exec("UPDATE_CONTENTS_FIELD", []);
}

function fn_smartEditorResetContentsField() {
	oEditors.getById[oEditorsTextareaId].exec("SET_IR", [""]); //내용초기화
}

