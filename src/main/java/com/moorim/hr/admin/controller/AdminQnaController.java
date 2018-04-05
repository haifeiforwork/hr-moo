package com.moorim.hr.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.client.service.QnaService;
import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class AdminQnaController {
	private static Logger log = LoggerFactory.getLogger(AdminQnaController.class);
	
	@Autowired
	private QnaService qnaService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	@RequestMapping(value= "/admin/qnaList")
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
			}
			map.put("FILEDOWN", fileDown);
			rsList.set(i, map);
		}
		
		
		int cnt = qnaService.cntQna(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/qna/qnaList";
	}
	
	
	
	@RequestMapping(value = "/admin/qnaDetail")
	public String qnaDetail(ModelMap model, @ModelAttribute("paging") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		Map rs = qnaService.detailQna(vo);
		
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();
		Vector fileSize = new Vector();
		Vector fileType = new Vector();

		if(rs != null){
			String fileInfo = (String)rs.get("FILEINFO");
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
		
		model.addAttribute("vo", vo);
		model.addAttribute("rs", rs);
		model.addAttribute("fileView", TextUtil.getFileDownload(realFileName, systemFileName, null, "qna", false) );
		
		
		return "/admin/qna/qnaDetail";
		
	}
	
	@RequestMapping( value = "/admin/qnaProcess", method = RequestMethod.POST)
	public ModelAndView processQna(QnaVO vo, HttpServletRequest request) throws Exception
	{
		vo.setMOD_ID(SessionUtil.getHomeLoginId(request));
		vo.setMOD_NAME(SessionUtil.getHomeLoginName(request));

		resultMap = new HashMap();
		resultMap = qnaService.processQna(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
}
