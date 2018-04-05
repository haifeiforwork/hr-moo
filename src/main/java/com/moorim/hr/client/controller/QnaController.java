package com.moorim.hr.client.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.client.service.QnaService;
import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.service.SmsSendService;
import com.moorim.hr.common.vo.EmailVO;
import com.moorim.hr.common.vo.PagingCommonVO;
import com.moorim.hr.common.vo.SmsVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class QnaController {
	private static Logger log = LoggerFactory.getLogger(QnaController.class);
	 
	@Autowired
	private QnaService qnaService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	
	
	@RequestMapping(value= "/client/qnaList")
	public String selectQnaList(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		
		@SuppressWarnings("rawtypes")
		List<Map> rsList = qnaService.listQna(vo);
		
		for(int i=0; i<rsList.size();i++){
			Map map = rsList.get(i);
			String fileInfo = (String)map.get("ATT_FILE");
			log.debug("fileinfo:"+fileInfo);
			String fileDown = "";
			if(fileInfo != null && !"".equals(fileInfo)){
				fileDown = TextUtil.getFileDownload(fileInfo, "qna", true, false);
				log.debug("fileDown");
			}
			map.put("FILEDOWN", fileDown);
			rsList.set(i, map);
		}
		
		
		int cnt = qnaService.cntQna(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/client/qna/qnaList";
	}
	
	
	
	@RequestMapping(value = "/client/qnaDetail")
	public String qnaDetail(ModelMap model, @ModelAttribute("paging") PagingCommonVO vo
			, HttpServletRequest request) throws Exception
	{
		
		Map rs = qnaService.detailQna(vo);
		
		qnaService.updateViewQna(vo);
		
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();
		Vector fileSize = new Vector();
		Vector fileType = new Vector();

		if(rs != null){
			String fileInfo = (String)rs.get("ATT_FILE");
			if(fileInfo != null){
				List fileList = TextUtil.getFileInfo(fileInfo);
				if(fileList != null){
					for(int i=0; i<fileList.size(); i++){
						Map fileMap = (Map) fileList.get(i);
						realFileName.addElement(CheckNull.checkString((String)fileMap.get("file_realname")));
						systemFileName.addElement(CheckNull.checkString((String)fileMap.get("file_sysname")));
					}
				}
			}
		}
		
		String f1 = TextUtil.getFileDownload(realFileName, systemFileName, null, "qna", false);
		log.debug("===========fileDown"+f1);
		model.addAttribute("vo", vo);
		model.addAttribute("rs", rs);
		model.addAttribute("fileView", f1 );
		
		
		
		return "/client/qna/qnaDetail";
		
	}
	
	@RequestMapping(value = "/client/qnaPwd")
	public String qnaPwdView(ModelMap model, @ModelAttribute("paging") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		model.addAttribute("vo", vo);
		return "/client/qna/qnaPwdView";
		
	}
	
	@RequestMapping(value = "/client/qnaPwdCheck")
	public ModelAndView qnaPwdCheck(QnaVO qnaVo, HttpServletRequest request) throws Exception
	{
		int cnt = qnaService.pwdQna(qnaVo);
		resultMap = new HashMap();
		if(cnt==0) {
			resultMap.put("result", "FAIL");
			resultMap.put("msg", "패스워드가 맞지 않습니다.");
		} else {
			resultMap.put("result", "SUCCESS");
			resultMap.put("msg", "");
			
		}
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
	}
	
	@RequestMapping(value = "/client/qnaWrite")
	public String qnaWrite(ModelMap model, @ModelAttribute("paging") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		String idx = request.getParameter("idx");
		vo.setIdx(idx);
		
		String procType = "mod";
		Map rs = new HashMap();
		if("".equals(idx) || idx == null) {
			procType = "new";
		} else {
			rs = qnaService.detailQna(vo);
			if(rs == null) {
				procType = "new";
			}
		}
		log.debug("=======procType:"+procType);
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();
		Vector fileSize = new Vector();
		Vector fileType = new Vector();

		if(rs != null){
			String fileInfo = (String)rs.get("ATT_FILE");
			if(fileInfo != null){
				List fileList = TextUtil.getFileInfo(fileInfo);
				if(fileList != null){
					for(int i=0; i<fileList.size(); i++){
						Map fileMap = (Map) fileList.get(i);
						realFileName.addElement(CheckNull.checkString((String)fileMap.get("file_realname")));
						systemFileName.addElement(CheckNull.checkString((String)fileMap.get("file_sysname")));
						fileSize.addElement(CheckNull.checkString((String)fileMap.get("file_size")));
						fileType.addElement(CheckNull.checkString((String)fileMap.get("file_type")));
					}
				}
			}
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("procType", procType);
		model.addAttribute("rs", rs);
		model.addAttribute("fileUpload", TextUtil.getFileUpload(1, realFileName, systemFileName, fileSize, fileType, "qna", true, false));
		
		return "/client/qna/qnaWrite";
		
	}
	
	@RequestMapping( value = "/client/qnaProcess", method = RequestMethod.POST)
	public ModelAndView processQna(QnaVO vo, HttpServletRequest request) throws Exception
	{
    	resultMap = new HashMap();
		resultMap = qnaService.processQna(vo);
		
		log.debug(resultMap.toString());
		
		log.debug("lock_yn ================:"+vo.getLOCK_YN());
		log.debug("---------------["+vo.getProcType()+"]");
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
}
