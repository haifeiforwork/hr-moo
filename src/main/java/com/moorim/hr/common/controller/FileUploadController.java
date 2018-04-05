package com.moorim.hr.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.TextUtil;

@Controller
public class FileUploadController {

	private static Logger log = LoggerFactory.getLogger(FileUploadController.class);
	
	private String filePath = "D:\\mr_work\\moorim-hr\\src\\main\\webapp\\upload";
	
    @RequestMapping(value="/upload", method=RequestMethod.GET)
    public @ResponseBody String provideUploadInfo() {
        return "You can upload a file by posting to this same URL.";
    }

    @RequestMapping(value="/upload", method=RequestMethod.POST)
    public @ResponseBody String handleFileUpload(@RequestParam("name") String name,
            @RequestParam("file") MultipartFile file){
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                BufferedOutputStream stream =
                        new BufferedOutputStream(new FileOutputStream(new File(name)));
                stream.write(bytes);
                stream.close();
                return "You successfully uploaded " + name + "!";
            } catch (Exception e) {
                return "You failed to upload " + name + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload " + name + " because the file was empty.";
        }
    }
    
    /**
     * Upload multiple file using Spring Controller
     */
    @RequestMapping(value = "/uploadMultipleFile", method = RequestMethod.POST)
    public @ResponseBody
    String uploadMultipleFileHandler(@RequestParam("name") String[] names,
            @RequestParam("file") MultipartFile[] files) {
 
        if (files.length != names.length)
            return "Mandatory information missing";
 
        String message = "";
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String name = names[i];
            try {
                byte[] bytes = file.getBytes();
 
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File(rootPath + File.separator + "tmpFiles");
                if (!dir.exists())
                    dir.mkdirs();
 
                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + name);
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();
 
                log.info("Server File Location="
                        + serverFile.getAbsolutePath());
 
                message = message + "You successfully uploaded file=" + name
                        + "<br />";
            } catch (Exception e) {
                return "You failed to upload " + name + " => " + e.getMessage();
            }
        }
        return message;
    }
    
    /**
     * Upload multiple file using Spring Controller
     */
    @RequestMapping(value = "/uploadMultipleFileReg", method = RequestMethod.POST)
    public String uploadMultipleFile(HttpServletRequest request,
            ModelMap model) {
    	filePath = request.getSession().getServletContext().getRealPath("/") + "upload";
    	
    	
    	String result = "success";
    	int real_total = 0;
        String message = "";
        String[] ext = {"jpg","jpeg","gif","png","bmp","tif","hwp","xls","xlsx","doc","docx","ppt","pptx","pdf","txt","mp3","wma","wav","mid","asf","avi","mpg","mpeg","wmv","mp4","asf","flv","rm","zip"};

        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

        Map<String, Object> returnMap = null;
        try{
        	returnMap = FileUtil.setFileMakeToList(multipartHttpServletRequest, filePath, ext);
        }catch(Exception e){
        	returnMap.put("result", "error");
        }
      
        
        model.addAttribute("returnMap", returnMap);
        model.addAttribute("list", returnMap.get("list"));
        return "common/fileUploader";
    }
    
    /**
     * FileDownLoad
     */
    @RequestMapping(value = "/downLoadFile")
    public void dowLoadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	filePath = request.getSession().getServletContext().getRealPath("/") + "upload";
    	
    	request.setCharacterEncoding("utf-8");
    	String file_sysname = TextUtil.replace(CheckNull.checkString(request.getParameter("fileSysName")), "/" ,"" ); //file system name
    	String file_dir = CheckNull.checkString(request.getParameter("fileSavePath")); //down directory
    	String display_name = java.net.URLEncoder.encode( TextUtil.replace( TextUtil.enToKr(CheckNull.checkString( request.getParameter("fileName") )), " ", "_" ), "utf-8");
    	//String display_name = CheckNull.checkString( request.getParameter("fileName") );
    	//display_name = URLDecoder.decode(URLDecoder.decode(display_name, "8859_1"), "UTF-8");
    	String file_name = filePath + File.separator + file_dir + File.separator + file_sysname;
    	log.debug("file_name:"+file_name);
    	log.debug("file_name:"+display_name);

    	
    	try {
    		File file = new File(file_name);
    		if( !file.isFile() || display_name.equals("") ) {
    			file = new File( filePath + File.separator + "error.txt");
    			display_name = "error.txt";
    		}
    		
    		//change WNB40, WNB41, WNB35 to (, ), #
    		display_name = TextUtil.replace( display_name, "WNB40", "(" );
    		display_name = TextUtil.replace( display_name, "WNB41", ")" );
    		display_name = TextUtil.replace( display_name, "WNB35", "#" );
    		
    		response.reset();
    		response.setHeader("Content-Disposition", "attachment;filename=\"" + display_name + "\"");
    		response.setHeader("Content-type", "application/octer-stream");
    		response.setHeader("Content-Treansper-Encoding", "binary");
    		response.setHeader("Pargma","no-cache");
    		response.setHeader("Expires","-1");
    		
    		response.setContentLength((int)file.length());
    	
    		byte[] data = new byte[1024 * 1024];
    		BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));
    		BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
    	
    		int count = 0;
    		while((count = fis.read(data))!= -1){
    			fos.write(data, 0, count);
    		}
    	
    		if(fis !=null) fis.close();
    		if(fos != null) fos.close();
    	
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }

}
