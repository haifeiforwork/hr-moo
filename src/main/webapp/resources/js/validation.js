//공백제거 
function fTrim(string) 
{ 
    for(;string.indexOf(" ")!= -1;){ 
        string=string.replace(" ","");
		string=string.replace("\n","");
    } 
    return string; 
}

function valid_existEditor(input) { 
	if(!fTrim(input.value)) return false; 
	if(input.value=="<br>") return false;
	return true; 
}

//입력검사 
function valid_exist(input) 
{ 
    if(!fTrim(input.value)) return false; 
    return true; 
}

// 글자수 제한
function valid_limit_char(input,limit)
{
	if (input.value.length>=limit) {
		return false;
	} else {
		return true;
	}	
}

//바이트검사 
function valid_byte(input) 
{ 
    var i, j=0; 
    for(i=0;i<input.length;i++) { 
        val=escape(input.charAt(i)).length; 
        if(val== 6) j++; 
        j++; 
    } 
    return j; 
}

function valid_alpha(input) //영문만 가능
{ 
    var error_c=0, i, val; 
    for(i=0;i<valid_byte(input);i++) { 
        val = input.charAt(i); 
        if(!(val>='A' && val<='Z')) return false; 
   } 
   return true; 
}

function valid_alpha_digit(input)  //영문과 숫자만 가능
{
  var input = input.value;
  var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  for (var inx = 0; inx < input.length; inx++) {
    if (chars.indexOf(input.charAt(inx)) == -1) {
      return false;
    }
  }
  return true;
}

function valid_digit_dash(input) //숫자와 -만 가능
{ 
    var error_c=0, i, val; 
    for(i=0;i<valid_byte(input);i++) { 
        val = input.charAt(i); 
        if(!((val>=0 && val<=9) || (val=='-'))) return false; 
   } 
   return true; 
}

function valid_digit(input) 
{
    if(!fTrim(input.value)) return false; 
    var error_c=0, i, val; 
    for(i=0;i<valid_byte(input.value);i++) { 
	val = input.value.charAt(i); 
	if(!(val>='0' && val<='9')) {
		return false; 
	}
   } 
   return true; 
}


function valid_email(input) 
{
	var newstr = '';
	var at = false;
	var dot = false;
	var checkString = input.value;

	if ( checkString.length < 6 ){
		alert('이메일을 형식에 맞게 입력해 주세요!');
		obj_field.focus();
		return false;
	}

	if (checkString.indexOf('@') != -1) {
		at = true;
	} else if (checkString.indexOf('.') != -1) {
		dot = true;
	}

	for (var i = 0; i < checkString.length; i++) {
		ch = checkString.substring(i, i + 1);
		
		if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z')|| (ch == '@') || (ch == '.') || (ch == '_')|| (ch == '-') || (ch >= '0' && ch <= '9')) {
			newstr += ch;
			if (ch == '@') {
				at=true;
			}
			if (ch == '.') {
				dot=true;
			}
		} else {
			at = false;
			dot = false;
			break;
  		}
	}
	
	if ((at == true) && (dot == true)) {
		return true;
	} else {
		// DISPLAY ERROR MESSAGE
		return false;
	}
}


function valid_email2(checkString, obj, obj_field, opt)
{
	var newstr = '';
	var at = false;
	var dot = false;

	if ( checkString.length < 6 ){
		alert('이메일을 형식에 맞게 입력해 주세요!');
		obj_field.focus();
		return false;
	}

	if (checkString.indexOf('@') != -1) {
		at = true;
	} else if (checkString.indexOf('.') != -1) {
		dot = true;
	}

	for (var i = 0; i < checkString.length; i++) {
		ch = checkString.substring(i, i + 1);
		
		if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z')|| (ch == '@') || (ch == '.') || (ch == '_')|| (ch == '-') || (ch >= '0' && ch <= '9')) {
			newstr += ch;
			if (ch == '@') {
				at=true;
			}
			if (ch == '.') {
				dot=true;
			}
		} else {
			at = false;
			dot = false;
			break;
  		}
	}
	
	if ((at == true) && (dot == true)) {
		if(opt == 1)
		{
			if( DaumCheck(checkString) ){
				alert('한메일 주소가 아닌 메일주소를 입력해주세요!');
				obj_field.focus();
				return false;
			}
		}
		return newstr;
	}
	else {
		// DISPLAY ERROR MESSAGE
		alert ('email 형식에 어긋납니다\n\n 공백이나 형식에 어긋난 형식에 어긋난 특수문자가 있는지 \n \n 확인후 email을 다시 입력해 주세요!');
		obj_field.focus();
		return false;
	}
}

// 주민등록번호체크( 입력폼 2개) 
function valid_iden1(input1, input2) 
{ 
	input1.value=fTrim(input1.value); 
	input2.value=fTrim(input2.value); 
	var left_j=input1.value; 
	var right_j=input2.value; 
	if(left_j.length != 6) { 
			input1.value = "";
			input1.focus(); 
			return false; 
	} 
	if(right_j.length != 7) { 
			input2.value = "";
			input2.focus(); 
			return false; 
	} 
	var i2=0; 
	for(var i=0;i<left_j.length;i++) { 
			var temp=left_j.substring(i,i+1); 
			if(temp<0 || temp>9)  i2++; 
	} 
	if((left_j==  '') || (i2 != 0)) { 
			input1.value = "";
			input1.focus(); 
			return false; 
	} 
	var i3=0; 
	for(var i=0;i<right_j.length;i++) { 
			var temp=right_j.substring(i,i+1); 
			if (temp<0 || temp>9) i3++; 
	} 
	if((right_j==  '') || (i3 != 0)) { 
			input2.value = "";
			input2.focus(); 
			return false; 
	} 
	var l1=left_j.substring(0,1); 
	var l2=left_j.substring(1,2); 
	var l3=left_j.substring(2,3); 
	var l4=left_j.substring(3,4); 
	var l5=left_j.substring(4,5); 
	var l6=left_j.substring(5,6); 
	var hap=l1*2+l2*3+l3*4+l4*5+l5*6+l6*7; 
	var r1=right_j.substring(0,1); 
	var r2=right_j.substring(1,2); 
	var r3=right_j.substring(2,3); 
	var r4=right_j.substring(3,4); 
	var r5=right_j.substring(4,5); 
	var r6=right_j.substring(5,6); 
	var r7=right_j.substring(6,7); 
	hap=hap+r1*8+r2*9+r3*2+r4*3+r5*4+r6*5; 
	hap=hap%11; 
	hap=11-hap; 
	hap=hap%10; 
	if(hap != r7) { 
			input2.value = "";
			input2.focus(); 
			return false; 
	} 
	return true; 
} 

function valid_date(DateValue)
{
	var validstr = "0123456789";
	var Datevalue = "";
	var DateTemp = "";
	var seperator = ".";
	var day;
	var month;
	var year;
	var leap = 0;
	var err = 0;
	var i;
	err = 0;
	/* 숫자가 아닌 문자 삭제 */
	for (i = 0; i < DateValue.length; i++) {
				if (validstr.indexOf(DateValue.substr(i,1)) >= 0) {
					 DateTemp = DateTemp + DateValue.substr(i,1);
				}
	}
	DateValue = DateTemp;

	/* 날짜를 여덟자리로 변환*/
	/* 연도가 2자리로 입력 된다면 20 을 추가 */
	if (DateValue.length!=8) return false;

	//if (DateValue.length == 6) {
	//	DateValue = '20' + DateValue.substr(0,6); }
	//if (DateValue.length != 8) {
	//	err = 19;}

	/* 년도가 0000 으로 입력되는지 체크 */
	year = DateValue.substr(0,4);
	if (year == 0) {
		err = 20;
	}
	/* 월의 유효성 체크 */
	month = DateValue.substr(4,2);
	if ((month < 1) || (month > 12)) {
		err = 21;
	}
	/* 날짜의 유효성 체크 */
	day = DateValue.substr(6,2);
	if (day < 1) {
	 err = 22;
	}
	/* 윤년/2월 체크 */
	if ((year % 4 == 0) || (year % 100 == 0) || (year % 400 == 0)) {
		leap = 1;
	}
	if ((month == 2) && (leap == 1) && (day > 29)) {
		err = 23;
	}
	if ((month == 2) && (leap != 1) && (day > 28)) {
		err = 24;
	}
	/* 기타 월의 유효성 체크  */
	if ((day > 31) && ((month == "01") || (month == "03") || (month == "05") || (month == "07") || (month == "08") || (month == "10") || (month == "12"))) {
		err = 25;
	}
	if ((day > 30) && ((month == "04") || (month == "06") || (month == "09") || (month == "11"))) {
		err = 26;
	}
	/* 00 입력시 입력내용 삭제 */
	if ((day == 0) && (month == 0) && (year == 00)) {
		err = 0; day = ""; month = ""; year = ""; seperator = "";
	}
	/* 에러가 없다면 날짜 출력 */
	if (err == 0) {
		return true;
	}
	else {
		return false;
	}
}

// 이미지 검사
function valid_image(input) 
{
	var extArray = new Array(".gif", ".jpg");
	var file = input.value;
	allowSubmit = false;
	if(!file) {
		return allowSubmit;
	}
	while(file.indexOf("\\") != -1) {
		file = file.slice(file.indexOf("\\") + 1);
	}
	ext = file.slice(file.indexOf(".")).toLowerCase();

	for(var i = 0; i < extArray.length; i++) {
		if (extArray[i] == ext) { allowSubmit = true; break; }
	}

	return allowSubmit;
}

//아이디 한글체크시작
function withHangul (str) {
    var retCode = 0
    
    for (var i = 0; i < str.length; i++) {
        var code = str.charCodeAt(i)
        var ch = str.substr(i,1).toUpperCase()
        
        code = parseInt(code)
        
        if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))) {
            return true;
        }
    }
    return false;
}
//아이디 한글체크 끝

// 특수문자 체크
function checkAllSpecialChar(expression)
{
   var strSpecial = "`~!@#$%^&*()_+|\;\\/:=-<>.'\"";
 
   for(var i=0;i<expression.length;i++)
   {
    for(var j=0;j<strSpecial.length;j++)
    {
      if(expression.charAt(i) == strSpecial.charAt(j))
      {
		return false;   // 특수문자가 있으면.. false값을 돌려보냅니다.
      }
    }
   }

   return true;
}
function checkSpecialChar(expression, delemeter)
{
   var strSpecial = delemeter;
   for(var i=0;i<expression.length;i++)
   {
    for(var j=0;j<strSpecial.length;j++)
    {
      if(expression.charAt(i) == strSpecial.charAt(j))
      {
		return false;   // 특수문자가 있으면.. false값을 돌려보냅니다.
      }
    }
   }

   return true;
}

//특수문자 <, >를 WBN1, WBN2로 변경하기
function f_replace(expression) {
  return expression.replace(/</gi,"WNB1").replace(/>/gi,"WNB2");
}

//<P>&nbsp;</P>, <P>, </P>태그 없애기
function f_weas_replace(expression) {
  return expression.replace(/<\/P>/gi,'').replace(/<P>/gi,'').replace(/&nbsp;/gi,' ');
} 

//null체크
function isNull(obj){
	return (( typeof(obj) == "undefined") || ( obj == null ) ); 
}

function isNullStr(value){
	return ( (isNull(value)) || value.length == 0);
}

