<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.moorim.hr.common.CheckNull" %>
<%@ page import="com.moorim.hr.common.FileUtil" %>
<%@ page import="com.moorim.hr.common.TextUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
	boolean isOK = true;
	MultipartRequest multi = null;
	String fileName = "";
	
	
	String path = session.getServletContext().getRealPath("/");
	String tempPath = path + File.separator + "upload";
	File saveFolder = new File(tempPath);
	if(!saveFolder.exists() || saveFolder.isFile()){
		saveFolder.mkdirs();
	}
	String url = "";
	
	try {
		// 파일 업로드 MultipartRequest
		multi = new MultipartRequest(
			request
			, tempPath
			, 1024 * 1024 * 5 //10M
			, "utf-8"
			, new DefaultFileRenamePolicy()
		);
		String callback = CheckNull.checkString(multi.getParameter("callback"),"callback.html");
		String callback_func = CheckNull.checkString(multi.getParameter("callback_func"));
		url = callback + "?callback_func=" + callback_func;
		
		fileName = multi.getFilesystemName("Filedata"); //실제파일명
		if( fileName != null && !fileName.equals("") ) {
			StringTokenizer st = new StringTokenizer(fileName,".");
			String file_type = "";
		    while( st.hasMoreTokens() ) {
				file_type = st.nextToken();
		    }
			String file_sysname = Long.toString( System.currentTimeMillis()) + "." + file_type;
			
			//이미지명 변경하기
			String result = "";
			String save_file_name = "";
			String save_folder = tempPath + File.separator + "editor";
			saveFolder = new File(save_folder);
			if(!saveFolder.exists() || saveFolder.isFile()){
				saveFolder.mkdirs();
			}
			
			String ori_file = tempPath + File.separator + fileName; //upload/editor에 저장된 파일명
			String target_file = save_folder + File.separator + file_sysname; ///upload/editor에 저장될 파일명

			HashMap<String, String> resultMap = FileUtil.setFileRename( ori_file, target_file, true );
			if( resultMap != null && !resultMap.isEmpty() ) {
				result = TextUtil.getHashMap(resultMap, "result");
				save_file_name = TextUtil.getHashMap(resultMap, "fileSysName");
			}
			
			if( result.equals("success") ) {
				fileName = save_file_name; //이미지 보이는 url 경로 이름
				
				out.print(fileName);
			} else {
				isOK = false;
			}
		}
	}
	catch (Exception e)
	{
		e.printStackTrace();
		isOK = false;
	}
	finally
	{
		if( isOK ) {
			url = url + "&bNewLine=true";
			url = url + "&sFileName=" + fileName;
			url = url + "&sFileURL=/upload/editor/" + fileName;
			response.sendRedirect(url);
		} else {
%>
<script type="text/javascript">
	alert('이미지 파일을 업로드하는 중 에러가 발생했습니다');
</script>
<%
		}
	}
	return;
%>