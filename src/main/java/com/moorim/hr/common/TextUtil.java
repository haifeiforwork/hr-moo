package com.moorim.hr.common;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Vector;

public class TextUtil
{
    public static String enToKr(String str) {
    	
    	try {
       		return new String(str.getBytes("8859_1"), "UTF-8");
        } catch (Exception e) {
            return "";
        }
    }

    public static String krToEn(String str) {
        try {
            return new String(str.getBytes("euc-kr"), "ISO-8859-1");
        } catch (Exception e) {
            return "";
        }
    }

	public static String[] strToArry(String str, int nSize)
	{
		String[] arrStr;

		try {
			// news_contents 테이블에 데이터 nSize자씩 잘라서 입력하기
			int a=str.length()/nSize;
			int b=str.length()%nSize;
			int end=0;
			if(b > 0)
				end=a+1;

			arrStr = new String[end];

			//sub_contents nSize 분할하기
			int k=0,l=nSize;
			for(int m=0; m<end; m++) {//현재 분할 될 갯수 만큼 내용을 분할한다.
				if(end!=1) {
					if(m!=(arrStr.length-1)) {
						arrStr[m]=str.substring(k,l);
						k+=nSize;
						l+=nSize;
					}else {
						arrStr[m]=str.substring(k);
					}
				} else {
					arrStr[m]=str;
				}
			}
			return arrStr;
		} catch(Exception e) {
			return null;
		}
	}

    public static String replace(String strData, String s1, String s2)
    {
        if(strData != null) {
            for(int i = 0; (i = strData.indexOf(s1, i)) >= 0; i += s2.length())
                strData = strData.substring(0, i) + s2 + strData.substring(i + s1.length());
        } else {
            strData = "";
        }
        return strData;
    }
    
    public static String replaceNormal(String strData) {
        if( strData != null ) {
        	strData = replace(strData,"#","&#35;");
        	strData = replace(strData,"<","&lt;");
        	strData = replace(strData,">","&gt;");
        	//strData = replace(strData,"(","&#40;");
        	//strData = replace(strData,")","&#41;");
        	strData = replace(strData,"\"","&quot;");
        } else {
            strData = "";
        }
        return strData;
    }
    
    public static String replaceEditor(String strData) {
        if( strData != null ) {
        	strData = lowerCaseReplace(strData,"<script","&lt;script");
        	strData = lowerCaseReplace(strData,"<meta","&lt;meta");
        	strData = lowerCaseReplace(strData,"<iframe","&lt;iframe");
        	strData = lowerCaseReplace(strData,"<p>&nbsp;</p>","<p>&nbsp;&nbsp;</p>");
        } else {
            strData = "";
        }
        return strData;
    }
    
    public static String replacetextarea(String strData) {
    	if( strData != null ) {
            //보안을 위해 다음의 문자는 변경함
        	strData = replace(strData,"&#35;","#");
        	strData = replace(strData,"&lt;","<");
        	strData = replace(strData,"&gt;",">");
        	//strData = replace(strData,"&#40;","(");
        	//strData = replace(strData,"&#41;",")");
        	strData = replace(strData,"&quot;","\""); 
        } else {
            strData = "";
        }
        return strData;
    }  
    
    public static String lowerCaseReplace(String strData, String s1, String s2) {
        if( strData != null ) {
        	String strData2 = strData.toLowerCase();
        	for( int i = 0; (i = strData2.indexOf(s1, i)) >= 0; i += s2.length() ) {
                strData2 = strData2.substring(0, i) + s2 + strData2.substring(i + s1.length());
                strData = strData.substring(0, i) + s2 + strData.substring(i + s1.length());
            }
        } else {
            strData = "";
        }
        return strData;
    }
    
    public static String uni2Ksc(String s)
    {
        if(s == null)
            return null;
        try
        {
            return new String(s.getBytes("8859_1"), "KSC5601");
        }
        catch(Exception _ex)
        {
            return null;
        }
    }

    public static String ksc2Uni(String s)
    {
        if(s == null)
            return null;
        try
        {
          return new String(s.getBytes("KSC5601"), "8859_1");
        }
        catch(Exception _ex)
        {
            return null;
        }
    }    
    /**
     * 문자열을 mode 값에 따라 치환
     * param str => 치환할 문자열
     * param mode => 치환형태 값
     * mode => 1 html 출력형태
     * mode => 2 html 출력형태를 html
     * mode => 3 text 를 db 입력형태
     * mode => 4 db 입력형태 를 text
     * mode => 5 공백 문자를 tag(" " -> &nbsp; "\n" -> <br>
     * mode => 6 tag를 공백문자(<br> -> "\n" &nbsp; -> " "
     */
    public static String replaceMode(String str, int mode)
    {
        switch (mode) {
        case 1:
            str = replace(replace(str, "<", "&lt;"), "\n", "<br>");

            break;

        case 2:
            str = replace(replace(str, "&lt;", "<"), "<br>", "\n");

            break;

        case 3:
            str = replace(str, "'", "''");
            str = replace(str, "\"", "&quot;");

            break;

        case 4:
            str = replace(str, "''", "'");
            str = replace(str, "&quot;", "\"");

            break;

        case 5:
            str = replace(str, "\n", "<br>");

            break;

        case 6:
            str = replace(str, "&nbsp;", " ");
            str = replace(str, "<br>", " ");

            break;
        }

        return str;
    }

	public static String toDB(String s)
	{
		if(realString(s).equals(""))
			return "";
		int i = s.length();
		int j = 0;
		int i1 = 0;
		int j1 = 0;
		int k1 = 0;
		for(int k = 0; k < i; k++)
			if(s.charAt(k) == '\n')
				j++;
			else
			if(s.charAt(k) == '\'')
				i1++;
			else
			if(s.charAt(k) == '<' || s.charAt(k) == '>')
				j1++;
			else
			if(s.charAt(k) == '\t')
				k1++;

		StringBuffer stringbuffer = new StringBuffer(i + j * 3 + j1 * 3 + k1 * 11 + i1 * 6);
		for(int l = 0; l < i; l++)
			if(s.charAt(l) == '\n')
				stringbuffer.append("<br>");
			else
			if(s.charAt(l) == '\'')
				stringbuffer.append("&lsquo;");
			else
			if(s.charAt(l) == '>')
				stringbuffer.append("&gt;");
			else
			if(s.charAt(l) == '<')
				stringbuffer.append("&lt;");
			else
			if(s.charAt(l) == '\t')
				stringbuffer.append("&nbsp;&nbsp;");
			else
				stringbuffer.append(s.charAt(l));

		return stringbuffer.toString();
	}

	public static String fromDB(String s)
	{
		if(realString(s).equals(""))
			return "";
		int i = s.length();
		StringBuffer stringbuffer = new StringBuffer(s);
		try
		{
			int j = 0;
			for(int k = 0; j < i; k++)
			{
				String s1;
				if(s.charAt(j) != '<' || (s1 = s.substring(j, j + 4)) == null || !s1.equalsIgnoreCase("<br>"))
					if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 7)) != null && s1.equalsIgnoreCase("&lsquo;"))
					{
						stringbuffer.replace(k, k + 7, "'");
						j += 6;
					}
					else
					if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 4)) != null && s1.equalsIgnoreCase("&gt;"))
					{
						stringbuffer.replace(k, k + 4, ">");
						j += 3;
					}
					else
					if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 4)) != null && s1.equalsIgnoreCase("&lt;"))
					{
						stringbuffer.replace(k, k + 4, "<");
						j += 3;
					}
					else
					if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 12)) != null && s1.equalsIgnoreCase("&nbsp;&nbsp;"))
					{
						stringbuffer.replace(k, k + 12, "\t");
						j += 11;
					}
				j++;
			}

		}
		catch(StringIndexOutOfBoundsException stringindexoutofboundsexception) {}
		String s2 = stringbuffer.toString();
		if(s2.endsWith("&gt;"))
			stringbuffer.replace(s2.length() - 4, s2.length(), ">");
		return stringbuffer.toString();
	}

	public static String fromDB2(String s)
	{
		if(realString(s).equals(""))
			return "";
		int i = s.length();
		StringBuffer stringbuffer = new StringBuffer(s);
		try
		{
			int j = 0;
			for(int k = 0; j < i; k++)
			{
				String s1;
				if(s.charAt(j) == '<' && (s1 = s.substring(j, j + 4)) != null && s1.equalsIgnoreCase("<br>"))
				{
					stringbuffer.replace(k, k + 4, "\n");
					j += 3;
				}
				else
				if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 7)) != null && s1.equalsIgnoreCase("&lsquo;"))
				{
					stringbuffer.replace(k, k + 7, "'");
					j += 6;
				}
				else
				if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 4)) != null && s1.equalsIgnoreCase("&gt;"))
				{
					stringbuffer.replace(k, k + 4, ">");
					j += 3;
				}
				else
				if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 4)) != null && s1.equalsIgnoreCase("&lt;"))
				{
					stringbuffer.replace(k, k + 4, "<");
					j += 3;
				}
				else
				if(s.charAt(j) == '&' && (s1 = s.substring(j, j + 12)) != null && s1.equalsIgnoreCase("&nbsp;&nbsp;"))
				{
					stringbuffer.replace(k, k + 12, "\t");
					j += 11;
				}
				j++;
			}

		}
		catch(StringIndexOutOfBoundsException stringindexoutofboundsexception) {}
		String s2 = stringbuffer.toString();
		if(s2.endsWith("&gt;"))
			stringbuffer.replace(s2.length() - 4, s2.length(), ">");
		return stringbuffer.toString();
	}

	public static String realString(String s)
	{
		if(s == null || s.equalsIgnoreCase("null") || s.equals("") || s.startsWith("Error in"))
			return "";
		else
			return s;
	}

	/**
	   * 지정한 길이 보다 길경우 지정한 길이에서 자른후 "..."을 붙여 준다.
	   * 그보다 길지 않을때는 그냥 돌려준다. char 단위로 계산 (한글도 1자)
	   * @param str 원본 String
	   * @param amount String 의 최대 길이 (이보다 길면 이 길이에서 자른다)
	   * @return String 변경된 내용
	*/
	public static String crop(String str, int amount) {
		if (str==null) return "";
		String result = str;
		if(result.length()>amount) result=result.substring(0,amount)+"...";
		return result;
	}

	/**
	   * 지정한 길이 보다 길경우 지정한 길이에서 자른후 맨뒷부분에 지정한 문자열을 붙여 준다.
	   * 그보다 길지 않을때는 그냥 돌려준다. char 단위로 계산 (한글도 1자)
	   * @param str 원본 String
	   * @param amount String 의 최대 길이 (이보다 길면 이 길이에서 자른다)
	   * @param trail amount 보다 str 이 길경우 amount 만큼만 자른다음 trail 을 붙여 준다.
	   * @return String 변경된 내용
	*/
	public static String crop(String str, int amount, String trail) {
		if (str==null) return "";
		String result = str;
		if(result.length()>amount) result=result.substring(0,amount)+trail;
		return result;
	}

	/**
	   * 지정한 길이 보다 길경우 지정한 길이에서 자른후 맨뒷부분에 지정한 문자열을 붙여 준다.
	   * 그보다 길지 않을때는 그냥 돌려준다. Byte 단위로 계산 (한글 = 2자)
	   * <p>
	   * @param str 원본 String
	   * @param amount String 의 최대 길이 (이보다 길면 이 길이에서 자른다)
	   * @param trail amount 보다 str 이 길경우 amount 만큼만 자른다음 trail 을 붙여 준다.
	   * @return String 변경된 내용
	*/
	public static String cropByte(String str, int amount, String trail) throws Exception {
		if (str==null) return "";
		String tmp = str;
		int slen = 0, blen = 0;
		char c;
		if(tmp.getBytes("euc-kr").length>amount) {
			while (blen+1 < amount) {
				c = tmp.charAt(slen);
				blen++;
				slen++;
				if ( c  > 127 ) blen++;  //2-byte character..
			}
			tmp=tmp.substring(0,slen)+trail;
		}
		return tmp;
	}	

	/**
	* 체크박스,라디오버튼,셀렉트박스 checked or selected
	*/
	public static String getChecked(String s,String word) {
		return s.equals(word) ? "checked" : "";
	}
	public static String getSelected(String s,String word) {
		return s.equals(word) ? "selected" : "";
	}
	public static String getChecked(int s,int w) {
		return (s==w)? "checked" : "";
	}
	public static String getSelected(int s,int w) {
		return (s==w)? "selected" : "";
	}

	public static String checkMessageBack(String msg){
		StringBuffer strbf = new StringBuffer();
		strbf.append("<script language=\"javascript\">\n").append("alert(\"" + msg +"\");\n");
		strbf.append("history.back();\n").append("</script>");
		return strbf.toString();
	}

	public static String checkMessageClose(String msg){
		StringBuffer strbf = new StringBuffer();
		strbf.append("<script language=\"javascript\">\n").append("alert(\"" + msg +"\");\n");
		strbf.append("window.close();\n").append("</script>");
		return strbf.toString();
	}

	public static String checkMessage(String msg){
		StringBuffer strbf = new StringBuffer();
		strbf.append("<script language=\"javascript\">\n").append("alert(\"" + msg +"\");\n");
		strbf.append("</script>");
		return strbf.toString();
	}

	public static String checkMessageLink(String msg, String linkStr){
		StringBuffer strbf = new StringBuffer();
		strbf.append("<script language=\"javascript\">\n");
		if(!CheckNull.checkString(msg).equals("")) {
			strbf.append("alert(\"" + msg +"\");\n");
		}
		strbf.append("document.location.href=\""+linkStr +"\"");
		strbf.append("</script>");
		return strbf.toString();
	}

	public static String urlLink(String top, String linkStr){
		StringBuffer strbf = new StringBuffer();
		strbf.append("<script language=\"javascript\">\n");
		if(!CheckNull.checkString(top).equals("")) {
			strbf.append("document.location.href=\""+linkStr +"\"");
		} else {
			if(top.equals("top")) {
				strbf.append("top.location.href=\""+linkStr +"\"");
			} else {
				strbf.append("document.location.href=\""+linkStr +"\"");
			}
		}
		strbf.append("</script>");
		return strbf.toString();
	}
	
	/**
	 * getHash
	 * @param retMap
	 * @param argsStr
	 * @return
	 */
	public static String getHashMap(HashMap<String,String> retMap, String argsStr) {
		if( retMap == null ) return ""; 
		else return retMap.get(argsStr) == null ? "" : retMap.get(argsStr).trim();
	}

	/**
	 * getHash, if null or '' then replace replace String
	 * @param retMap
	 * @param argsStr
	 * @param replaceStr
	 * @return
	 */
	public static String getHashMap(HashMap<String,String> retMap, String argsStr, String replaceStr) {
		if( retMap == null ) return ""; 
		else return retMap.get(argsStr) == null || retMap.get(argsStr).equals("") ? replaceStr : retMap.get(argsStr).trim();
	}
	
	public static String getSize(long filesize) {
        String fSize = "";
        DecimalFormat df = new DecimalFormat(".##");
        
        if ((filesize > 1024) && (filesize < (1024 * 1024))) {
            fSize = df.format((float) filesize / 1024).toString() + " KB";
        } else if (filesize >= (1024 * 1024)) {
            fSize = df.format((float) filesize / (1024 * 1024)).toString() + " MB";
        } else {
            fSize = Long.toString(filesize) + " Bytes";
        }

        return fSize;
	}
	
	/**
	 * File Write Module
	 * @param file_total : total file count
	 * @param left : upload image location
	 * @param realFileName : hanguel file name
	 * @param systemFileName : system file name
	 * @param fileSize : file size
	 * @param fileType : file type
	 * @param dir : file save directory
	 * @param btn_yn : button on yes / no
	 * @param fileDown_yn : file download yes / no
	 * @return
	 */
	public static String getFileUpload( int file_total, Vector realFileName, Vector systemFileName, Vector fileSize, Vector fileType, String dir, boolean btn_yn, boolean fileDown_yn ) {
		if( file_total < 1 || dir.equals("") ) return "";
		
		StringBuffer sb = new StringBuffer();
		
		try {
			int max_file_no = 1; //open file count
			String[] arr_file_no = new String[file_total];
			String[] arr_file_sysname = new String[file_total];
			String[] arr_file_name = new String[file_total];
			String[] arr_file_type = new String[file_total];
			String[] arr_file_size = new String[file_total];
			String[] arr_file_info = new String[file_total];
			if( systemFileName != null && systemFileName.size() > 0 ) {
				for( int i=0; i<systemFileName.size(); i++ ) {
					int idx = i + 1;
					if( idx > max_file_no ) max_file_no = idx;
					
					arr_file_no[ idx - 1 ] = idx + "";
					arr_file_sysname[ idx - 1 ] = systemFileName.elementAt(i).toString();
					arr_file_name[ idx - 1 ] = realFileName.elementAt(i).toString();
					arr_file_type[ idx - 1 ] = fileType.elementAt(i).toString();
					arr_file_size[ idx - 1 ] = fileSize.elementAt(i).toString();
					
					arr_file_info[ idx - 1 ] = 
						arr_file_sysname[ idx - 1 ] + "*" +
						arr_file_name[ idx - 1 ] + "*" + 
						arr_file_size[ idx - 1 ] + "*" +
						arr_file_type[ idx - 1 ];
				}
			}
			
			sb.append("<img id=\"img_ATTMSG\" name=\"ATTMSG\" src=\"/resources/images/common/save.gif\" width=\"245\" height=\"85\" style=\"position:absolute;z-index:1;left:20px;visibility:hidden;\" title=\"\" alt=\"\" />\n");
			sb.append("<iframe id=\"frame_fileInputFrame\" name=\"fileInputFrame\" width=\"0\" height=\"0\" style=\"display:none;\"></iframe>\n");
			sb.append("<input type=\"hidden\" id=\"hidden_file_total\" name=\"file_total\" value=\""+ file_total +"\"/>\n");
			sb.append("<input type=\"hidden\" id=\"hidden_file_count\" name=\"file_count\" value=\""+ max_file_no +"\"/><!-- open file count -->\n");
			sb.append("<input type=\"hidden\" id=\"hidden_file_dir\" name=\"file_dir\" value=\""+ dir +"\" />\n");
			
			for( int i=0; i<max_file_no; i++ ) {
				sb.append("<div id=\"div_file_pack"+ (i+1) +"\" style=\"display:block;float:left;width:98%;\">\n");
				if( arr_file_no[i] != null && !arr_file_no[i].equals("") ) { //exist file
					sb.append("	<input type=\"hidden\" id=\"hidden_fileUplaodChk"+ (i+1) +"\" name=\"fileUplaodChk"+ (i+1) +"\" value=\"U\" />\n");
					sb.append("	<input type=\"hidden\" id=\"hidden_file_info"+ (i+1) +"\" name=\"file_info"+ (i+1) +"\" value=\""+ TextUtil.replaceNormal(arr_file_info[i]) +"\" />\n");
				} else {
					sb.append("	<input type=\"hidden\" id=\"hidden_fileUplaodChk"+ (i+1) +"\" name=\"fileUplaodChk"+ (i+1) +"\" value=\"\" />\n");
					sb.append("	<input type=\"hidden\" id=\"hidden_file_info"+ (i+1) +"\" name=\"file_info"+ (i+1) +"\" value=\"\" />\n");
				}
				sb.append("	<div style=\"float:left;width:80%;\">\n");
				if( arr_file_no[i] != null && !arr_file_no[i].equals("") ) { //exist file 
					sb.append("		<div id=\"div_file_display"+ (i+1) +"1\" style=\"display:block;width:100%;height:22px;\">\n");
					if( fileDown_yn ) {
						sb.append("			<div style=\"padding-top:2px;float:left;\"><a href=\"/includes/common/fileDownloader.jsp?fileSysName="+ TextUtil.replaceNormal(arr_file_sysname[i]) +"&fileName=" + TextUtil.replaceNormal( arr_file_name[i] )+ "&fileSavePath=" + dir + "\">" + TextUtil.replaceNormal( arr_file_name[i] ) +" [" + arr_file_size[i] +"]</a></div>\n");
					} else {
						sb.append("			<div style=\"padding-top:2px;float:left;\">"+ TextUtil.replaceNormal( arr_file_name[i] ) +" [" + arr_file_size[i] +"]</div>\n");
					}
					sb.append("			<img src=\"/resources/images/common/icon_delete.gif\" alt=\"\" style=\"padding-top:3px;padding-left:5px;float:left;cursor:pointer;\" onclick=\"javascript:fn_deleteFileExist("+ (i+1) +");\"/>\n");
					sb.append("		</div>\n");
					sb.append("		<div id=\"div_file_display"+ (i+1) +"2\" style=\"display:none;width:100%;height:22px;\">\n");
					sb.append("			<input type=\"file\" id=\"file_input_file"+ (i+1) +"\" name=\"input_file"+ (i+1) +"\" class=\"search\" style=\"border:1px solid #e5e5e5;background-color:#ffffff;font-size:12px;color:#666666;width:100%;height:18px;\">\n");
					sb.append("		</div>\n");
				} else {
					sb.append("		<div id=\"div_file_display"+ (i+1) +"1\" style=\"display:none;width:100%;height:22px;\">\n");
					sb.append("			<div style=\"padding-top:2px;float:left;\">Attach File</div>\n");
					sb.append("		</div>\n");
					sb.append("		<div id=\"div_file_display"+ (i+1) +"2\" style=\"display:block;width:100%;height:22px;\">\n");
					sb.append("			<input type=\"file\" id=\"file_input_file"+ (i+1) +"\" name=\"input_file"+ (i+1) +"\" class=\"search\" style=\"border:1px solid #e5e5e5;background-color:#ffffff;font-size:12px;;color:#666666;width:100%;height:22px;line-height:18px;\">\n");
					sb.append("		</div>\n");
				}
				sb.append("	</div>\n");
				sb.append("	<div style=\"float:left;width:20%;\">\n");
				if( i == 0 && btn_yn ) { //add file, delete button
					sb.append("		<img src=\"/resources/images/common/btn_fileadd.gif\" alt=\"\" style=\"padding-top:1px;padding-left:5px;float:left;cursor:pointer;\" onclick=\"javascript:fn_insertFile();\"/>\n");
					sb.append("		<img src=\"/resources/images/common/btn_filedel.gif\" alt=\"\" style=\"padding-top:1px;padding-left:2px;padding-right:4px;float:left;cursor:pointer;\" onclick=\"javascript:fn_deleteFile();\"/>\n");
				}
				sb.append("	</div>\n");
				sb.append("</div>\n");
			}
			//fill file count
			for( int i=max_file_no; i<file_total; i++ ) {
				sb.append("<div id=\"div_file_pack"+ (i+1) +"\" style=\"display:none;float:left;width:98%;padding-top:2px;\">\n");
				sb.append("	<input type=\"hidden\" id=\"hidden_fileUplaodChk"+ (i+1) +"\" name=\"fileUplaodChk"+ (i+1) +"\" value=\"\" />\n");
				sb.append("	<input type=\"hidden\" id=\"hidden_file_info"+ (i+1) +"\" name=\"file_info"+ (i+1) +"\" value=\"\" />\n");
				sb.append("	<div style=\"float:left;width:80%;\">\n");
				sb.append("		<div id=\"div_file_display"+ (i+1) +"1\" style=\"display:none;width:100%;height:22px;\">\n");
				sb.append("			<div style=\"padding-top:5px;float:left;\">Attach File</div>\n");
				sb.append("		</div>\n");
				sb.append("		<div id=\"div_file_display"+ (i+1) +"2\" style=\"display:block;width:100%;height:22px;\">\n");
				sb.append("			<input type=\"file\" id=\"file_input_file"+ (i+1) +"\" name=\"input_file"+ (i+1) +"\" class=\"search\" style=\"border:1px solid #e5e5e5; background-color:#ffffff;font-size:12px;;color:#666666;width:100%;height:22px;line-height:18px;\">\n");
				sb.append("		</div>\n");
				sb.append("	</div>\n");
				sb.append("	<div style=\"float:left;width:20%;\">\n");
				sb.append("	</div>\n");
				sb.append("</div>\n");
			}
			
		} catch ( Exception e ) {
			return "";
		}
		
		return sb.toString();
	}
	
	/**
	 * getFileDownload
	 * @param fileIntro : file information
	 * @param downDir : file directory
	 * @param imgYn : image display yes or no
	 * @param sizeYn : file size display yes or no
	 * @return
	 */
	public static String getFileDownload( String fileIntro, String downDir, boolean imgYn, boolean sizeYn  ) throws Exception {
		String downStr = "";
		
		if( fileIntro == null || fileIntro.equals("") || downDir == null || downDir.equals("") ) {
			return "";
		}
		
		//find file information
		ArrayList<HashMap<String,String>> retFileList = TextUtil.getFileInfo( fileIntro );
		if( retFileList == null ) return "";
		
		for( int i=0; i<retFileList.size(); i++ ) {
			HashMap<String,String> fileMap = retFileList.get(i);
			downStr += "<a class=\"file\" href=\"/downLoadFile?fileSysName=" + TextUtil.replaceNormal(TextUtil.getHashMap(fileMap,"file_sysname"));
			//downStr += "&fileName=" + java.net.URLEncoder.encode(TextUtil.replaceNormalFile(TextUtil.getHashMap(fileMap,"file_realname"), false), "UTF-8");
			downStr += "&fileName=" + TextUtil.replaceNormalFile(TextUtil.getHashMap(fileMap,"file_realname"), false);
			downStr += "&fileSavePath=" + downDir + "\">";
			if( imgYn ) {
				downStr += TextUtil.replaceNormalFile(TextUtil.getHashMap(fileMap,"file_realname"), true);
				if( sizeYn ) {
					downStr += " [" + TextUtil.replaceNormal(TextUtil.getHashMap(fileMap,"file_size")) +"]";
				}
//				downStr += "<img src=\"/resources/images/icon/" + getFileType( TextUtil.replaceNormal(TextUtil.getHashMap(fileMap,"file_type")) ) + ".gif\" style=\"vertical-align:middle;\">";	
			} else {
				downStr += TextUtil.replaceNormalFile(TextUtil.getHashMap(fileMap,"file_realname"), true);
				if( sizeYn ) {
					downStr += " [" + TextUtil.replaceNormal(TextUtil.getHashMap(fileMap,"file_size")) +"]";
				}
			}
			if( imgYn ) {
				downStr += "</a>";
			} else {
				downStr += "</a> ";
			}
		}
		return downStr;
	}
	
	/**
	 * getFileDownload
	 * @param realFileName : file hangul vector
	 * @param systemFileName : file sysName vector
	 * @param fileSize : file size vector, null allowed
	 * @param downDir : download directory
	 * @param sizeYn : file size display yes or no
	 * @return
	 */
	public static String getFileDownload( Vector realFileName, Vector systemFileName, Vector fileSize, String downDir, boolean sizeYn ) {
		String downStr = "";
		
		if( realFileName == null || realFileName.isEmpty() || systemFileName == null || systemFileName.isEmpty() || downDir == null || downDir.equals("") ) {
			return "";
		}
		
		//find file information
		try {
			for( int i=0; i<systemFileName.size(); i++ ) {
				downStr += "<a href=\"/downLoadFile?fileSysName=" + TextUtil.replaceNormal(systemFileName.elementAt(i).toString());
				downStr += "&fileName=" + TextUtil.replaceNormalFile(realFileName.elementAt(i).toString(), false);
				downStr += "&fileSavePath=" + downDir + "\">";
				downStr += TextUtil.replaceNormalFile(realFileName.elementAt(i).toString(), true);
				if( sizeYn ) {
					if( fileSize != null ) {
						downStr += " [" + TextUtil.replaceNormal(fileSize.elementAt(i).toString()) + "]";
					}
				}
				downStr += "</a>&nbsp";
				if( i != systemFileName.size() - 1 ) {
					downStr += "&nbsp";
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		return downStr;
	}
	
	/**
	 * getFileDownload
	 * @param realFileName
	 * @param systemFileName
	 * @param fileSize
	 * @param downDir
	 * @param sizeYn
	 * @return
	 */
	public static String getFileDownload( String realFileName, String systemFileName, String fileSize, String downDir, boolean sizeYn ) {
		String downStr = "";
		
		if( realFileName == null || realFileName.equals("") || systemFileName == null || systemFileName.equals("") || downDir == null || downDir.equals("") ) {
			return "";
		}
		
		//find file information
		try {
			downStr += "<a href=\"/includes/common/fileDownloader.jsp?fileSysName=" + TextUtil.replaceNormal(systemFileName);
			downStr += "&fileName=" + TextUtil.replaceNormalFile(realFileName, false);
			downStr += "&fileSavePath=" + downDir + "\">";
			downStr += TextUtil.replaceNormalFile(realFileName, true);
			if( sizeYn ) {
				if( fileSize != null ) {
					downStr += " [" + TextUtil.replaceNormal(fileSize) + "]";
				}
			}
			downStr += "</a>&nbsp";
		} catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		return downStr;
	}
	
	/**
	 * replaceNormal change special character <,>,#
	 * @param strData
	 * @return
	 */
	public static String replaceNormalFile(String strData, boolean isChange) {
        if( strData != null ) {
        	if( isChange ) {
            	strData = replace(strData,"&#40;","(");
            	strData = replace(strData,"&#41;",")");
            	strData = replace(strData,"&#35;","#");
        	} else {
            	strData = replace(strData,"&#40;","WNB40");
            	strData = replace(strData,"&#41;","WNB41");
            	strData = replace(strData,"&#35;","WNB35");
        	}
        } else {
            strData = "";
        }
        return strData;
    }

	/**
	 * find file type img
	 * @param file_type
	 * @return
	 */
	public static String getFileType( String file_type ) {
		String[] arr_filetype = {"doc", "exe", "gif", "hwp", "jpg", "pdf", "ppt", "txt", "xls", "zip", "etc", "docx", "xlsx", "pptx"};
		String returnValue= "etc";
		for(int i=0; i<arr_filetype.length; i++) {
			if(arr_filetype[i].equals(file_type.toLowerCase())) {
				returnValue =  arr_filetype[i];
				break;
			}
		}

		//office 2007 over
		if(returnValue.equals("docx")) returnValue="doc";
		else if(returnValue.equals("xlsx")) returnValue="xls";
		else if(returnValue.equals("pptx")) returnValue="ppt";
		
		return returnValue;
	}
	
	/**
	 * getFileInfo return ArraList : file_no, file_sysname, file_realname, file_type, file_size
	 * @param fileInfo
	 * @return
	 */
	public static ArrayList<HashMap<String,String>> getFileInfo( String fileInfo ) {
		ArrayList<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
		if( fileInfo == null || fileInfo.equals("") ) return null;
		
		try {
			String[] arr_file = fileInfo.split("[|]");
			for( int i=0; i<arr_file.length ; i++ ) {
				String[] arr_file_sub = arr_file[i].split("[*]");
				
				HashMap<String,String> fileMap = new HashMap<String,String>();
				fileMap.put("file_sysname", arr_file_sub[0]);
				fileMap.put("file_realname", arr_file_sub[1]);
				fileMap.put("file_size", arr_file_sub[2]);
				fileMap.put("file_type", getFileType(arr_file_sub[3]));
				
				fileList.add(fileMap);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		return fileList;
	}
	
	public static String getPercent( String topData, String bottomData ) {
		if( bottomData == null || topData == null || bottomData.equals("") || bottomData.equals("0") ) return "0";
		try {
			int n_topData = CheckNull.checkInt(topData);
			int n_bottomData = CheckNull.checkInt(bottomData);
		
			int n_percent = n_topData * 100 / n_bottomData;
			if( n_percent > 100 ) {
				n_percent = 100;
			}
		
			return n_percent + "";
		} catch( Exception e ) {
			return "0";
		}
	}
	
	public static String getFormat( String str ) {
		if( str == null ) return "";
		try {
			NumberFormat formatter = new DecimalFormat("#,###");
			double tempF = Double.parseDouble(str);
			
			str = formatter.format(tempF);
		} catch( Exception e ) {
			str = "";
		}
		return str;
	}
	
	public static String getFormatNumber( int inputVal ) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("00");
		return df.format(inputVal);
	}

	public static String getLectureName( String lectureIdx ) {
		String returnVal = "담당과목";
		String[] lectureNumber = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"};
		String[] lectureNumberName = {"국어","영어","수학","역사","지리","한문","일반사회","제2외국어","윤리","음악","기술","컴퓨터","실업","과학","기타","미술","체육","가정"};
		
		for( int i=0; i<lectureNumber.length; i++ ) {
			if( lectureIdx.equals( lectureNumber[i] ) ) {
				returnVal = lectureNumberName[i];
				break;
			}
		}
		return returnVal;	
	}
	
	public static String getTeacherGrade( String gradeIdx ) {
		String returnVal = "교사자격등급";
		String[] gradeNumber = {"101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140"};
		String[] gradeNumberName = {
			"초등1급정교사","초등2급정교사","초등준교사","중등1급정교사","중등2급정교사"
			,"중등준교사","특수1급정교사","특수2급정교사","초등교감","중등교감"
			,"고등교감","초등교장","중등교장","고등교장","양호교사1급"
			,"양호교사2급","유치원1급 정교사","유치원2급 정교사","기타","유치원원감"
			,"유치원원장","전문상담교사2급","사서교사2급","보건교사2급","영양교사2급"
			,"전문상담교사1급","사서교사1급","보건교사1급","영양교사1급","특수준교사"
			,"유치원준교사","치료교사1급","치료교사2급","교수","교육전문직"
			,"교육연구사","장학사","보건교사","사서교사","수석교사"
		};
		
		for( int i=0; i<gradeNumber.length; i++ ) {
			if( gradeIdx.equals( gradeNumber[i] ) ) {
				returnVal = gradeNumberName[i];
				break;
			}
		}
		return returnVal;	
	}
	
	public static String[] getTeacherGradeArr() {
		String[] gradeNumber = {
			"101","102","103","104","105"
			,"106","107","108"
			,"130"
			,"120"
			,"109","110","111"
			,"121"
			,"112","113","114","115","116","117","118"
			,"131"
			,"122","123","124","125","126","127","128","129"
			,"132","133","134","135","136","137","138","139","140"
			,"119"
		};
		return gradeNumber;
	}
	
	public static String getAge(String birth) {
		
		if(birth == null || birth.length() < 8) {
			return null;
		}
		
		int bYear = Integer.parseInt(birth.substring(0, 4));
		int bMonth = Integer.parseInt(birth.substring(5, 6));
		int bDay = Integer.parseInt(birth.substring(7, 8));
		
		Calendar current = Calendar.getInstance();
		int cYear = current.get(Calendar.YEAR);
		int cMonth = current.get(Calendar.MONTH) + 1;
		int cDay = current.get(Calendar.DAY_OF_MONTH);
		
		int age = cYear - bYear;
		if(bMonth*100 + bDay > cMonth*100 + cDay) age--;
		
		return String.valueOf(age);
		
	}
}
